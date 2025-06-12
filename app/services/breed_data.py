from sqlalchemy.orm import Session
from app.database import SessionLocal
from app.models import DogBreed
from typing import Dict, Optional
import logging

logger = logging.getLogger(__name__)

# 默认品种信息字典，当数据库中没有对应信息时使用
DEFAULT_BREED_INFO = {
    "chihuahua": {
        "chinese_name": "吉娃娃",
        "description": "世界上最小的犬种之一，原产于墨西哥。体型虽小但性格活泼，对主人非常忠诚。",
        "characteristics": "体型小巧；大眼睛；耳朵竖立；毛发光滑或长毛",
        "common_diseases": "心脏病；膝盖骨脱位；低血糖；气管塌陷",
        "temperament": "活泼、机警、勇敢、忠诚",
        "size_category": "小型犬",
        "life_expectancy": "14-16年",
        "origin_country": "墨西哥",
        "care_level": "一般",
        "exercise_needs": "低"
    },
    "japanese_spaniel": {
        "chinese_name": "日本狮子狗",
        "description": "优雅的小型犬，具有日本贵族气质，性格温和友善。",
        "characteristics": "丝质长毛；扁平的面部；大眼睛；卷曲的尾巴",
        "common_diseases": "呼吸道问题；眼部疾病；心脏病",
        "temperament": "温和、优雅、安静、友善",
        "size_category": "小型犬",
        "life_expectancy": "12-14年",
        "origin_country": "日本",
        "care_level": "一般",
        "exercise_needs": "低"
    },
    "maltese_dog": {
        "chinese_name": "马尔济斯犬",
        "description": "古老的玩具犬种，拥有丝绸般的白色长毛，性格温柔可爱。",
        "characteristics": "纯白色长毛；小巧体型；黑色鼻子和眼睛；优雅步态",
        "common_diseases": "膝盖骨脱位；低血糖；牙齿问题；眼部疾病",
        "temperament": "温柔、活泼、友善、机警",
        "size_category": "小型犬",
        "life_expectancy": "12-15年",
        "origin_country": "马耳他",
        "care_level": "困难",
        "exercise_needs": "低"
    },
    "pekinese": {
        "chinese_name": "北京犬",
        "description": "中国古老的宫廷犬种，具有狮子般的外貌和高贵的气质。",
        "characteristics": "扁平的面部；长毛；短腿；卷曲的尾巴",
        "common_diseases": "呼吸道问题；眼部疾病；脊椎问题；皮肤病",
        "temperament": "独立、勇敢、忠诚、固执",
        "size_category": "小型犬",
        "life_expectancy": "12-14年",
        "origin_country": "中国",
        "care_level": "一般",
        "exercise_needs": "低"
    },
    "shih-tzu": {
        "chinese_name": "西施犬",
        "description": "中国西藏的古老犬种，拥有长而飘逸的毛发，性格友善温和。",
        "characteristics": "长而厚的双层被毛；短的口吻；大眼睛；卷曲的尾巴",
        "common_diseases": "呼吸道问题；眼部疾病；髋关节发育不良；耳部感染",
        "temperament": "友善、外向、活泼、温和",
        "size_category": "小型犬",
        "life_expectancy": "10-18年",
        "origin_country": "中国西藏",
        "care_level": "困难",
        "exercise_needs": "中"
    },
    "blenheim_spaniel": {
        "chinese_name": "布伦海姆西班牙猎犬",
        "description": "查理王小猎犬的一个颜色变种，具有优雅的外表和温和的性格。",
        "characteristics": "丝质长毛；栗色和白色毛色；大眼睛；长耳朵",
        "common_diseases": "心脏病；眼部疾病；神经系统疾病；耳部感染",
        "temperament": "温和、友善、活泼、适应性强",
        "size_category": "小型犬",
        "life_expectancy": "12-15年",
        "origin_country": "英国",
        "care_level": "一般",
        "exercise_needs": "中"
    },
    "papillon": {
        "chinese_name": "蝴蝶犬",
        "description": "以耳朵形状像蝴蝶翅膀而得名，是聪明活泼的小型犬。",
        "characteristics": "竖立的大耳朵；丝质长毛；小巧体型；羽毛状尾巴",
        "common_diseases": "膝盖骨脱位；牙齿问题；心脏病；眼部疾病",
        "temperament": "聪明、活泼、友善、机警",
        "size_category": "小型犬",
        "life_expectancy": "14-16年",
        "origin_country": "法国",
        "care_level": "一般",
        "exercise_needs": "中"
    },
    "toy_terrier": {
        "chinese_name": "玩具梗",
        "description": "小型的梗类犬，具有梗犬的勇敢性格和玩具犬的可爱外表。",
        "characteristics": "小巧体型；竖立的耳朵；短毛；机警的表情",
        "common_diseases": "膝盖骨脱位；气管塌陷；心脏病；低血糖",
        "temperament": "勇敢、机警、活泼、忠诚",
        "size_category": "小型犬",
        "life_expectancy": "13-15年",
        "origin_country": "英国",
        "care_level": "简单",
        "exercise_needs": "中"
    }
}

def get_breed_info_from_db(english_name: str) -> Optional[Dict]:
    """从数据库获取品种信息"""
    try:
        print(f"从数据库查询品种信息: {english_name}")
        db = SessionLocal()
        breed = db.query(DogBreed).filter(DogBreed.english_name == english_name).first()
        db.close()
        
        if breed:
            return breed.to_dict()
        return None
    except Exception as e:
        logger.error(f"从数据库查询品种信息失败: {str(e)}")
        return None

def get_breed_info(english_name: str) -> Dict:
    """
    获取品种信息，优先从数据库查询，如果没有则使用默认数据
    
    Args:
        english_name: 品种英文名
        
    Returns:
        品种信息字典
    """
    # 首先尝试从数据库获取
    db_info = get_breed_info_from_db(english_name)
    if db_info:
        return {
            "chinese_name": db_info["chinese_name"],
            "description": db_info["description"],
            "characteristics": "；".join(db_info["characteristics"]) if isinstance(db_info["characteristics"], list) else db_info["characteristics"],
            "common_diseases": "；".join(db_info["common_diseases"]) if isinstance(db_info["common_diseases"], list) else db_info["common_diseases"],
            "temperament": db_info["temperament"],
            "size_category": db_info["size_category"],
            "life_expectancy": db_info["life_expectancy"],
            "origin_country": db_info["origin_country"],
            "care_level": db_info["care_level"],
            "exercise_needs": db_info["exercise_needs"]
        }
    
    # 如果数据库中没有，使用默认数据
    default_info = DEFAULT_BREED_INFO.get(english_name.lower())
    if default_info:
        return default_info
    
    # 如果都没有，返回通用信息
    return {
        "chinese_name": english_name.replace("_", " ").title(),
        "description": f"这是一种名为{english_name}的犬种。",
        "characteristics": "体型特征待补充；毛发特征待补充；面部特征待补充",
        "common_diseases": "具体疾病信息待补充",
        "temperament": "性格特点待补充",
        "size_category": "中型犬",
        "life_expectancy": "12-15年",
        "origin_country": "待补充",
        "care_level": "一般",
        "exercise_needs": "中"
    }

def add_breed_to_db(breed_info: Dict) -> bool:
    """
    添加品种信息到数据库
    
    Args:
        breed_info: 品种信息字典，必须包含所有必要字段
        
    Returns:
        是否添加成功
    """
    try:
        db = SessionLocal()
        
        # 检查是否已存在
        existing = db.query(DogBreed).filter(
            DogBreed.english_name == breed_info["english_name"]
        ).first()
        
        if existing:
            logger.info(f"品种 {breed_info['english_name']} 已存在")
            db.close()
            return True
            
        # 创建新记录
        new_breed = DogBreed(
            english_name=breed_info["english_name"],
            chinese_name=breed_info["chinese_name"],
            description=breed_info["description"],
            characteristics=breed_info["characteristics"],
            common_diseases=breed_info["common_diseases"],
            temperament=breed_info["temperament"],
            size_category=breed_info["size_category"],
            life_expectancy=breed_info["life_expectancy"],
            origin_country=breed_info["origin_country"],
            care_level=breed_info["care_level"],
            exercise_needs=breed_info["exercise_needs"]
        )
        
        db.add(new_breed)
        db.commit()
        db.close()
        
        logger.info(f"成功添加品种: {breed_info['english_name']}")
        return True
        
    except Exception as e:
        logger.error(f"添加品种到数据库失败: {str(e)}")
        if 'db' in locals():
            db.rollback()
            db.close()
        return False

def get_all_breeds_from_db() -> list:
    """从数据库获取所有品种信息"""
    try:
        db = SessionLocal()
        breeds = db.query(DogBreed).filter(DogBreed.is_active == True).all()
        result = [breed.to_dict() for breed in breeds]
        db.close()
        return result
    except Exception as e:
        logger.error(f"从数据库获取所有品种失败: {str(e)}")
        return [] 