import asyncio
import json
import os

import torch
import torch.nn as nn
import torch.optim as optim
from fastapi import APIRouter
from fastapi.responses import JSONResponse, StreamingResponse
from torch.utils.data import DataLoader
from torchvision import transforms

from app.services.dataset import DogBreedDataset
from app.services.model import DogBreedModel
from app.services.train_utils import train_epoch, validate

router = APIRouter()

# 训练配置
TRAIN_CONFIG = {
    "batch_size": 16,
    "num_epochs": 30,
    "learning_rate": 0.0001,
    "weight_decay": 1e-4
}

UPLOAD_DIR = "app/static/uploads"

async def generate_training_progress(model, train_loader, val_loader, criterion, optimizer, scheduler, device, num_epochs, dataset_name):
    """生成训练进度信息"""
    history = {
        "train_losses": [],
        "train_accuracies": [],
        "val_losses": [],
        "val_accuracies": []
    }
    
    best_val_acc = 0.0
    checkpoint_dir = os.path.join("app/static/models", dataset_name)
    os.makedirs(checkpoint_dir, exist_ok=True)
    
    for epoch in range(num_epochs):
        # 训练
        train_loss, train_acc = train_epoch(model, train_loader, criterion, optimizer, device)
        
        # 验证
        val_loss, val_acc = validate(model, val_loader, criterion, device)
        
        # 更新学习率
        scheduler.step(val_loss)
        
        # 记录历史
        history["train_losses"].append(train_loss)
        history["train_accuracies"].append(train_acc)
        history["val_losses"].append(val_loss)
        history["val_accuracies"].append(val_acc)
        
        # 保存检查点
        checkpoint = {
            "epoch": epoch + 1,
            "model_state_dict": model.state_dict(),
            "optimizer_state_dict": optimizer.state_dict(),
            "train_loss": train_loss,
            "val_loss": val_loss,
            "train_acc": train_acc,
            "val_acc": val_acc
        }
        
        # 保存最佳模型
        if val_acc > best_val_acc:
            best_val_acc = val_acc
            torch.save(
                checkpoint,
                os.path.join(checkpoint_dir, "best_model.pt")
            )
        
        # 保存当前检查点
        torch.save(
            checkpoint,
            os.path.join(checkpoint_dir, f"checkpoint_epoch_{epoch + 1}.pt")
        )
        
        # 生成进度信息
        progress = {
            "epoch": epoch + 1,
            "total_epochs": num_epochs,
            "train_loss": train_loss,
            "train_acc": train_acc,
            "val_loss": val_loss,
            "val_acc": val_acc,
            "learning_rate": optimizer.param_groups[0]['lr']
        }
        
        yield f"data: {json.dumps(progress)}\n\n"
        await asyncio.sleep(0.1)  # 避免发送太快
    
    # 保存最终模型
    model_path = os.path.join(checkpoint_dir, "final_model.pt")
    torch.save(model.state_dict(), model_path)
    
    # 保存训练历史
    history_path = os.path.join(checkpoint_dir, "training_history.json")
    with open(history_path, "w") as f:
        json.dump(history, f)
    
    # 发送训练完成消息
    yield f"data: {json.dumps({'status': 'completed', 'model_path': model_path})}\n\n"

@router.post("/train")
async def train_model(dataset_name: str):
    """训练模型"""
    try:
        # 设置设备
        device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
        print(f"使用设备: {device}")
        
        # 构建数据路径
        base_dir = os.path.join("app/static/uploads", dataset_name)
        print("数据集路径:", base_dir)
        labels_file = os.path.join("app/static/uploads",dataset_name, "labels.csv")
        print("标签文件存在:", os.path.exists(labels_file))
        train_dir = os.path.join(base_dir, "train")
        print("训练目录存在:", os.path.exists(train_dir))
        
        if not os.path.exists(labels_file) or not os.path.exists(train_dir):
            return JSONResponse(
                status_code=404,
                content={"error": "数据集不存在"}
            )
        
        # 数据变换
        train_transform = transforms.Compose([
            transforms.Resize((256, 256)),
            transforms.RandomCrop((224, 224)),
            transforms.RandomHorizontalFlip(p=0.5),
            transforms.RandomRotation(15),
            transforms.ColorJitter(brightness=0.2, contrast=0.2, saturation=0.2, hue=0.1),
            transforms.RandomAffine(degrees=0, translate=(0.1, 0.1)),
            transforms.ToTensor(),
            transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
        ])
        
        val_transform = transforms.Compose([
            transforms.Resize((224, 224)),
            transforms.ToTensor(),
            transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
        ])
        
        print("创建数据集...")
        # 创建数据集
        full_dataset = DogBreedDataset(labels_file, train_dir, train_transform)
        print(f"数据集大小: {len(full_dataset)}")
        print(f"类别数量: {full_dataset.get_num_classes()}")
        
        # 划分训练集和验证集
        train_size = int(0.8 * len(full_dataset))
        val_size = len(full_dataset) - train_size
        train_dataset, val_dataset = torch.utils.data.random_split(
            full_dataset, [train_size, val_size]
        )
        print(f"训练集大小: {train_size}, 验证集大小: {val_size}")
        
        # 为验证集设置不同的变换
        val_indices = val_dataset.indices
        val_dataset = torch.utils.data.Subset(
            DogBreedDataset(labels_file, train_dir, val_transform),
            val_indices
        )
        
        # 创建数据加载器
        train_loader = DataLoader(
            train_dataset,
            batch_size=TRAIN_CONFIG["batch_size"],
            shuffle=True,
            num_workers=0
        )
        val_loader = DataLoader(
            val_dataset,
            batch_size=TRAIN_CONFIG["batch_size"],
            shuffle=False,
            num_workers=0
        )
        
        print("创建模型...")
        # 创建模型
        model = DogBreedModel(full_dataset.get_num_classes()).to(device)
        
        # 定义损失函数和优化器
        criterion = nn.CrossEntropyLoss()
        optimizer = optim.AdamW(
            model.parameters(),
            lr=TRAIN_CONFIG["learning_rate"],
            weight_decay=TRAIN_CONFIG["weight_decay"]
        )
        
        # 学习率调度器
        scheduler = optim.lr_scheduler.ReduceLROnPlateau(
            optimizer,
            mode='min',
            factor=0.1,
            patience=3
        )
        
        print("开始训练...")
        return StreamingResponse(
            generate_training_progress(
                model, train_loader, val_loader, criterion, 
                optimizer, scheduler, device, TRAIN_CONFIG["num_epochs"],
                dataset_name
            ),
            media_type="text/event-stream"
        )
        
    except Exception as e:
        print(f"训练失败: {str(e)}")
        return JSONResponse(
            status_code=500,
            content={"error": f"训练失败: {str(e)}"}
        )

# @router.get("/train/status/{dataset_name}")
# async def get_training_status(dataset_name: str):
#     """获取训练状态"""
#     try:
#         checkpoint_dir = os.path.join("app/static/models", dataset_name)
#         if not os.path.exists(checkpoint_dir):
#             return JSONResponse(
#                 status_code=404,
#                 content={"error": "未找到训练记录"}
#             )
#
#         # 获取最新的检查点
#         checkpoints = [f for f in os.listdir(checkpoint_dir) if f.startswith("checkpoint_")]
#         if not checkpoints:
#             return {"status": "未开始训练"}
#
#         latest_checkpoint = max(checkpoints, key=lambda x: int(x.split("_")[-1].split(".")[0]))
#         checkpoint_path = os.path.join(checkpoint_dir, latest_checkpoint)
#
#         checkpoint = torch.load(checkpoint_path, map_location="cpu")
#
#         return {
#             "status": "训练中",
#             "current_epoch": checkpoint["epoch"],
#             "train_loss": checkpoint["train_loss"],
#             "val_loss": checkpoint["val_loss"],
#             "train_acc": checkpoint["train_acc"],
#             "val_acc": checkpoint["val_acc"]
#         }
#
#     except Exception as e:
#         return JSONResponse(
#             status_code=500,
#             content={"error": f"获取训练状态失败: {str(e)}"}
#         )
