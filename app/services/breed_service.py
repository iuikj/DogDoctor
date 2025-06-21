import os

import pandas as pd
from sqlalchemy.orm import Session

from app.database import SessionLocal
from app.models import DogBreed
from app.services.breed_data import get_breed_info


class BreedService:
    """品种信息服务类"""
    
    def get_breed_info_dict(self, english_name: str) -> dict:
        """根据英文名获取品种信息"""
        db = SessionLocal()
        try:
            db_breed = self.get_breed_by_name(db, english_name)
            if db_breed:
                return db_breed.to_dict()
            else:
                # 如果数据库中没有，返回默认信息
                return get_breed_info(english_name)
        finally:
            db.close()
    
    def init_breed_database(self, db: Session):
        """初始化品种数据库"""
        try:
            # 检查是否已有数据
            existing_count = db.query(DogBreed).count()
            if existing_count > 0:
                print(f"数据库中已存在 {existing_count} 条品种记录")
                return
            
            # 读取标签文件
            labels_file = "datas/kaggle_dog_tiny/kaggle_dog_tiny/labels.csv"
            if not os.path.exists(labels_file):
                labels_file = "app/static/uploads/labels.csv"
            
            if not os.path.exists(labels_file):
                print("未找到标签文件")
                return
            
            df = pd.read_csv(labels_file)
            unique_breeds = df['breed'].unique()
            
            # 插入品种数据
            for breed in unique_breeds:
                breed_info = get_breed_info(breed)
                
                db_breed = DogBreed(
                    english_name=breed,
                    chinese_name=breed_info['chinese_name'],
                    description=breed_info['description'],
                    characteristics=breed_info['characteristics'],
                    common_diseases=breed_info['common_diseases'],
                    temperament=breed_info['temperament'],
                    size_category=breed_info['size_category'],
                    life_expectancy=breed_info['life_expectancy'],
                    origin_country=breed_info['origin_country'],
                    care_level=breed_info['care_level'],
                    exercise_needs=breed_info['exercise_needs']
                )
                db.add(db_breed)
            
            db.commit()
            print(f"成功初始化 {len(unique_breeds)} 个品种的数据")
            
        except Exception as e:
            db.rollback()
            print(f"初始化品种数据失败: {str(e)}")
    
    def get_breed_by_name(self, db: Session, english_name: str) -> DogBreed:
        """根据英文名获取品种数据库记录"""
        return db.query(DogBreed).filter(DogBreed.english_name == english_name).first()
    
    def get_all_breeds(self, db: Session):
        """获取所有品种"""
        return db.query(DogBreed).filter(DogBreed.is_active == True).all()

# 创建全局实例
breed_service = BreedService() 