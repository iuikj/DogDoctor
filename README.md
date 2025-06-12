# DogDoctor - 狗品种识别AI系统

## 项目简介

DogDoctor是一个基于深度学习的狗品种识别系统，集成了数据集管理、模型训练和预测功能。该项目采用前后端分离架构，提供友好的Web界面供用户进行狗品种的智能识别。

## 技术栈

### 后端
- **FastAPI**: 高性能Python Web框架
- **PyTorch**: 深度学习框架
- **SQLAlchemy**: 数据库ORM
- **MySQL**: 数据库管理系统
- **OpenCV**: 图像处理库
- **Pandas**: 数据处理库

### 前端
- **Vue.js 3**: 现代JavaScript框架
- **Element Plus**: UI组件库
- **JavaScript**: 前端开发语言

### AI/ML
- **PyTorch**: 神经网络构建和训练
- **TorchVision**: 计算机视觉工具包
- **PIL**: Python图像处理库
- **NumPy**: 数值计算库

## 项目结构

```
DogDoctor/
├── backend/                    # 后端应用
│   └── app/
│       └── main.py            # FastAPI后端主程序
├── frontend/                   # 前端应用
│   └── dog_front/
│       ├── src/
│       │   ├── App.vue        # 主应用组件
│       │   ├── main.js        # 前端入口文件
│       │   └── components/    # Vue组件
│       └── public/            # 静态资源
├── app/                       # 应用核心模块
│   ├── routers/              # API路由
│   ├── services/             # 业务逻辑服务
│   └── static/               # 静态文件存储
│       ├── models/           # 训练好的模型
│       └── uploads/          # 上传的文件
├── init_db.py                # 数据库初始化脚本
├── generate_sql.py           # SQL生成脚本
├── dog_breeds_data.sql       # 狗品种数据
├── main.py                   # 项目主入口
├── pyproject.toml           # 项目配置和依赖
└── README.md                # 项目说明文档
```

## 核心功能

### 1. 数据集管理
- **上传数据集**: 支持ZIP、RAR、7Z格式的图片压缩包
- **标签管理**: 上传CSV格式的标签文件
- **数据验证**: 自动验证数据格式和完整性
- **数据预览**: 查看数据集统计信息和品种分布

### 2. 模型训练
- **自定义参数**: 可配置训练轮次、批次大小、学习率
- **实时监控**: 训练过程中显示损失和准确率
- **模型保存**: 自动保存训练好的模型

### 3. 品种预测
- **图片上传**: 支持PNG、JPG、JPEG、GIF格式
- **智能识别**: 基于深度学习的狗品种分类
- **置信度分析**: 显示预测置信度和Top-K结果
- **结果展示**: 直观的预测结果界面

### 4. 数据库管理
- **品种信息**: 存储狗品种的详细信息
- **训练记录**: 记录模型训练历史
- **用户数据**: 管理用户上传的图片和预测记录

## 安装和部署

### 环境要求
- Python 3.12+
- Node.js 16+
- MySQL 8.0+
- CUDA (可选，用于GPU加速训练)

### 后端部署

1. **克隆项目**
```bash
git clone <repository-url>
cd DogDoctor
```

2. **安装Python依赖**
```bash
# 使用uv包管理器（推荐）
pip install uv
uv sync

# 或使用pip
pip install -r requirements.txt
```

3. **配置数据库**
```bash
# 创建MySQL数据库
mysql -u root -p
CREATE DATABASE dogdoctor;

# 初始化数据库
python init_db.py
```

4. **启动后端服务**
```bash
cd backend/app
python main.py
```
后端服务将在 `http://127.0.0.1:8000` 启动

### 前端部署

1. **进入前端目录**
```bash
cd frontend/dog_front
```

2. **安装Node.js依赖**
```bash
npm install
# 或使用yarn
yarn install
```

3. **启动开发服务器**
```bash
npm run dev
# 或使用yarn
yarn dev
```

4. **构建生产版本**
```bash
npm run build
# 或使用yarn
yarn build
```

## 使用流程

### 1. 系统初始化
```bash
# 1. 启动后端服务
cd backend/app && python main.py

# 2. 初始化品种数据库
python init_db.py

# 3. 启动前端服务
cd frontend/dog_front && npm run dev
```

### 2. 数据准备
1. 准备狗品种图片数据集
2. 创建CSV标签文件，包含`image`和`breed`列
3. 将图片打包为ZIP/RAR/7Z格式

### 3. 模型训练
1. 在Web界面上传数据集和标签文件
2. 配置训练参数（轮次、批次大小、学习率）
3. 启动训练过程
4. 监控训练进度和性能指标

### 4. 品种预测
1. 上传待识别的狗狗图片
2. 系统自动进行品种识别
3. 查看预测结果和置信度
4. 获取Top-K预测品种列表

## API接口文档

### 数据集管理
- `POST /api/upload/dataset` - 上传数据集
- `GET /api/datasets` - 获取数据集列表

### 模型训练
- `POST /api/train` - 开始模型训练
- `GET /api/training/status` - 获取训练状态

### 品种预测
- `POST /api/predict` - 预测狗品种
- `POST /api/init-breeds` - 初始化品种数据库

### 系统状态
- `GET /` - 健康检查
- `GET /api/models` - 获取可用模型列表

## 开发说明

### 后端开发
- 使用FastAPI框架，支持自动API文档生成
- 访问 `http://127.0.0.1:8000/docs` 查看Swagger文档
- 采用异步编程模式，提高并发性能
- 集成CORS中间件，支持跨域请求

### 前端开发
- 基于Vue.js 3 Composition API
- 使用Element Plus UI组件库
- 支持热重载开发模式
- 响应式设计，适配多种设备

### 模型开发
- 基于PyTorch框架
- 支持GPU加速训练
- 可扩展的模型架构
- 自动模型保存和加载

## 故障排除

### 常见问题

1. **服务器无法启动**
   - 检查端口8000是否被占用
   - 确认Python依赖已正确安装
   - 查看日志文件`app.log`

2. **数据库连接失败**
   - 确认MySQL服务正在运行
   - 检查数据库配置和连接参数
   - 验证用户权限

3. **模型训练失败**
   - 检查GPU驱动和CUDA版本
   - 确认数据集格式正确
   - 监控系统内存使用情况

4. **预测结果不准确**
   - 检查输入图片质量
   - 验证模型是否已正确训练
   - 确认品种数据库已初始化

### 日志查看
```bash
# 查看应用日志
tail -f app.log

# 查看训练日志
tail -f training.log
```

## 贡献指南

欢迎提交Issues和Pull Requests来改进项目：

1. Fork项目到您的GitHub账户
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启Pull Request

## 许可证

本项目采用MIT许可证 - 详见 [LICENSE](LICENSE) 文件

## 联系方式

- 项目维护者: [Your Name]
- 邮箱: [your.email@example.com]
- 项目地址: [项目GitHub链接]

## 更新日志

### v0.1.0 (当前版本)
- 初始版本发布
- 基础的品种识别功能
- 数据集管理系统
- Web用户界面
- 模型训练流程

---

*感谢使用DogDoctor狗品种识别系统！如有任何问题或建议，请随时联系我们。* 