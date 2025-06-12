from torch.utils.data import Dataset
from PIL import Image
import os
import pandas as pd
import torchvision.transforms as transforms

class DogBreedDataset(Dataset):
    """狗品种图像识别数据集"""

    def __init__(self, csv_file, img_dir, transform=None):
        self.labels_df = pd.read_csv(csv_file)
        self.img_dir = img_dir
        self.transform = transform or transforms.Compose([
            transforms.Resize((224, 224)),
            transforms.ToTensor(),
            transforms.Normalize(mean=[0.485, 0.456, 0.406],
                              std=[0.229, 0.224, 0.225])
        ])

        self.breed_names = sorted(self.labels_df['breed'].unique())
        self.breed_to_idx = {breed: idx for idx, breed in enumerate(self.breed_names)}
        self.idx_to_breed = {idx: breed for breed, idx in self.breed_to_idx.items()}

    def __len__(self):
        return len(self.labels_df)

    def __getitem__(self, idx):
        img_id = self.labels_df.iloc[idx]['id']
        breed = self.labels_df.iloc[idx]['breed']
        img_path = os.path.join(self.img_dir, f"{img_id}.jpg")

        image = Image.open(img_path).convert('RGB')
        label = self.breed_to_idx[breed]

        if self.transform:
            image = self.transform(image)

        return image, label

    def get_breed_name(self, idx):
        """根据索引获取品种名称"""
        return self.idx_to_breed[idx]

    def get_num_classes(self):
        """获取品种数量"""
        return len(self.breed_names) 