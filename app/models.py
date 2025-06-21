from sqlalchemy import Column, Integer, String, Text, DateTime, Boolean
from sqlalchemy.sql import func

from app.database import Base


class DogBreed(Base):
    """狗品种信息表"""
    __tablename__ = "dog_breeds"
    
    id = Column(Integer, primary_key=True, index=True)
    english_name = Column(String(100), unique=True, index=True, nullable=False, comment="英文品种名")
    chinese_name = Column(String(100), nullable=False, comment="中文品种名")
    description = Column(Text, comment="品种描述")
    characteristics = Column(Text, comment="品种特性")
    common_diseases = Column(Text, comment="常见疾病")
    temperament = Column(String(200), comment="性格特点")
    size_category = Column(String(50), comment="体型分类：小型/中型/大型/超大型")
    life_expectancy = Column(String(50), comment="预期寿命")
    origin_country = Column(String(100), comment="原产国")
    care_level = Column(String(50), comment="护理难度：简单/一般/困难")
    exercise_needs = Column(String(50), comment="运动需求：低/中/高")
    is_active = Column(Boolean, default=True, comment="是否启用")
    created_at = Column(DateTime(timezone=True), server_default=func.now(), comment="创建时间")
    updated_at = Column(DateTime(timezone=True), onupdate=func.now(), comment="更新时间")
    
    def to_dict(self):
        """转换为字典格式"""
        return {
            "id": self.id,
            "english_name": self.english_name,
            "chinese_name": self.chinese_name,
            "description": self.description,
            "characteristics": self.characteristics.split('；') if self.characteristics else [],
            "common_diseases": self.common_diseases.split('；') if self.common_diseases else [],
            "temperament": self.temperament,
            "size_category": self.size_category,
            "life_expectancy": self.life_expectancy,
            "origin_country": self.origin_country,
            "care_level": self.care_level,
            "exercise_needs": self.exercise_needs,
            "is_active": self.is_active
        } 