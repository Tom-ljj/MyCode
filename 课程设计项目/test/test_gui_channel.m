%% 测试信道类型不同时，传输的结果
clc;clear;
I = imread('image/Lenna.jpg');
gray_I = rgb2gray(I);
p = 0.1;
chan_mod = 1;% 信道类型，选择二元对称信道
dec_mod = 1;% 信道译码类型，选择极大似然译码准则
encd = 1;% 信源编码方法
tic;
[imageH, C, Pe1, Pe2] = gui_channel(gray_I, p, dec_mod, encd);
toc;
figure(1); imshow(uint8(gray_I));
figure(2); imshow(uint8(imageH{1}));
figure(3); imshow(uint8(imageH{2}));% 没有信道编码过程的输出图像
