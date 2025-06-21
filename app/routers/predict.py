import io
import os

import pandas as pd
import torch
from PIL import Image
from fastapi import APIRouter, UploadFile, File, Depends
from fastapi.responses import JSONResponse
from sqlalchemy.orm import Session
from torchvision import transforms

from app.database import get_db
from app.services.breed_service import breed_service
from app.services.model import DogBreedModel

router = APIRouter()

# 确保模型目录存在
MODEL_DIR = "app/static/models"
os.makedirs(MODEL_DIR, exist_ok=True)

def load_model(dataset_name: str):
    """加载模型"""
    try:
        # 获取类别数量
        labels_file = os.path.join("app/static/uploads",dataset_name, "labels.csv")
        if not os.path.exists(labels_file):
            raise FileNotFoundError("找不到标签文件")
        
        df = pd.read_csv(labels_file)
        num_classes = len(df['breed'].unique())
        
        # 创建模型实例
        model = DogBreedModel(num_classes)
        
        # 加载模型权重
        model_path = os.path.join(MODEL_DIR, dataset_name, "best_model.pt")
        if not os.path.exists(model_path):
            model_path = os.path.join(MODEL_DIR, dataset_name, "final_model.pt")
            if not os.path.exists(model_path):
                raise FileNotFoundError("找不到模型文件")
        
        checkpoint = torch.load(model_path, map_location="cpu")
        if isinstance(checkpoint, dict) and "model_state_dict" in checkpoint:
            model.load_state_dict(checkpoint["model_state_dict"])
        else:
            model.load_state_dict(checkpoint)
        
        model.eval()
        return model
    except Exception as e:
        raise Exception(f"加载模型失败: {str(e)}")

@router.post("/predict")
async def predict_image(
    image: UploadFile = File(...),
    dataset_name: str = "kaggle_dog_tiny",
    db: Session = Depends(get_db)
):
    """预测图片并返回详细品种信息"""
    try:
        # 读取图片
        contents = await image.read()
        img = Image.open(io.BytesIO(contents))
        
        # 图片预处理
        transform = transforms.Compose([
            transforms.Resize((224, 224)),
            transforms.ToTensor(),
            transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
        ])
        
        img_tensor = transform(img).unsqueeze(0)
        
        # 加载模型
        model = load_model(dataset_name)
        
        # 获取类别名称
        labels_file = os.path.join("app/static/uploads",dataset_name, "labels.csv")
        if not os.path.exists(labels_file):
            labels_file = "datas/kaggle_dog_tiny/kaggle_dog_tiny/labels.csv"
        
        df = pd.read_csv(labels_file)
        class_names = sorted(df['breed'].unique())
        
        # 预测
        with torch.no_grad():
            outputs = model(img_tensor)
            probabilities = torch.nn.functional.softmax(outputs, dim=1)[0]
            
            # 获取前5个预测结果
            top5_prob, top5_indices = torch.topk(probabilities, 5)
            
            predictions = []
            for prob, idx in zip(top5_prob, top5_indices):
                breed_name = class_names[idx]
                confidence = float(prob) * 100
                
                # 获取品种详细信息
                breed_db_info = breed_service.get_breed_by_name(db, breed_name)
                if breed_db_info:
                    breed_info = breed_db_info.to_dict()
                else:
                    # 如果数据库中没有，从静态数据获取
                    breed_info = breed_service.get_breed_info_dict(breed_name)
                    breed_info["id"] = None
                    breed_info["english_name"] = breed_name
                    breed_info["is_active"] = True
                
                predictions.append({
                    "breed": breed_name,
                    "confidence": confidence,
                    "breed_info": breed_info
                })
        
        return {
            "success": True,
            "predictions": predictions,
            "image_info": {
                "filename": image.filename,
                "size": len(contents),
                "format": img.format
            }
        }
        
    except Exception as e:
        return JSONResponse(
            status_code=500,
            content={
                "success": False,
                "error": f"预测失败: {str(e)}"
            }
        )

@router.get("/models")
async def list_models():
    """列出所有可用的模型"""
    try:
        models_dir = "app/static/models"
        if not os.path.exists(models_dir):
            return {"models": []}
        
        models = []
        for dataset_name in os.listdir(models_dir):
            dataset_path = os.path.join(models_dir, dataset_name)
            if os.path.isdir(dataset_path):
                model_files = [f for f in os.listdir(dataset_path) if f.endswith('.pt')]
                if model_files:
                    models.append({
                        "dataset": dataset_name,
                        "models": model_files
                    })
        
        return {"models": models}
        
    except Exception as e:
        return JSONResponse(
            status_code=500,
            content={"error": f"获取模型列表失败: {str(e)}"}
        )

@router.post("/init-breeds")
async def init_breed_database(db: Session = Depends(get_db)):
    """初始化品种数据库"""
    try:
        breed_service.init_breed_database(db)
        return {"success": True, "message": "品种数据库初始化成功"}
    except Exception as e:
        return JSONResponse(
            status_code=500,
            content={"success": False, "error": f"初始化失败: {str(e)}"}
        )

@router.get("/breeds")
async def get_all_breeds(db: Session = Depends(get_db)):
    """获取所有品种信息"""
    try:
        breeds = breed_service.get_all_breeds(db)
        return {
            "success": True,
            "breeds": [breed.to_dict() for breed in breeds],
            "count": len(breeds)
        }
    except Exception as e:
        return JSONResponse(
            status_code=500,
            content={"success": False, "error": f"获取品种列表失败: {str(e)}"}
        )

@router.get("/breeds/{breed_name}")
async def get_breed_by_name(breed_name: str, db: Session = Depends(get_db)):
    """根据品种名获取详细信息"""
    try:
        breed = breed_service.get_breed_by_name(db, breed_name)
        if breed:
            return {"success": True, "breed": breed.to_dict()}
        else:
            # 从静态数据获取
            breed_info = breed_service.get_breed_info_dict(breed_name)
            return {"success": True, "breed": breed_info}
    except Exception as e:
        return JSONResponse(
            status_code=500,
            content={"success": False, "error": f"获取品种信息失败: {str(e)}"}
        )