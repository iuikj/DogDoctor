import torch
import pandas as pd
from torch.utils.data import DataLoader
import matplotlib.pyplot as plt
import numpy as np
from PIL import Image
import io
from .preprocess import ImagePreprocessor


def predict_and_visualize(model, dataloader, dataset, device, num_samples=5):
    model.eval()

    def denormalize(tensor):
        mean = torch.tensor([0.485, 0.456, 0.406]).view(3, 1, 1)
        std = torch.tensor([0.229, 0.224, 0.225]).view(3, 1, 1)
        return tensor * std + mean

    plt.figure(figsize=(20, 4))
    with torch.no_grad():
        for i, (data, target) in enumerate(dataloader):
            if i >= num_samples:
                break
            data, target = data.to(device), target.to(device)
            output = model(data)
            _, predicted = torch.max(output, 1)
            img = data[0].cpu()
            true_label = target[0].item()
            pred_label = predicted[0].item()
            img = denormalize(img)
            img = torch.clamp(img, 0, 1)
            plt.subplot(1, num_samples, i + 1)
            plt.imshow(img.permute(1, 2, 0))
            plt.title(
                f'预测: {dataset.idx_to_breed[pred_label]}\n真实: {dataset.idx_to_breed[true_label]}\n{"✓" if pred_label == true_label else "✗"}',
                fontsize=10)
            plt.axis('off')
    plt.tight_layout()
    plt.show()


def predict_test_set(model, test_dataset, breed_names, device, batch_size=32):
    test_loader = DataLoader(test_dataset, batch_size=batch_size, shuffle=False, num_workers=0)
    model.eval()
    predictions = []
    image_ids = []
    with torch.no_grad():
        for images, ids in test_loader:
            images = images.to(device)
            outputs = model(images)
            _, predicted = torch.max(outputs, 1)
            for i, pred_idx in enumerate(predicted.cpu().numpy()):
                image_ids.append(ids[i])
                predictions.append(breed_names[pred_idx])
    submission_df = pd.DataFrame({
        'id': image_ids,
        'breed': predictions
    })
    submission_df.to_csv('submission.csv', index=False)
    return submission_df


class PredictService:
    def __init__(self):
        self.preprocessor = ImagePreprocessor()
        # 其他初始化代码...

    async def predict(self, image_data: bytes) -> list:
        """预测图片"""
        try:
            # 预处理图片
            processed_image = self.preprocessor.process_image(
                image_data,
                enhance=True,
                standardize=True,
                remove_bg=True
            )
            
            # 将处理后的图片转换为模型输入格式
            # 这里需要根据您的模型要求进行适当的转换
            model_input = self._prepare_model_input(processed_image)
            
            # 进行预测
            predictions = self._run_prediction(model_input)
            
            return predictions
        except Exception as e:
            raise Exception(f"预测失败: {str(e)}")
    
    def _prepare_model_input(self, image: np.ndarray) -> np.ndarray:
        """准备模型输入"""
        # 根据您的模型要求进行适当的转换
        # 例如：归一化、调整通道顺序等
        return image
    
    def _run_prediction(self, model_input: np.ndarray) -> list:
        """运行预测"""
        # 这里实现您的预测逻辑
        # 返回预测结果列表
        pass
