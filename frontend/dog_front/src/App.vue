<template>
  <div class="app-container">
    <div class="main-wrapper">
      <!-- 顶部导航 -->
      <div class="header-section">
        <div class="logo-area">
          <div class="logo-icon">
            <el-icon><IconDog /></el-icon>
          </div>
          <h1>狗博士</h1>
        </div>
        <el-tabs v-model="activeTab" class="main-tabs">
          <el-tab-pane label="训练模块" name="train">
            <template #label>
              <span class="tab-label">
                <el-icon><IconCogs /></el-icon>
                训练模块
              </span>
            </template>
          </el-tab-pane>
          <el-tab-pane label="预测模块" name="predict">
            <template #label>
              <span class="tab-label">
                <el-icon><IconSearch /></el-icon>
                预测模块
              </span>
            </template>
          </el-tab-pane>
        </el-tabs>
      </div>

      <!-- 训练模块 -->
      <div v-if="activeTab === 'train'" class="content-section">
        <!-- 第一行：数据集操作 -->
        <el-row :gutter="24" class="row-section">
          <el-col :span="12">
            <el-card class="unified-card upload-card">
              <template #header>
                <div class="card-title">
                  <el-icon><IconUpload /></el-icon>
                  <span>数据集上传</span>
                </div>
              </template>
              <div class="card-content">
                <!-- 标签文件上传 -->
                <div class="upload-group">
                  <el-upload
                    ref="labelsUpload"
                    class="upload-area"
                    drag
                    :auto-upload="false"
                    :on-change="handleLabelsChange"
                    accept=".csv"
                    :limit="1"
                  >
                    <el-icon class="upload-icon"><IconDocument /></el-icon>
                    <div class="upload-text">拖拽标签文件到此处</div>
                    <div class="upload-hint">支持 CSV 格式</div>
                  </el-upload>
                  <div v-if="uploadFiles.labels" class="file-info">
                    <el-icon class="success-icon"><IconCheckCircle /></el-icon>
                    <span class="file-name">{{ uploadFiles.labels.name }}</span>
                  </div>
                </div>

                <!-- 图片压缩包上传 -->
                <div class="upload-group">
                  <el-upload
                    ref="imagesUpload"
                    class="upload-area"
                    drag
                    :auto-upload="false"
                    :on-change="handleImagesChange"
                    accept=".zip,.rar,.7z"
                    :limit="1"
                  >
                    <el-icon class="upload-icon"><IconFolder /></el-icon>
                    <div class="upload-text">拖拽图片压缩包到此处</div>
                    <div class="upload-hint">支持 ZIP、RAR、7Z 格式</div>
                  </el-upload>
                  <div v-if="uploadFiles.images" class="file-info">
                    <el-icon class="success-icon"><IconCheckCircle /></el-icon>
                    <span class="file-name">{{ uploadFiles.images.name }}</span>
                  </div>
                </div>

                <!-- 统一上传按钮 -->
                <div class="upload-actions">
                  <el-button
                    v-if="uploadFiles.labels && uploadFiles.images"
                    type="primary"
                    size="large"
                    @click="uploadDataset"
                    :loading="uploading.dataset"
                    class="primary-btn upload-dataset-btn"
                  >
                    <el-icon v-if="!uploading.dataset"><IconUpload /></el-icon>
                    <el-icon v-else><IconSpinner /></el-icon>
                    {{ uploading.dataset ? '上传中...' : '上传数据集' }}
                  </el-button>
                  <div v-else class="upload-hint-text">
                    请先选择标签文件和图片压缩包
                  </div>
                </div>
              </div>
            </el-card>
          </el-col>

          <el-col :span="12">
            <el-card class="unified-card dataset-card">
              <template #header>
                <div class="card-title">
                  <div class="title-left">
                    <el-icon><IconCollection /></el-icon>
                    <span>数据集管理</span>
                  </div>
                  <el-button 
                    type="text" 
                    @click="fetchDatasets" 
                    :loading="loading.datasets"
                    class="refresh-btn"
                  >
                    <el-icon><IconRefresh /></el-icon>
                  </el-button>
                </div>
              </template>
              <div class="card-content">
                <div v-if="datasets.length === 0" class="empty-content">
                  <el-icon class="empty-icon"><IconFolderOpen /></el-icon>
                  <p>暂无数据集</p>
                  <el-button type="primary" size="small" @click="fetchDatasets">
                    获取数据集
                  </el-button>
                </div>

                <div v-else class="dataset-list">
                  <div v-for="dataset in datasets" :key="dataset.name" 
                       class="dataset-item"
                       :class="{ 'dataset-item-selected': selectedDataset === dataset.name }"
                       @click="handleDatasetSelect(dataset.name)">
                    <el-card class="dataset-card" :body-style="{ padding: '0px' }">
                      <div class="dataset-content">
                        <div class="dataset-header">
                          <div class="dataset-title">
                            <h4>{{ dataset.name }}</h4>
                          </div>
                          <div class="dataset-select">
                            <el-radio v-model="selectedDataset" :label="dataset.name" @change="handleDatasetSelect">
                              <el-icon v-if="selectedDataset === dataset.name"><IconSelect /></el-icon>
                              {{ selectedDataset === dataset.name ? '已选择' : '选择' }}
                            </el-radio>
                          </div>
                        </div>
                        <div class="dataset-info">
                          <div class="info-item">
                            <div class="info-icon">
                              <el-icon><IconPicture /></el-icon>
                            </div>
                            <div class="info-content">
                              <div class="info-label">训练集</div>
                              <div class="info-value">{{ dataset.train_images }}</div>
                            </div>
                          </div>
                          <div class="info-item">
                            <div class="info-icon test-icon">
                              <el-icon><IconFiles /></el-icon>
                            </div>
                            <div class="info-content">
                              <div class="info-label">测试集</div>
                              <div class="info-value">{{ dataset.test_images }}</div>
                            </div>
                          </div>
                          <div class="info-item">
                            <div class="info-icon total-icon">
                              <el-icon><IconCollection /></el-icon>
                            </div>
                            <div class="info-content">
                              <div class="info-label">总标签数</div>
                              <div class="info-value">{{ dataset.total_labels }}</div>
                            </div>
                          </div>
                          <div class="info-item">
                            <div class="info-icon breeds-icon">
                              <el-icon><IconGrid /></el-icon>
                            </div>
                            <div class="info-content">
                              <div class="info-label">品种数</div>
                              <div class="info-value">{{ dataset.breeds.length }}</div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </el-card>
                  </div>
                </div>
              </div>
            </el-card>
          </el-col>
        </el-row>

        <!-- 第二行：训练控制 -->
        <el-row :gutter="24" class="row-section">
          <el-col :span="24">
            <el-card class="unified-card training-card">
              <template #header>
                <div class="card-title">
                  <div class="title-left">
                    <el-icon><IconBrain /></el-icon>
                    <span>模型训练</span>
                  </div>
                  <div v-if="trainingData" class="training-status">
                    <el-tag :type="isTraining ? 'warning' : 'success'" size="small">
                      {{ isTraining ? '训练中' : '训练完成' }}
                    </el-tag>
                  </div>
                </div>
              </template>
              <div class="card-content">
                <div class="training-controls">
                  <el-button
                    type="primary"
                    size="large"
                    @click="startTraining"
                    :disabled="!selectedDataset || isTraining"
                    :loading="isTraining"
                    class="primary-btn"
                  >
                    <el-icon v-if="!isTraining"><IconPlay /></el-icon>
                    <el-icon v-else><IconSpinner /></el-icon>
                    {{ isTraining ? '训练中...' : '开始训练' }}
                  </el-button>
                  <el-button
                    v-if="isTraining"
                    type="danger"
                    size="large"
                    @click="stopTraining"
                    class="danger-btn"
                  >
                    <el-icon><IconStop /></el-icon>
                    停止训练
                  </el-button>
                </div>

                <!-- 训练进度 -->
                <div v-if="trainingData" class="training-progress">
                  <div class="progress-info">
                    <span class="epoch-info">
                      Epoch {{ trainingData.epoch }}/{{ trainingData.total_epochs }}
                    </span>
                    <span class="progress-percent">
                      {{ formatProgressPercentage(trainingData.epoch, trainingData.total_epochs) }}%
                    </span>
                  </div>
                  <el-progress
                    :percentage="getProgressPercentage(trainingData.epoch, trainingData.total_epochs)"
                    :stroke-width="10"
                    class="progress-bar"
                    :color="isTraining ? '#409eff' : '#67c23a'"
                  />

                  <!-- 训练指标 -->
                  <div class="metrics-grid">
                    <div class="metric-item">
                      <div class="metric-icon">
                        <el-icon><IconChartArea /></el-icon>
                      </div>
                      <div class="metric-content">
                        <div class="metric-label">训练损失</div>
                        <div class="metric-value">{{ formatMetricValue(trainingData.train_loss, 4) }}</div>
                      </div>
                    </div>
                    <div class="metric-item">
                      <div class="metric-icon">
                        <el-icon><IconBullseye /></el-icon>
                      </div>
                      <div class="metric-content">
                        <div class="metric-label">训练准确率</div>
                        <div class="metric-value">{{ formatMetricValue(trainingData.train_acc, 2) }}%</div>
                      </div>
                    </div>
                    <div class="metric-item">
                      <div class="metric-icon">
                        <el-icon><IconChartLine /></el-icon>
                      </div>
                      <div class="metric-content">
                        <div class="metric-label">验证损失</div>
                        <div class="metric-value">{{ formatMetricValue(trainingData.val_loss, 4) }}</div>
                      </div>
                    </div>
                    <div class="metric-item">
                      <div class="metric-icon">
                        <el-icon><IconCheckCircle /></el-icon>
                      </div>
                      <div class="metric-content">
                        <div class="metric-label">验证准确率</div>
                        <div class="metric-value">{{ formatMetricValue(trainingData.val_acc, 2) }}%</div>
                      </div>
                    </div>
                  </div>

                  <div class="learning-rate-info">
                    <el-icon><IconTachometer /></el-icon>
                    学习率: {{ formatMetricValue(trainingData.learning_rate, 6) }}
                  </div>
                </div>
              </div>
            </el-card>
          </el-col>
        </el-row>

        <!-- 第三行：数据可视化 -->
        <el-row v-if="trainingHistory.length > 0" :gutter="24" class="row-section">
          <el-col :span="12">
            <el-card class="unified-card chart-card">
              <template #header>
                <div class="card-title">
                  <div class="title-left">
                    <el-icon><IconChartArea /></el-icon>
                    <span>损失曲线</span>
                  </div>
                  <div class="chart-legend">
                    <span class="legend-item">
                      <span class="legend-color" style="background: #ff6b6b;"></span>
                      训练
                    </span>
                    <span class="legend-item">
                      <span class="legend-color" style="background: #4ecdc4;"></span>
                      验证
                    </span>
                  </div>
                </div>
              </template>
              <div class="chart-content">
                <canvas ref="lossChart" width="400" height="240"></canvas>
              </div>
            </el-card>
          </el-col>
          <el-col :span="12">
            <el-card class="unified-card chart-card">
              <template #header>
                <div class="card-title">
                  <div class="title-left">
                    <el-icon><IconChartLine /></el-icon>
                    <span>准确率曲线</span>
                  </div>
                  <div class="chart-legend">
                    <span class="legend-item">
                      <span class="legend-color" style="background: #45b7d1;"></span>
                      训练
                    </span>
                    <span class="legend-item">
                      <span class="legend-color" style="background: #f39c12;"></span>
                      验证
                    </span>
                  </div>
                </div>
              </template>
              <div class="chart-content">
                <canvas ref="accuracyChart" width="400" height="240"></canvas>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </div>

      <!-- 预测模块 -->
      <div v-if="activeTab === 'predict'" class="content-section">
        <el-row :gutter="24" class="row-section">
          <el-col :span="12">
            <el-card class="unified-card predict-card">
              <template #header>
                <div class="card-title">
                  <div class="title-left">
                    <el-icon><IconImage /></el-icon>
                    <span>图片上传</span>
                  </div>
                </div>
              </template>
              <div class="card-content">
                <el-upload
                  ref="predictUpload"
                  class="predict-upload"
                  drag
                  :auto-upload="false"
                  :on-change="handlePredictImageChange"
                  accept="image/*"
                  :limit="1"
                >
                  <el-icon class="upload-icon"><IconPicture /></el-icon>
                  <div class="upload-text">拖拽图片到此处</div>
                  <div class="upload-hint">支持 JPG、PNG、GIF 格式</div>
                </el-upload>

                <div v-if="predictImage" class="image-preview">
                  <img :src="predictImage" alt="预测图片" class="preview-img" />
                  <el-button
                    type="primary"
                    size="large"
                    @click="predictImageHandler"
                    :loading="predicting"
                    class="primary-btn"
                  >
                    <el-icon v-if="!predicting"><IconMagic /></el-icon>
                    <el-icon v-else><IconSpinner /></el-icon>
                    {{ predicting ? '预测中...' : '开始预测' }}
                  </el-button>
                </div>
              </div>
            </el-card>
          </el-col>

          <el-col :span="12">
            <el-card class="unified-card result-card">
              <template #header>
                <div class="card-title">
                  <div class="title-left">
                    <el-icon><IconChartBar /></el-icon>
                    <span>预测结果</span>
                  </div>
                </div>
              </template>
              <div class="card-content">
                <div v-if="!predictionResult" class="empty-content">
                  <el-icon class="empty-icon"><IconRobot /></el-icon>
                  <p>请上传图片进行预测</p>
                </div>

                <div v-else class="prediction-results">
                  <div class="main-result">
                    <div class="result-label">预测品种</div>
                    <div class="result-breed">{{ predictionResult.predicted_breed }}</div>
                    <div class="result-english">{{ predictionResult.english_breed }}</div>
                    <div class="confidence-info">
                      <span class="confidence-label">置信度</span>
                      <span class="confidence-value">{{ predictionResult.confidence.toFixed(2) }}%</span>
                    </div>
                    <el-progress
                      :percentage="Math.round(predictionResult.confidence)"
                      :stroke-width="6"
                      class="confidence-bar"
                    />
                  </div>

                  <!-- 品种详细信息 -->
                  <div v-if="predictionResult.breed_info" class="breed-details">
                    <el-tabs type="border-card" class="breed-tabs">
                      <el-tab-pane label="品种介绍" name="description">
                        <div class="breed-section">
                          <h4>品种描述</h4>
                          <p class="breed-description">{{ predictionResult.breed_info.description }}</p>
                          
                          <div class="breed-basic-info">
                            <div class="info-grid">
                              <div class="info-item">
                                <span class="info-label">体型分类</span>
                                <span class="info-value">{{ predictionResult.breed_info.size_category }}</span>
                              </div>
                              <div class="info-item">
                                <span class="info-label">预期寿命</span>
                                <span class="info-value">{{ predictionResult.breed_info.life_expectancy }}</span>
                              </div>
                              <div class="info-item">
                                <span class="info-label">原产国</span>
                                <span class="info-value">{{ predictionResult.breed_info.origin_country }}</span>
                              </div>
                              <div class="info-item">
                                <span class="info-label">护理难度</span>
                                <span class="info-value care-level" :class="getCareLevel(predictionResult.breed_info.care_level)">
                                  {{ predictionResult.breed_info.care_level }}
                                </span>
                              </div>
                              <div class="info-item">
                                <span class="info-label">运动需求</span>
                                <span class="info-value exercise-need" :class="getExerciseLevel(predictionResult.breed_info.exercise_needs)">
                                  {{ predictionResult.breed_info.exercise_needs }}
                                </span>
                              </div>
                              <div class="info-item">
                                <span class="info-label">性格特点</span>
                                <span class="info-value">{{ predictionResult.breed_info.temperament }}</span>
                              </div>
                            </div>
                          </div>
                        </div>
                      </el-tab-pane>

                      <el-tab-pane label="品种特征" name="characteristics">
                        <div class="breed-section">
                          <h4>品种特征</h4>
                          <div class="characteristics-list">
                            <el-tag
                              v-for="(char, index) in getCharacteristicsList(predictionResult.breed_info.characteristics)"
                              :key="index"
                              type="info"
                              class="characteristic-tag"
                              effect="light"
                            >
                              {{ char }}
                            </el-tag>
                          </div>
                        </div>
                      </el-tab-pane>

                      <el-tab-pane label="健康信息" name="health">
                        <div class="breed-section">
                          <h4>常见疾病</h4>
                          <div class="diseases-list">
                            <div
                              v-for="(disease, index) in getDiseasesList(predictionResult.breed_info.common_diseases)"
                              :key="index"
                              class="disease-item"
                            >
                              <el-icon class="disease-icon"><IconWarning /></el-icon>
                              <span class="disease-name">{{ disease }}</span>
                            </div>
                          </div>
                          <div class="health-tip">
                            <el-alert
                              title="健康提示"
                              type="info"
                              description="以上为该品种常见的健康问题，建议定期体检，如有疑虑请咨询专业兽医。"
                              show-icon
                              :closable="false"
                            />
                          </div>
                        </div>
                      </el-tab-pane>
                    </el-tabs>
                  </div>

                  <div v-if="predictionResult.top_predictions" class="top-predictions">
                    <h4>Top 5 预测结果</h4>
                    <div class="predictions-list">
                      <div v-for="(pred, index) in predictionResult.top_predictions.slice(0, 5)"
                           :key="index"
                           class="prediction-row"
                           @click="showBreedDetail(pred)"
                           :class="{ 'selected': index === 0 }"
                      >
                        <div class="pred-info">
                          <span class="rank">{{ index + 1 }}</span>
                          <div class="breed-names">
                            <span class="breed">{{ pred.breed }}</span>
                            <span class="breed-english">{{ pred.english_breed }}</span>
                          </div>
                          <span class="confidence">{{ pred.confidence.toFixed(2) }}%</span>
                        </div>
                        <el-progress
                          :percentage="Math.round(pred.confidence)"
                          :show-text="false"
                          :stroke-width="4"
                          class="pred-bar"
                        />
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, watch } from 'vue'
import { ElMessage, ElNotification } from 'element-plus'
import {
  // 基础图标
  Picture as IconPicture,
  Collection as IconCollection,
  Files as IconFiles,
  Grid as IconGrid,
  Select as IconSelect,
  RefreshRight as IconRefresh,
  // 导航和界面图标
  UserFilled as IconDog,
  Setting as IconCogs,
  Search as IconSearch,
  // 上传图标
  Upload as IconUpload,
  Document as IconDocument,
  Folder as IconFolder,
  FolderOpened as IconFolderOpen,
  // 训练相关图标
  Cpu as IconBrain,
  VideoPlay as IconPlay,
  Loading as IconSpinner,
  VideoPause as IconStop,
  // 图表和统计图标
  TrendCharts as IconChartArea,
  Aim as IconBullseye,
  TrendCharts as IconChartLine,
  SuccessFilled as IconCheckCircle,
  Odometer as IconTachometer,
  Histogram as IconChartBar,
  // 其他图标
  PictureRounded as IconImage,
  MagicStick as IconMagic,
  Avatar as IconRobot,
  Warning as IconWarning
} from '@element-plus/icons-vue'

// 响应式数据
const activeTab = ref('train')
const datasets = ref([])
const selectedDataset = ref('')
const trainingData = ref(null)
const trainingHistory = ref([]) // 添加训练历史数据
const isTraining = ref(false)
const predicting = ref(false)
const predictionResult = ref(null)
const predictImage = ref(null)
const predictImageFile = ref(null)

const uploadFiles = reactive({
  labels: null,
  images: null
})

const uploading = reactive({
  labels: false,
  images: false,
  dataset: false
})

const loading = reactive({
  datasets: false
})

// 引用
const labelsUpload = ref(null)
const imagesUpload = ref(null)
const predictUpload = ref(null)
const lossChart = ref(null)
const accuracyChart = ref(null)

// 处理标签文件上传
const handleLabelsChange = (file) => {
  uploadFiles.labels = file.raw
}

// 处理图片压缩包上传
const handleImagesChange = (file) => {
  uploadFiles.images = file.raw
}

// 处理预测图片上传
const handlePredictImageChange = (file) => {
  const reader = new FileReader()
  reader.onload = (e) => {
    predictImage.value = e.target.result
  }
  reader.readAsDataURL(file.raw)
  
  // 保存原始文件对象
  predictImageFile.value = file.raw
}

// 格式化指标值，处理NaN和undefined
const formatMetricValue = (value, decimals = 2) => {
  if (value === null || value === undefined || isNaN(value)) {
    return '--'
  }
  if (typeof value === 'number') {
    return value.toFixed(decimals)
  }
  return '--'
}

// 格式化进度百分比显示
const formatProgressPercentage = (current, total) => {
  if (!current || !total || isNaN(current) || isNaN(total) || total === 0) {
    return '0'
  }
  return Math.round((current / total) * 100).toString()
}

// 获取进度百分比数值
const getProgressPercentage = (current, total) => {
  if (!current || !total || isNaN(current) || isNaN(total) || total === 0) {
    return 0
  }
  return Math.round((current / total) * 100)
}

// 统一上传数据集（标签文件 + 图片压缩包）
const uploadDataset = async () => {
  if (!uploadFiles.labels || !uploadFiles.images) {
    ElMessage.warning('请选择标签文件和图片压缩包')
    return
  }

  uploading.dataset = true
  const formData = new FormData()
  formData.append('labels_file', uploadFiles.labels)
  formData.append('train_zip', uploadFiles.images)

  try {
    const response = await fetch('http://127.0.0.1:8000/api/upload/dataset', {
      method: 'POST',
      body: formData
    })

    if (response.ok) {
      ElMessage.success('数据集上传成功')
      // 清空文件选择
      labelsUpload.value.clearFiles()
      imagesUpload.value.clearFiles()
      uploadFiles.labels = null
      uploadFiles.images = null
      // 自动刷新数据集列表
      await fetchDatasets()
    } else {
      const errorData = await response.json()
      throw new Error(errorData.detail || '上传失败')
    }
  } catch (error) {
    ElMessage.error('数据集上传失败: ' + error.message)
  } finally {
    uploading.dataset = false
  }
}

// 保留原有函数以备需要（可选）
const uploadLabels = async () => {
  if (!uploadFiles.labels) return

  uploading.labels = true
  const formData = new FormData()
  formData.append('labels_file', uploadFiles.labels)

  try {
    const response = await fetch('http://127.0.0.1:8000/api/upload/dataset', {
      method: 'POST',
      body: formData
    })

    if (response.ok) {
      ElMessage.success('标签文件上传成功')
      labelsUpload.value.clearFiles()
      uploadFiles.labels = null
    } else {
      throw new Error('上传失败')
    }
  } catch (error) {
    ElMessage.error('标签文件上传失败: ' + error.message)
  } finally {
    uploading.labels = false
  }
}

// 保留原有函数以备需要（可选）
const uploadImages = async () => {
  if (!uploadFiles.images) return

  uploading.images = true
  const formData = new FormData()
  formData.append('train_zip', uploadFiles.images)
  formData.append('labels_file', uploadFiles.labels)

  try {
    const response = await fetch('http://127.0.0.1:8000/api/upload/dataset', {
      method: 'POST',
      body: formData
    })

    if (response.ok) {
      ElMessage.success('图片压缩包上传成功')
      imagesUpload.value.clearFiles()
      uploadFiles.images = null
    } else {
      throw new Error('上传失败')
    }
  } catch (error) {
    ElMessage.error('图片压缩包上传失败: ' + error.message)
  } finally {
    uploading.images = false
  }
}

// 获取数据集列表
const fetchDatasets = async () => {
  loading.datasets = true
  try {
    const response = await fetch('http://127.0.0.1:8000/api/datasets')
    const data = await response.json()
    datasets.value = data.datasets
    ElMessage.success('数据集获取成功')
  } catch (error) {
    ElMessage.error('获取数据集失败: ' + error.message)
  } finally {
    loading.datasets = false
  }
}

// 选择数据集
const handleDatasetSelect = (value) => {
  selectedDataset.value = value
}

// 开始训练
const startTraining = async () => {
  if (!selectedDataset.value) {
    ElMessage.warning('请先选择数据集')
    return
  }

  isTraining.value = true
  trainingData.value = null
  trainingHistory.value = [] // 清空历史数据

  try {
    const response = await fetch(`http://127.0.0.1:8000/api/train?dataset_name=${encodeURIComponent(selectedDataset.value)}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'text/event-stream'
      },
      body: JSON.stringify({
        epochs: 30,
        batch_size: 32,
        learning_rate: 0.001
      })
    })

    if (!response.ok) {
      const errorData = await response.json()
      throw new Error(errorData.detail || '训练请求失败')
    }

    // 处理流式数据
    const reader = response.body.getReader()
    const decoder = new TextDecoder()

    while (true) {
      const { done, value } = await reader.read()
      if (done) break

      const chunk = decoder.decode(value)
      const lines = chunk.split('\n').filter(line => line.trim())

              for (const line of lines) {
          if (line.startsWith('data: ')) {
            try {
              const data = JSON.parse(line.substring(6))
              
              // 处理NaN值，将其替换为0或者上一个有效值
              const cleanData = {
                ...data,
                train_loss: isNaN(data.train_loss) ? 0 : data.train_loss,
                train_acc: isNaN(data.train_acc) ? 0 : data.train_acc,
                val_loss: isNaN(data.val_loss) ? 0 : data.val_loss,
                val_acc: isNaN(data.val_acc) ? 0 : data.val_acc,
                learning_rate: isNaN(data.learning_rate) ? 0.001 : data.learning_rate
              }
              
              trainingData.value = cleanData
              // 添加到历史数据中
              trainingHistory.value.push({
                ...cleanData,
                timestamp: Date.now()
              })
            } catch (e) {
              console.error('解析训练数据失败:', e)
            }
          }
        }
    }

    ElNotification.success({
      title: '训练完成',
      message: '模型训练已成功完成'
    })
  } catch (error) {
    ElMessage.error('训练失败: ' + error.message)
  } finally {
    isTraining.value = false
  }
}

// 停止训练
const stopTraining = () => {
  isTraining.value = false
  ElMessage.info('训练已停止')
}

// 预测图片
const predictImageHandler = async () => {
  if (!predictImage.value) {
    ElMessage.warning('请先上传图片')
    return
  }

  if (!predictImageFile.value) {
    ElMessage.warning('图片文件丢失，请重新上传')
    return
  }

  predicting.value = true

  try {
    const formData = new FormData()
    formData.append('image', predictImageFile.value)

    const response = await fetch('http://127.0.0.1:8000/api/predict', {
      method: 'POST',
      body: formData
    })

    if (!response.ok) {
      const errorData = await response.json()
      throw new Error(errorData.detail || '预测请求失败')
    }

    const result = await response.json()
    
    // 适配后端返回的数据格式
    if (result.success && result.predictions && result.predictions.length > 0) {
      predictionResult.value = {
        predicted_breed: result.predictions[0].breed_info?.chinese_name || translateBreedName(result.predictions[0].breed),
        english_breed: result.predictions[0].breed,
        confidence: result.predictions[0].confidence,
        breed_info: result.predictions[0].breed_info, // 保存完整的品种信息
        top_predictions: result.predictions.map(pred => ({
          breed: pred.breed_info?.chinese_name || translateBreedName(pred.breed),
          english_breed: pred.breed,
          confidence: pred.confidence,
          breed_info: pred.breed_info // 每个预测结果的品种信息
        }))
      }
    } else {
      throw new Error('预测结果格式错误')
    }
    
    ElMessage.success('预测完成')
  } catch (error) {
    ElMessage.error('预测失败: ' + error.message)
  } finally {
    predicting.value = false
  }
}

// 品种名称翻译
const translateBreedName = (breedName) => {
  const breedTranslations = {
    'norwich_terrier': '诺维奇梗',
    'norfolk_terrier': '诺福克梗', 
    'australian_terrier': '澳洲梗',
    'cairn': '凯恩梗',
    'dandie_dinmont': '丹迪丁蒙梗',
    'labrador_retriever': '拉布拉多寻回犬',
    'golden_retriever': '金毛寻回犬',
    'german_shepherd': '德国牧羊犬',
    'siberian_husky': '西伯利亚雪橇犬',
    'border_collie': '边境牧羊犬',
    'poodle': '贵宾犬',
    'chihuahua': '吉娃娃',
    'bulldozer': '斗牛犬',
    'rottweiler': '罗威纳犬',
    'doberman': '杜宾犬'
  }
  
  // 如果有翻译则返回中文名，否则返回格式化的英文名
  return breedTranslations[breedName] || breedName.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase())
}

// 处理特征列表
const getCharacteristicsList = (characteristics) => {
  if (!characteristics) return []
  if (Array.isArray(characteristics)) return characteristics
  if (typeof characteristics === 'string') {
    return characteristics.split('；').filter(char => char.trim())
  }
  return []
}

// 处理疾病列表
const getDiseasesList = (diseases) => {
  if (!diseases) return []
  if (Array.isArray(diseases)) return diseases
  if (typeof diseases === 'string') {
    return diseases.split('；').filter(disease => disease.trim())
  }
  return []
}

// 获取护理难度等级样式
const getCareLevel = (level) => {
  switch (level) {
    case '简单': return 'easy'
    case '一般': return 'normal'
    case '困难': return 'hard'
    default: return 'normal'
  }
}

// 获取运动需求等级样式
const getExerciseLevel = (level) => {
  switch (level) {
    case '低': return 'low'
    case '中': return 'medium'
    case '高': return 'high'
    default: return 'medium'
  }
}

// 显示品种详情
const showBreedDetail = (prediction) => {
  if (prediction.breed_info) {
    // 更新主要预测结果
    predictionResult.value.predicted_breed = prediction.breed
    predictionResult.value.english_breed = prediction.english_breed
    predictionResult.value.confidence = prediction.confidence
    predictionResult.value.breed_info = prediction.breed_info
    
    ElMessage.info(`切换到 ${prediction.breed} 的详细信息`)
  }
}

// 绘制损失曲线
const drawLossChart = () => {
  if (!lossChart.value || trainingHistory.value.length === 0) return
  
  const canvas = lossChart.value
  const ctx = canvas.getContext('2d')
  const width = canvas.width
  const height = canvas.height
  
  // 清空画布
  ctx.clearRect(0, 0, width, height)
  
  // 获取有效数据，保持索引对应关系
  const validData = trainingHistory.value.filter(d => 
    !isNaN(d.epoch) && d.epoch !== null && d.epoch !== undefined &&
    !isNaN(d.train_loss) && d.train_loss !== null && d.train_loss !== undefined &&
    !isNaN(d.val_loss) && d.val_loss !== null && d.val_loss !== undefined
  )
  
  if (validData.length < 2) return
  
  // 计算范围
  const epochs = validData.map(d => d.epoch)
  const trainLoss = validData.map(d => d.train_loss)
  const valLoss = validData.map(d => d.val_loss)
  
  const minEpoch = Math.min(...epochs)
  const maxEpoch = Math.max(...epochs)
  const minLoss = Math.min(...trainLoss, ...valLoss)
  const maxLoss = Math.max(...trainLoss, ...valLoss)
  
  // 检查范围是否有效
  if (isNaN(minLoss) || isNaN(maxLoss) || minLoss === maxLoss) return
  
  const padding = 40
  const chartWidth = width - 2 * padding
  const chartHeight = height - 2 * padding
  
  // 绘制坐标轴
  ctx.strokeStyle = '#e0e0e0'
  ctx.lineWidth = 1
  
  // X轴
  ctx.beginPath()
  ctx.moveTo(padding, height - padding)
  ctx.lineTo(width - padding, height - padding)
  ctx.stroke()
  
  // Y轴
  ctx.beginPath()
  ctx.moveTo(padding, padding)
  ctx.lineTo(padding, height - padding)
  ctx.stroke()
  
  // 绘制网格线
  ctx.strokeStyle = '#f0f0f0'
  for (let i = 1; i <= 5; i++) {
    const y = padding + (chartHeight / 5) * i
    ctx.beginPath()
    ctx.moveTo(padding, y)
    ctx.lineTo(width - padding, y)
    ctx.stroke()
  }
  
  // 绘制训练损失曲线
  ctx.strokeStyle = '#ff6b6b'
  ctx.lineWidth = 2
  ctx.beginPath()
  
  for (let i = 0; i < validData.length; i++) {
    const x = padding + (validData[i].epoch - minEpoch) / (maxEpoch - minEpoch) * chartWidth
    const y = height - padding - (validData[i].train_loss - minLoss) / (maxLoss - minLoss) * chartHeight
    
    if (i === 0) {
      ctx.moveTo(x, y)
    } else {
      ctx.lineTo(x, y)
    }
  }
  ctx.stroke()
  
  // 绘制验证损失曲线
  ctx.strokeStyle = '#4ecdc4'
  ctx.lineWidth = 2
  ctx.beginPath()
  
  for (let i = 0; i < validData.length; i++) {
    const x = padding + (validData[i].epoch - minEpoch) / (maxEpoch - minEpoch) * chartWidth
    const y = height - padding - (validData[i].val_loss - minLoss) / (maxLoss - minLoss) * chartHeight
    
    if (i === 0) {
      ctx.moveTo(x, y)
    } else {
      ctx.lineTo(x, y)
    }
  }
  ctx.stroke()
  
  // 绘制图例
  ctx.font = '12px Arial'
  ctx.fillStyle = '#ff6b6b'
  ctx.fillRect(width - 120, 20, 15, 3)
  ctx.fillStyle = '#333'
  ctx.fillText('训练损失', width - 100, 30)
  
  ctx.fillStyle = '#4ecdc4'
  ctx.fillRect(width - 120, 40, 15, 3)
  ctx.fillStyle = '#333'
  ctx.fillText('验证损失', width - 100, 50)
  
  // 绘制数值标签
  ctx.fillStyle = '#666'
  ctx.font = '10px Arial'
  ctx.fillText(maxLoss.toFixed(3), 5, padding + 5)
  ctx.fillText(minLoss.toFixed(3), 5, height - padding + 5)
  ctx.fillText(minEpoch.toString(), padding, height - 25)
  ctx.fillText(maxEpoch.toString(), width - padding - 10, height - 25)
}

// 绘制准确率曲线
const drawAccuracyChart = () => {
  if (!accuracyChart.value || trainingHistory.value.length === 0) return
  
  const canvas = accuracyChart.value
  const ctx = canvas.getContext('2d')
  const width = canvas.width
  const height = canvas.height
  
  // 清空画布
  ctx.clearRect(0, 0, width, height)
  
  // 获取有效数据，保持索引对应关系
  const validData = trainingHistory.value.filter(d => 
    !isNaN(d.epoch) && d.epoch !== null && d.epoch !== undefined &&
    !isNaN(d.train_acc) && d.train_acc !== null && d.train_acc !== undefined &&
    !isNaN(d.val_acc) && d.val_acc !== null && d.val_acc !== undefined
  )
  
  if (validData.length < 2) return
  
  // 获取数据
  const epochs = validData.map(d => d.epoch)
  const trainAcc = validData.map(d => d.train_acc)
  const valAcc = validData.map(d => d.val_acc)
  
  // 计算范围
  const minEpoch = Math.min(...epochs)
  const maxEpoch = Math.max(...epochs)
  const minAcc = Math.min(...trainAcc, ...valAcc) - 5
  const maxAcc = Math.max(...trainAcc, ...valAcc) + 5
  
  // 检查范围是否有效
  if (isNaN(minAcc) || isNaN(maxAcc) || minAcc === maxAcc) return
  
  const padding = 40
  const chartWidth = width - 2 * padding
  const chartHeight = height - 2 * padding
  
  // 绘制坐标轴
  ctx.strokeStyle = '#e0e0e0'
  ctx.lineWidth = 1
  
  // X轴
  ctx.beginPath()
  ctx.moveTo(padding, height - padding)
  ctx.lineTo(width - padding, height - padding)
  ctx.stroke()
  
  // Y轴
  ctx.beginPath()
  ctx.moveTo(padding, padding)
  ctx.lineTo(padding, height - padding)
  ctx.stroke()
  
  // 绘制网格线
  ctx.strokeStyle = '#f0f0f0'
  for (let i = 1; i <= 5; i++) {
    const y = padding + (chartHeight / 5) * i
    ctx.beginPath()
    ctx.moveTo(padding, y)
    ctx.lineTo(width - padding, y)
    ctx.stroke()
  }
  
  // 绘制训练准确率曲线
  ctx.strokeStyle = '#45b7d1'
  ctx.lineWidth = 2
  ctx.beginPath()
  
  for (let i = 0; i < epochs.length; i++) {
    const x = padding + (epochs[i] - minEpoch) / (maxEpoch - minEpoch) * chartWidth
    const y = height - padding - (trainAcc[i] - minAcc) / (maxAcc - minAcc) * chartHeight
    
    if (i === 0) {
      ctx.moveTo(x, y)
    } else {
      ctx.lineTo(x, y)
    }
  }
  ctx.stroke()
  
  // 绘制验证准确率曲线
  ctx.strokeStyle = '#f39c12'
  ctx.lineWidth = 2
  ctx.beginPath()
  
  for (let i = 0; i < epochs.length; i++) {
    const x = padding + (epochs[i] - minEpoch) / (maxEpoch - minEpoch) * chartWidth
    const y = height - padding - (valAcc[i] - minAcc) / (maxAcc - minAcc) * chartHeight
    
    if (i === 0) {
      ctx.moveTo(x, y)
    } else {
      ctx.lineTo(x, y)
    }
  }
  ctx.stroke()
  
  // 绘制图例
  ctx.font = '12px Arial'
  ctx.fillStyle = '#45b7d1'
  ctx.fillRect(width - 120, 20, 15, 3)
  ctx.fillStyle = '#333'
  ctx.fillText('训练准确率', width - 100, 30)
  
  ctx.fillStyle = '#f39c12'
  ctx.fillRect(width - 120, 40, 15, 3)
  ctx.fillStyle = '#333'
  ctx.fillText('验证准确率', width - 100, 50)
  
  // 绘制数值标签
  ctx.fillStyle = '#666'
  ctx.font = '10px Arial'
  ctx.fillText(maxAcc.toFixed(1) + '%', 5, padding + 5)
  ctx.fillText(minAcc.toFixed(1) + '%', 5, height - padding + 5)
  ctx.fillText(minEpoch.toString(), padding, height - 25)
  ctx.fillText(maxEpoch.toString(), width - padding - 10, height - 25)
}

// 监听训练历史数据变化，实时更新图表
watch(trainingHistory, () => {
  if (trainingHistory.value.length > 0) {
    setTimeout(() => {
      drawLossChart()
      drawAccuracyChart()
    }, 100)
  }
}, { deep: true })

// 组件挂载时获取数据集
onMounted(() => {
  fetchDatasets()
})
</script>

<style scoped>
.app-container {
  min-height: 100vh;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  padding: 24px;
  font-family: 'SF Pro Text', 'Segoe UI', 'Microsoft YaHei', sans-serif;
}

.main-wrapper {
  max-width: 1400px;
  margin: 0 auto;
}

.header-section {
  margin-bottom: 32px;
  padding: 24px 32px;
  border-radius: 16px;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
}

.header-section:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
}

.logo-area {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 20px;
}

.logo-icon {
  width: 48px;
  height: 48px;
  background: linear-gradient(135deg, #667eea, #764ba2);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 24px;
  box-shadow: 0 4px 16px rgba(102, 126, 234, 0.3);
}

.logo-area h1 {
  margin: 0;
  font-size: 28px;
  font-weight: 700;
  background: linear-gradient(135deg, #667eea, #764ba2);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.main-tabs {
  --el-tabs-header-height: 48px;
}

.tab-label {
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: 600;
}

.content-section {
  max-width: 100%;
}

.row-section {
  margin-bottom: 24px;
}

.row-section:last-child {
  margin-bottom: 0;
}

.unified-card {
  border-radius: 16px;
  border: none;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  height: 100%;
  overflow: hidden;
}

.unified-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
}

.card-title {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  font-weight: 600;
  font-size: 18px;
  color: #303133;
  padding: 8px 0;
}

.title-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.card-title i {
  font-size: 20px;
  color: #667eea;
}

.training-status {
  display: flex;
  align-items: center;
}

.chart-legend {
  display: flex;
  gap: 16px;
  align-items: center;
}

.legend-item {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  color: #606266;
}

.legend-color {
  width: 12px;
  height: 12px;
  border-radius: 2px;
}

.refresh-btn {
  color: #667eea;
  font-size: 16px;
  padding: 8px;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.refresh-btn:hover {
  background: rgba(102, 126, 234, 0.1);
  transform: rotate(180deg);
}

.card-content {
  padding: 0;
}

.upload-group {
  margin-bottom: 24px;
}

.upload-group:last-child {
  margin-bottom: 0;
}

.file-info {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-top: 16px;
  padding: 12px 16px;
  background: rgba(103, 194, 58, 0.1);
  border-radius: 8px;
  border-left: 4px solid #67c23a;
}

.success-icon {
  color: #67c23a;
  font-size: 16px;
  flex-shrink: 0;
}

.file-name {
  font-size: 14px;
  font-weight: 500;
  color: #303133;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  flex: 1;
}

.upload-actions {
  margin-top: 32px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
}

.upload-dataset-btn {
  width: 100%;
  max-width: 300px;
  padding: 16px 32px;
  font-size: 16px;
  font-weight: 600;
  background: linear-gradient(135deg, #67c23a, #85ce61);
  border: none;
  color: white;
  border-radius: 12px;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.upload-dataset-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(103, 194, 58, 0.3);
}

.upload-hint-text {
  font-size: 14px;
  color: #909399;
  text-align: center;
  padding: 16px;
  background: rgba(0, 0, 0, 0.05);
  border-radius: 8px;
  border: 1px dashed #d9d9d9;
}

.upload-area {
  width: 100%;
  border-radius: 12px;
  border: 2px dashed #d9d9d9;
  background: #fafafa;
  transition: all 0.3s ease;
}

.upload-area:hover {
  border-color: #667eea;
  background: rgba(102, 126, 234, 0.05);
}

.upload-icon {
  font-size: 48px !important;
  color: #667eea;
  margin-bottom: 12px;
}

.upload-text {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 8px;
}

.upload-hint {
  font-size: 14px;
  color: #909399;
}

.action-btn {
  margin-top: 16px;
  border-radius: 12px;
  padding: 12px 24px;
  font-weight: 600;
  background: linear-gradient(135deg, #667eea, #764ba2);
  border: none;
  color: white;
  transition: all 0.3s ease;
}

.action-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
}

.empty-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 200px;
  gap: 16px;
  color: #909399;
}

.empty-icon {
  font-size: 48px !important;
  color: #c0c4cc;
}

.empty-content p {
  margin: 0;
  font-size: 16px;
  color: #909399;
}

.dataset-card {
  height: 100%;
}

.dataset-list {
  padding: 24px;
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.dataset-item {
  cursor: pointer;
  transition: all 0.3s ease;
}

.dataset-item:hover {
  transform: translateY(-4px);
}

.dataset-item-selected .dataset-card {
  border: 2px solid #409EFF;
  box-shadow: 0 8px 24px rgba(64, 158, 255, 0.15);
}

.dataset-card {
  border-radius: 16px;
  overflow: hidden;
}

.dataset-content {
  padding: 32px;
}

.dataset-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 32px;
}

.dataset-title h4 {
  font-size: 28px;
  font-weight: 600;
  color: #333;
  margin: 0;
}

.dataset-select {
  display: flex;
  align-items: center;
}

.dataset-info {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 32px;
}

.info-item {
  display: flex;
  align-items: center;
  gap: 20px;
  padding: 28px;
  background: #f5f7fa;
  border-radius: 16px;
  min-height: 140px;
  transition: all 0.3s ease;
  border: 2px solid transparent;
}

.info-item:hover {
  background: #fff;
  border-color: #409EFF;
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(64, 158, 255, 0.15);
}

.info-item:hover .info-icon {
  transform: scale(1.1);
}

.info-icon {
  width: 56px;
  height: 56px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #409EFF, #67C23A);
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.2);
  transition: all 0.3s ease;
}

.test-icon {
  background: linear-gradient(135deg, #67C23A, #E6A23C);
}

.total-icon {
  background: linear-gradient(135deg, #E6A23C, #F56C6C);
}

.breeds-icon {
  background: linear-gradient(135deg, #F56C6C, #909399);
}

.info-icon :deep(.el-icon) {
  font-size: 28px;
  color: white;
}

.info-content {
  flex: 1;
}

.info-label {
  font-size: 16px;
  color: #666;
  margin-bottom: 12px;
}

.info-value {
  font-size: 36px;
  font-weight: 600;
  color: #333;
  line-height: 1.2;
}

@media (max-width: 768px) {
  .dataset-content {
    padding: 24px;
  }

  .dataset-header {
    margin-bottom: 24px;
  }

  .dataset-title h4 {
    font-size: 24px;
  }

  .dataset-info {
    grid-template-columns: 1fr;
    gap: 20px;
  }

  .info-item {
    min-height: 120px;
    padding: 20px;
  }

  .info-icon {
    width: 48px;
    height: 48px;
  }

  .info-icon :deep(.el-icon) {
    font-size: 24px;
  }

  .info-value {
    font-size: 28px;
  }
}

.training-controls {
  display: flex;
  gap: 16px;
  margin-bottom: 24px;
  justify-content: center;
}

.primary-btn {
  border-radius: 12px;
  padding: 14px 28px;
  font-size: 16px;
  font-weight: 600;
  background: linear-gradient(135deg, #67c23a, #85ce61);
  border: none;
  color: white;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 8px;
}

.primary-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(103, 194, 58, 0.3);
}

.danger-btn {
  border-radius: 12px;
  padding: 14px 28px;
  font-size: 16px;
  font-weight: 600;
  background: linear-gradient(135deg, #f56c6c, #f78989);
  border: none;
  color: white;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 8px;
}

.danger-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(245, 108, 108, 0.3);
}

.training-progress {
  padding: 24px;
  background: rgba(255, 255, 255, 0.6);
  border-radius: 12px;
  margin-top: 24px;
}

.progress-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.epoch-info {
  font-size: 18px;
  font-weight: 700;
  color: #303133;
}

.progress-percent {
  font-size: 16px;
  font-weight: 600;
  color: #667eea;
}

.progress-bar {
  margin-bottom: 24px;
}

.metrics-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 16px;
  margin-bottom: 24px;
}

.metric-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 16px;
  background: rgba(255, 255, 255, 0.8);
  border-radius: 12px;
  border-left: 4px solid #667eea;
  transition: all 0.3s ease;
}

.metric-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
}

.metric-icon {
  width: 40px;
  height: 40px;
  background: linear-gradient(135deg, #667eea, #764ba2);
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 18px;
  flex-shrink: 0;
}

.metric-content {
  flex: 1;
  min-width: 0;
}

.metric-label {
  font-size: 12px;
  color: #606266;
  font-weight: 500;
  margin-bottom: 4px;
}

.metric-value {
  font-size: 18px;
  font-weight: 700;
  background: linear-gradient(135deg, #667eea, #764ba2);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  line-height: 1;
}

.learning-rate-info {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  font-size: 14px;
  color: #606266;
  font-weight: 500;
  padding: 12px;
  background: rgba(255, 255, 255, 0.8);
  border-radius: 8px;
}

.chart-card .card-content {
  padding: 24px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.chart-content {
  width: 100%;
  display: flex;
  justify-content: center;
}

.chart-content canvas {
  max-width: 100%;
  height: auto;
  border-radius: 8px;
  background: rgba(255, 255, 255, 0.9);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.predict-upload {
  margin-bottom: 24px;
}

.image-preview {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
  margin-top: 24px;
}

.preview-img {
  max-width: 100%;
  max-height: 300px;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
  transition: all 0.3s ease;
}

.preview-img:hover {
  transform: scale(1.02);
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
}

.prediction-results {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.main-result {
  padding: 24px;
  background: linear-gradient(135deg, rgba(103, 194, 58, 0.1), rgba(133, 206, 97, 0.1));
  border-radius: 12px;
  border-left: 4px solid #67c23a;
}

.result-label {
  font-size: 14px;
  color: #606266;
  font-weight: 500;
  margin-bottom: 8px;
}

.result-breed {
  font-size: 24px;
  font-weight: 700;
  color: #303133;
  margin-bottom: 8px;
}

.result-english {
  font-size: 16px;
  font-weight: 500;
  color: #909399;
  font-style: italic;
  margin-bottom: 16px;
}

.confidence-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.confidence-label {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
}

.confidence-value {
  font-size: 20px;
  font-weight: 700;
  background: linear-gradient(135deg, #667eea, #764ba2);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.confidence-bar {
  margin-top: 8px;
}

.top-predictions {
  padding: 24px;
  background: rgba(255, 255, 255, 0.6);
  border-radius: 12px;
}

.top-predictions h4 {
  margin: 0 0 20px 0;
  font-size: 18px;
  font-weight: 700;
  color: #303133;
}

.predictions-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.prediction-row {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 12px 16px;
  background: rgba(255, 255, 255, 0.8);
  border-radius: 8px;
  border-left: 4px solid transparent;
  transition: all 0.3s ease;
}

.prediction-row:hover {
  transform: translateX(4px);
  border-left-color: #667eea;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.pred-info {
  display: flex;
  align-items: center;
  gap: 12px;
  min-width: 0;
  flex: 1;
}

.rank {
  font-size: 14px;
  font-weight: 700;
  color: #667eea;
  background: rgba(102, 126, 234, 0.1);
  padding: 4px 8px;
  border-radius: 6px;
  min-width: 24px;
  text-align: center;
}

.breed {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
  flex: 1;
  min-width: 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.confidence {
  font-size: 14px;
  font-weight: 600;
  color: #606266;
  margin-left: auto;
  min-width: 60px;
  text-align: right;
}

.pred-bar {
  width: 80px;
  margin-left: 16px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .app-container {
    padding: 16px;
  }

  .header-section {
    padding: 20px;
  }

  .logo-area {
    flex-direction: column;
    text-align: center;
    gap: 12px;
  }

  .logo-area h1 {
    font-size: 24px;
  }

  .training-controls {
    flex-direction: column;
    align-items: center;
  }

  .metrics-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
  }

  .dataset-item {
    padding: 24px;
  }

  .dataset-stats {
    grid-template-columns: 1fr;
    gap: 16px;
  }

  .stat-item {
    min-height: 100px;
    padding: 20px;
  }

  .stat-label {
    font-size: 14px;
    margin-bottom: 8px;
  }

  .stat-value {
    font-size: 28px;
  }

  .pred-info {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
  }

  .confidence {
    margin-left: 0;
  }

  .pred-bar {
    width: 100%;
    margin-left: 0;
  }

  .chart-legend {
    flex-direction: column;
    gap: 8px;
  }
}

@media (max-width: 480px) {
  .metrics-grid {
    grid-template-columns: 1fr;
  }

  .chart-content canvas {
    width: 100%;
    height: 200px;
  }

  .metric-item {
    flex-direction: column;
    text-align: center;
    gap: 8px;
  }
}

/* 滚动条美化 */
.dataset-list::-webkit-scrollbar {
  width: 6px;
}

.dataset-list::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0.3);
  border-radius: 3px;
}

.dataset-list::-webkit-scrollbar-thumb {
  background: rgba(102, 126, 234, 0.5);
  border-radius: 3px;
}

.dataset-list::-webkit-scrollbar-thumb:hover {
  background: rgba(102, 126, 234, 0.8);
}

/* Element Plus 组件样式覆盖 */
:deep(.el-card__body) {
  padding: 24px !important;
}

:deep(.el-button) {
  border-radius: 8px;
  font-weight: 500;
  transition: all 0.3s ease;
}

:deep(.el-tabs__nav-wrap) {
  background: none;
}

:deep(.el-tabs__item) {
  font-weight: 600;
  border-radius: 8px 8px 0 0;
}

:deep(.el-tabs__item.is-active) {
  background: rgba(102, 126, 234, 0.1);
  color: #667eea;
}

:deep(.el-radio__input.is-checked .el-radio__inner) {
  background-color: #667eea;
  border-color: #667eea;
}

:deep(.el-progress-bar__outer) {
  border-radius: 8px !important;
  background-color: rgba(0, 0, 0, 0.1) !important;
}

:deep(.el-progress-bar__inner) {
  border-radius: 8px !important;
  background: linear-gradient(135deg, #667eea, #764ba2) !important;
}

:deep(.el-upload-dragger) {
  border-radius: 12px !important;
  border: 2px dashed #d9d9d9 !important;
  background: #fafafa !important;
  transition: all 0.3s ease !important;
}

:deep(.el-upload-dragger:hover) {
  border-color: #667eea !important;
  background: rgba(102, 126, 234, 0.05) !important;
}

.tab-label .el-icon {
  font-size: 16px;
}

.logo-icon .el-icon {
  font-size: 24px;
}

.metric-icon .el-icon {
  font-size: 18px;
}

.learning-rate-info .el-icon {
  margin-right: 8px;
  font-size: 16px;
}

/* 品种详情样式 */
.breed-details {
  margin-top: 24px;
  background: rgba(255, 255, 255, 0.8);
  border-radius: 12px;
  overflow: hidden;
}

.breed-tabs {
  background: transparent;
  border: none;
}

:deep(.breed-tabs .el-tabs__header) {
  margin: 0;
  border: none;
  background: rgba(102, 126, 234, 0.05);
}

:deep(.breed-tabs .el-tabs__nav-wrap) {
  padding: 0 16px;
}

:deep(.breed-tabs .el-tabs__content) {
  padding: 0;
}

.breed-section {
  padding: 24px;
}

.breed-section h4 {
  margin: 0 0 16px 0;
  font-size: 18px;
  font-weight: 700;
  color: #303133;
  border-bottom: 2px solid #667eea;
  padding-bottom: 8px;
}

.breed-description {
  font-size: 16px;
  line-height: 1.6;
  color: #606266;
  margin-bottom: 24px;
  background: rgba(102, 126, 234, 0.05);
  padding: 16px;
  border-radius: 8px;
  border-left: 4px solid #667eea;
}

.breed-basic-info {
  margin-top: 24px;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 16px;
}

.info-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 8px;
  border-left: 3px solid #e0e0e0;
  transition: all 0.3s ease;
}

.info-item:hover {
  border-left-color: #667eea;
  transform: translateX(4px);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.info-label {
  font-weight: 600;
  color: #303133;
  font-size: 14px;
}

.info-value {
  font-weight: 500;
  color: #606266;
  font-size: 14px;
}

.care-level.easy {
  color: #67c23a;
  font-weight: 600;
}

.care-level.normal {
  color: #e6a23c;
  font-weight: 600;
}

.care-level.hard {
  color: #f56c6c;
  font-weight: 600;
}

.exercise-need.low {
  color: #909399;
  font-weight: 600;
}

.exercise-need.medium {
  color: #e6a23c;
  font-weight: 600;
}

.exercise-need.high {
  color: #f56c6c;
  font-weight: 600;
}

.characteristics-list {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.characteristic-tag {
  font-size: 14px;
  padding: 8px 16px;
  border-radius: 20px;
  background: rgba(102, 126, 234, 0.1);
  color: #667eea;
  border: 1px solid rgba(102, 126, 234, 0.2);
  transition: all 0.3s ease;
}

.characteristic-tag:hover {
  background: rgba(102, 126, 234, 0.15);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
}

.diseases-list {
  margin-bottom: 24px;
}

.disease-item {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  padding: 12px 16px;
  margin-bottom: 8px;
  background: rgba(245, 108, 108, 0.05);
  border-radius: 8px;
  border-left: 3px solid #f56c6c;
  transition: all 0.3s ease;
}

.disease-item:hover {
  background: rgba(245, 108, 108, 0.1);
  transform: translateX(4px);
}

.disease-icon {
  color: #f56c6c;
  font-size: 16px;
  margin-top: 2px;
  flex-shrink: 0;
}

.disease-name {
  flex: 1;
  font-size: 14px;
  color: #303133;
  line-height: 1.5;
}

.health-tip {
  margin-top: 24px;
}

/* 更新预测行样式 */
.prediction-row {
  cursor: pointer;
}

.prediction-row.selected {
  background: rgba(102, 126, 234, 0.1);
  border-left-color: #667eea;
  transform: translateX(4px);
}

.breed-names {
  display: flex;
  flex-direction: column;
  gap: 4px;
  flex: 1;
  min-width: 0;
}

.breed-names .breed {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.breed-names .breed-english {
  font-size: 12px;
  font-weight: 400;
  color: #909399;
  font-style: italic;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* 响应式设计优化 */
@media (max-width: 768px) {
  .info-grid {
    grid-template-columns: 1fr;
  }
  
  .breed-section {
    padding: 16px;
  }
  
  .breed-description {
    padding: 12px;
  }
  
  .characteristics-list {
    gap: 8px;
  }
  
  .characteristic-tag {
    font-size: 12px;
    padding: 6px 12px;
  }
}

:deep(.breed-tabs .el-tabs__item) {
  font-size: 14px;
  padding: 0 16px;
  height: 48px;
  line-height: 48px;
}
</style>