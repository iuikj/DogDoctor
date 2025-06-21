import base64
import io
from typing import List, Dict

import matplotlib.pyplot as plt
import numpy as np


class TrainingVisualizer:
    def __init__(self):
        # 使用更基础的样式设置
        plt.style.use('default')
        # 设置中文字体支持
        plt.rcParams['font.sans-serif'] = ['SimHei']  # 用来正常显示中文标签
        plt.rcParams['axes.unicode_minus'] = False  # 用来正常显示负号

    def plot_training_curves(self,
                             train_loss: List[float],
                             val_loss: List[float],
                             train_acc: List[float],
                             val_acc: List[float]) -> str:
        """绘制训练曲线并返回base64编码的图片"""
        fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(15, 5))

        # 绘制损失曲线
        epochs = range(1, len(train_loss) + 1)
        ax1.plot(epochs, train_loss, 'b-', label='训练损失')
        ax1.plot(epochs, val_loss, 'r-', label='验证损失')
        ax1.set_title('训练和验证损失')
        ax1.set_xlabel('轮次')
        ax1.set_ylabel('损失')
        ax1.legend()
        ax1.grid(True)

        # 绘制准确率曲线
        ax2.plot(epochs, train_acc, 'b-', label='训练准确率')
        ax2.plot(epochs, val_acc, 'r-', label='验证准确率')
        ax2.set_title('训练和验证准确率')
        ax2.set_xlabel('轮次')
        ax2.set_ylabel('准确率')
        ax2.legend()
        ax2.grid(True)

        plt.tight_layout()

        # 将图表转换为base64字符串
        buf = io.BytesIO()
        plt.savefig(buf, format='png', dpi=100, bbox_inches='tight')
        buf.seek(0)
        img_str = base64.b64encode(buf.read()).decode('utf-8')
        plt.close()

        return img_str

    def plot_confusion_matrix(self,
                              confusion_matrix: np.ndarray,
                              class_names: List[str]) -> str:
        """绘制混淆矩阵并返回base64编码的图片"""
        plt.figure(figsize=(10, 8))
        plt.imshow(confusion_matrix, interpolation='nearest', cmap=plt.cm.Blues)
        plt.title('混淆矩阵')
        plt.colorbar()

        tick_marks = np.arange(len(class_names))
        plt.xticks(tick_marks, class_names, rotation=45)
        plt.yticks(tick_marks, class_names)

        # 在混淆矩阵中显示数值
        thresh = confusion_matrix.max() / 2.
        for i in range(confusion_matrix.shape[0]):
            for j in range(confusion_matrix.shape[1]):
                plt.text(j, i, format(confusion_matrix[i, j], 'd'),
                         ha="center", va="center",
                         color="white" if confusion_matrix[i, j] > thresh else "black")

        plt.tight_layout()
        plt.ylabel('真实标签')
        plt.xlabel('预测标签')

        # 将图表转换为base64字符串
        buf = io.BytesIO()
        plt.savefig(buf, format='png', dpi=100, bbox_inches='tight')
        buf.seek(0)
        img_str = base64.b64encode(buf.read()).decode('utf-8')
        plt.close()

        return img_str

    def plot_class_distribution(self,
                                class_counts: Dict[str, int]) -> str:
        """绘制类别分布图并返回base64编码的图片"""
        plt.figure(figsize=(12, 6))
        classes = list(class_counts.keys())
        counts = list(class_counts.values())

        plt.bar(classes, counts)
        plt.title('数据集类别分布')
        plt.xlabel('类别')
        plt.ylabel('样本数量')
        plt.xticks(rotation=45)
        plt.tight_layout()

        # 将图表转换为base64字符串
        buf = io.BytesIO()
        plt.savefig(buf, format='png', dpi=100, bbox_inches='tight')
        buf.seek(0)
        img_str = base64.b64encode(buf.read()).decode('utf-8')
        plt.close()

        return img_str
