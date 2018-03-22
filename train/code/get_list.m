% --------------------------------------------------------
% Copyright (c) Weiyang Liu, Yandong Wen
% Licensed under The MIT License [see LICENSE for details]
%
% Intro:
% Get a image list `$SPHEREFACE_ROOT/train/data/CASIA-WebFace-112X96.txt`,
% which is needed by caffe-sphereface
%
% Usage:
% cd $SPHEREFACE_ROOT/train
% run code/get_list.m
% --------------------------------------------------------

clear;clc;close all;
cd('../');

folder    = fullfile(pwd, 'data/CASIA-WebFace-wx-128X128');
subFolder = struct2cell(dir(folder))';
subFolder = subFolder(3:end, 1);

% exclude the identities appearing in LFW dataset
indx = ismember(subFolder, [{'0000513'}, {'0004539'}, {'0004763'}, {'0005009'}, {'0005082'}, {'0005172'}, {'0166921'}, {'0208962'}, {'0430107'}, {'0662519'}, {'0955471'}, {'1056413'}, {'1091782'}, {'1193098'}, {'1303492'}, {'2425974'}, {'3478560'}]);
subFolder(indx) = [];

% create the list for trianing
fid = fopen('data/CASIA-WebFace-wx-128X128.txt', 'w');
for i = 1:length(subFolder)
    fprintf('Collecting the %dth folder (total %d) ...\n', i, length(subFolder));
    subList   = struct2cell(dir(fullfile(folder, subFolder{i}, '*.jpg')))';
    fileNames = fullfile(folder, subFolder{i}, subList(:, 1));
    for j = 1:length(fileNames)
        fprintf(fid, '%s %d\n', fileNames{j}, i-1);
    end
end
fclose(fid);