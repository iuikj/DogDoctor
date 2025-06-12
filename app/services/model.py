import torch
import torch.nn as nn
from torchvision import models
from torchvision.models import ResNet50_Weights


class DogBreedModel(nn.Module):
    def __init__(self, num_classes):
        super(DogBreedModel, self).__init__()
        # 加载预训练的ResNet50模型
        self.model = models.resnet50(weights=ResNet50_Weights.DEFAULT)
        
        # 冻结大部分层的参数
        for param in list(self.model.parameters())[:-20]:
            param.requires_grad = False
            
        # 修改最后的全连接层
        num_features = self.model.fc.in_features
        self.model.fc = nn.Sequential(
            nn.Linear(num_features, 512),
            nn.ReLU(),
            nn.Dropout(0.5),
            nn.Linear(512, num_classes)
        )
    
    def forward(self, x):
        return self.model(x)
