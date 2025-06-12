from fastapi import APIRouter, UploadFile, File, HTTPException
from fastapi.responses import JSONResponse
import os
import shutil
import pandas as pd
from typing import List
import zipfile
import io

router = APIRouter()

# 确保上传目录存在
UPLOAD_DIR = "app/static/uploads"
os.makedirs(UPLOAD_DIR, exist_ok=True)

def extract_zip_to_dir(zip_content, target_dir):
    """解压ZIP文件到目标目录，处理嵌套目录问题"""
    with zipfile.ZipFile(io.BytesIO(zip_content)) as zip_ref:
        # 获取所有文件列表
        file_list = zip_ref.namelist()
        
        # 检查是否有嵌套目录
        has_nested_dir = any('/' in f for f in file_list)
        
        if has_nested_dir:
            # 创建临时目录
            temp_dir = os.path.join(target_dir, "temp_extract")
            os.makedirs(temp_dir, exist_ok=True)
            
            # 解压到临时目录
            zip_ref.extractall(temp_dir)
            
            # 移动文件到正确位置
            for root, dirs, files in os.walk(temp_dir):
                for file in files:
                    if file.endswith(('.jpg', '.png')):
                        src_path = os.path.join(root, file)
                        dst_path = os.path.join(target_dir, file)
                        shutil.move(src_path, dst_path)
            
            # 清理临时目录
            shutil.rmtree(temp_dir)
        else:
            # 直接解压到目标目录
            zip_ref.extractall(target_dir)

@router.post("/upload/dataset")
async def upload_dataset(
    labels_file: UploadFile = File(...),
    train_zip: UploadFile = File(...),
    test_zip: UploadFile = File(None)  # 测试集可选
):
    """上传数据集（标签文件和训练/测试图片压缩包）"""
    try:
        # 创建数据集目录
        dataset_name = "kaggle_dog_tiny"  # 固定数据集名称
        dataset_dir = os.path.join(UPLOAD_DIR, dataset_name)
        
        # 如果目录已存在，先删除
        if os.path.exists(dataset_dir):
            shutil.rmtree(dataset_dir)
        
        os.makedirs(dataset_dir, exist_ok=True)
        
        # 保存标签文件
        labels_path = os.path.join(dataset_dir, "labels.csv")
        with open(labels_path, "wb") as buffer:
            shutil.copyfileobj(labels_file.file, buffer)
        
        # 创建训练集和测试集目录
        train_dir = os.path.join(dataset_dir, "train")
        test_dir = os.path.join(dataset_dir, "test")
        os.makedirs(train_dir, exist_ok=True)
        os.makedirs(test_dir, exist_ok=True)
        
        # 解压训练集图片
        train_zip_content = await train_zip.read()
        extract_zip_to_dir(train_zip_content, train_dir)
        
        # 如果提供了测试集，解压测试集图片
        if test_zip:
            test_zip_content = await test_zip.read()
            extract_zip_to_dir(test_zip_content, test_dir)
        
        # 验证数据集
        try:
            df = pd.read_csv(labels_path)
            train_images = [f for f in os.listdir(train_dir) if f.endswith(('.jpg', '.png'))]
            test_images = [f for f in os.listdir(test_dir) if f.endswith(('.jpg', '.png'))]
            
            print("训练集目录内容:", os.listdir(train_dir))
            print("训练集图片:", train_images)
            print("标签文件中的ID:", df['id'].values)
            
            # 检查标签文件中的图片是否都在训练集中
            missing_images = set(df['id'].values) - set([f.split('.')[0] for f in train_images])
            if missing_images:
                return JSONResponse(
                    status_code=400,
                    content={
                        "error": f"训练集不完整，缺少 {len(missing_images)} 张图片",
                        "missing_images": list(missing_images)
                    }
                )
            
            return {
                "message": "数据集上传成功",
                "dataset_name": dataset_name,
                "train_images": len(train_images),
                "test_images": len(test_images),
                "total_labels": len(df),
                "breeds": sorted(df['breed'].unique().tolist())
            }
            
        except Exception as e:
            return JSONResponse(
                status_code=400,
                content={"error": f"数据集验证失败: {str(e)}"}
            )
            
    except Exception as e:
        return JSONResponse(
            status_code=500,
            content={"error": f"上传失败: {str(e)}"}
        )

@router.post("/upload/image")
async def upload_image(file: UploadFile = File(...)):
    """上传单张图片用于预测"""
    try:
        # 验证文件类型
        if not file.content_type.startswith('image/'):
            return JSONResponse(
                status_code=400,
                content={"error": "只支持图片文件"}
            )
        
        # 保存图片到临时目录
        temp_dir = os.path.join(UPLOAD_DIR, "temp")
        os.makedirs(temp_dir, exist_ok=True)
        
        file_path = os.path.join(temp_dir, file.filename)
        with open(file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)
        
        return {
            "message": "图片上传成功",
            "file_path": file_path
        }
        
    except Exception as e:
        return JSONResponse(
            status_code=500,
            content={"error": f"上传失败: {str(e)}"}
        )

@router.get("/datasets")
async def list_datasets():
    """列出所有已上传的数据集"""
    try:
        datasets = []
        if os.path.exists(UPLOAD_DIR):
            for item in os.listdir(UPLOAD_DIR):
                if os.path.isdir(os.path.join(UPLOAD_DIR, item)):
                    dataset_path = os.path.join(UPLOAD_DIR, item)
                    labels_path = os.path.join(dataset_path, "labels.csv")
                    
                    if os.path.exists(labels_path):
                        df = pd.read_csv(labels_path)
                        train_dir = os.path.join(dataset_path, "train")
                        test_dir = os.path.join(dataset_path, "test")
                        print(train_dir)
                        print(test_dir)
                        train_images = [f for f in os.listdir(train_dir) if f.endswith(('.jpg', '.png'))] if os.path.exists(train_dir) else []
                        test_images = [f for f in os.listdir(test_dir) if f.endswith(('.jpg', '.png'))] if os.path.exists(test_dir) else []
                        
                        datasets.append({
                            "name": item,
                            "train_images": len(train_images),
                            "test_images": len(test_images),
                            "total_labels": len(df),
                            "breeds": sorted(df['breed'].unique().tolist())
                        })
        
        return {"datasets": datasets}
        
    except Exception as e:
        return JSONResponse(
            status_code=500,
            content={"error": f"获取数据集列表失败: {str(e)}"}
        )