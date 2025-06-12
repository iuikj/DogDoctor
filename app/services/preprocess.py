import cv2
import numpy as np
from PIL import Image
import albumentations as A
from rembg import remove
import io

class ImagePreprocessor:
    def __init__(self):
        # 定义图像增强pipeline
        self.enhancement_pipeline = A.Compose([
            A.RandomBrightnessContrast(p=0.5),
            A.Sharpen(p=0.5),
            A.GaussNoise(p=0.3),
            A.HorizontalFlip(p=0.5),
        ])
        
        # 标准尺寸
        self.target_size = (224, 224)
    
    def enhance_image(self, image):
        """图像增强"""
        if isinstance(image, Image.Image):
            image = np.array(image)
        
        # 应用增强pipeline
        enhanced = self.enhancement_pipeline(image=image)
        return enhanced['image']
    
    def standardize_size(self, image):
        """尺寸标准化"""
        if isinstance(image, Image.Image):
            image = np.array(image)
        
        # 调整图像大小
        resized = cv2.resize(image, self.target_size, interpolation=cv2.INTER_AREA)
        return resized
    
    def remove_background(self, image):
        """背景去除"""
        if isinstance(image, Image.Image):
            image = np.array(image)
        
        # 使用rembg库去除背景
        output = remove(image)
        return output
    
    def process_image(self, image, enhance=True, standardize=True, remove_bg=True):
        """完整的图像处理流程"""
        if isinstance(image, bytes):
            image = Image.open(io.BytesIO(image))
        
        if isinstance(image, Image.Image):
            image = np.array(image)
        
        if enhance:
            image = self.enhance_image(image)
        
        if remove_bg:
            image = self.remove_background(image)
        
        if standardize:
            image = self.standardize_size(image)
        
        return image

    def process_batch(self, images, enhance=True, standardize=True, remove_bg=True):
        """批量处理图像"""
        processed_images = []
        for image in images:
            processed = self.process_image(image, enhance, standardize, remove_bg)
            processed_images.append(processed)
        return processed_images 