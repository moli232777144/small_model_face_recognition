# small_model_face_recognition
针对移动端的人脸识别需求，训练测试一些的小模型相关实验。

### 目录
0. [前言](#前言)
0. [环境安装](#环境安装)
0. [数据预处理](#数据预处理)
0. [模型训练](#模型训练)
0. [模型测试](#模型测试)
0. [评测结果](#评测结果)
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

### 模型测试
 
note： 切换test目录下
1.  复制数据预处理的lfw-wx-128X128目录到data目录下；

2.  下载LFW([view 2](http://vis-www.cs.umass.edu/lfw/#views))的测试pairs.txt至data目录下；

3.  运行code/evaluation.m，获取识别率；

### 评测结果
 

1.  初调loss可降低至2.6左右，LFW识别率98.33%；

2.  安卓端搭ncnn框架评测，实时速度可达30ms以下，具体数据如下；
  


```
M6Note:/data/local/tmp/bin $ ./benchncnn 8 8 0
loop_count = 8
num_threads = 8
powersave = 0
      small_face  min =   22.55  max =   24.80  avg =   23.66
  LightenedCNN_A  min =  218.03  max =  259.79  avg =  227.34
  LightenedCNN_B  min =   77.43  max =   83.81  avg =   79.04
      squeezenet  min =   44.52  max =   69.33  avg =   49.68
       mobilenet  min =   74.12  max =  109.70  avg =   79.87
    mobilenet_v2  min =   86.45  max =  111.27  avg =   91.01
      shufflenet  min =   28.59  max =   30.10  avg =   28.93
       googlenet  min =  139.83  max =  184.98  avg =  154.34
        resnet18  min =  183.14  max =  203.49  avg =  190.05
         alexnet  min =  195.94  max =  219.97  avg =  205.58

```


### 相关参考
 
[lightcnn](https://github.com/AlfredXiangWu/face_verification_experiment)

[sphereface](https://github.com/wy1iu/sphereface)

[NormFace](https://github.com/happynear/NormFace)
