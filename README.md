# small_model_face_recognition
针对移动端的人脸识别需求，训练测试一些的小模型相关实验。

### 目录
0. [前言](#前言)
0. [环境安装](#环境安装)
0. [数据预处理](#数据预处理)
0. [模型训练](#模型训练)
0. [模型测试](#模型测试)
0. [相关参考](#相关参考)


### 前言

  当前效果良好的人脸识别相关模型整体大小基本偏大，占用内存大，计算费时，并不太适合嵌入式移动端的应用，本项目主要基于改进lightcnn模型，训练适用于移动端的人脸识别小模型；
  
### 环境安装

1. 下载相关代码，并更新子模块；

```

git clone https://github.com/moli232777144/small_model_face_recognition.git

git submodule update --init

```
2. 安装happynear的[caffe-windows](https://github.com/happynear/caffe-windows)，编译GPU版本，并配置matlab环境；


### 数据预处理
 
note： 切换preprocess目录下

1.  下载 CAISA-WebFace和LFW数据库，放至data目录；

2.  运行code/face_detect_demo.m，提取人脸相关信息，result下将会生成dataList.mat文件；

3.  运行code/face_align_demo.m，data目录下将会生成CASIA-WebFace-wx-128X128和lfw-wx-128X128的对齐图像；

### 模型训练
 
note： 切换train目录下

1.  复制数据预处理的CASIA-WebFace-wx-128X128目录到data目录下；

2.  运行code/get_list.m，获取CASIA-WebFace-wx-128X128.txt；

3.  运行code/lightcnn_small_train.bat；

4.  降低学习率等，调参；

### 模型训练
 
note： 切换test目录下
1.  复制数据预处理的lfw-wx-128X128目录到data目录下；

2.  下载lLFW([view 2](http://vis-www.cs.umass.edu/lfw/#views))的测试pairs.txt至data目录下；

3.  运行code/evaluation.m，获取识别率；

### 相关参考
 
[lightcnn](https://github.com/AlfredXiangWu/face_verification_experiment)

[sphereface](https://github.com/wy1iu/sphereface)

[NormFace](https://github.com/happynear/NormFace)
