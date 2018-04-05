% --------------------------------------------------------
% Copyright (c) Weiyang Liu, Yandong Wen
% Licensed under The MIT License [see LICENSE for details]
% 这是一个修改后的人脸裁剪，可选择使用wuxiang及seetaface缩小后的五点对齐
% Intro:
% This script is used to align the faces by similarity transformation.
%
% Usage:
% cd $SPHEREFACE_ROOT/preprocess
% run code/face_align_demo.m
% --------------------------------------------------------

function face_align_demo()

clear;clc;close all;
cd('../');
addpath(genpath('code/'));

load('result/dataList.mat')
%% alignment settings: Yandong
% imgSize     = [112, 96];
% coord5point = [30.2946, 51.6963;
%                65.5318, 51.5014;
%                48.0252, 71.7366;
%                33.5493, 92.3655;
%                62.7299, 92.2041];
 
%% alignment settings: seetaface          
  imgSize     = [128, 128];
  coord5point_256 = [89.3095, 72.9025;
                169.3095, 72.9025;
                127.8949, 127.0441;
                96.8796, 184.8907;
                159.1065, 184.7601];
  coord5point = coord5point_256*128/256;   
   
%%
   align_method = 'wuxiang';% wuxiang or seetaface
     
%% face alignment
for i = 1:length(dataList)
    fprintf('aligning the %dth image...\n', i);
    if isempty(dataList(i).facial5point)
       continue;
    end
    dataList(i).facial5point = double(dataList(i).facial5point);
    % load and crop image
    img      = imread(dataList(i).file);
    
    if strcmp(align_method, 'wuxiang') > 0
            if strcmp(dataList(i).dataset, 'CASIA-WebFace') > 0
                [res, eyec2, cropImg, resize_scale] = align_face_WX(img,dataList(i).facial5point,144,48,48);
                 cropImg = uint8(cropImg);
            else
                [res, eyec2, cropImg, resize_scale] = align_face_WX(img,dataList(i).facial5point,128,48,40);
                 cropImg = uint8(cropImg);
            end;
    else
    transf   = cp2tform(dataList(i).facial5point, coord5point, 'similarity');
    cropImg  = imtransform(img, transf, 'XData', [1 imgSize(2)],...
                                    'YData', [1 imgSize(1)], 'Size', imgSize);
    end;

    % save image
    [sPathStr, name, ext] = fileparts(dataList(i).file);
    tPathStr = strrep(sPathStr, '/data/', '/result/');
    if strcmp(align_method, 'wuxiang') > 0
        tPathStr = strrep(tPathStr, dataList(i).dataset, [dataList(i).dataset '-wx-128X128']);
    else
        tPathStr = strrep(tPathStr, dataList(i).dataset, [dataList(i).dataset '-128X128']);
    end;
    if ~exist(tPathStr, 'dir')
       mkdir(tPathStr)
    end
    imwrite(cropImg, fullfile(tPathStr, [name, '.jpg']), 'jpg');

end

end