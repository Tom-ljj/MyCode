%% 信道不同时的测试
clc; clear;
I = imread('Lenna.jpg');
I = rgb2gray(I);

p = 0.01;

tic;
[imageH, P1, avlen, C, Pe] = gui_channel(I, p, 1, 1);
toc;

subplot(221);imshow(I);title("原始图像");
subplot(222);imshow(uint8(imageH{1}));title("二元对称信道的图像");
disp(strcat("传输概率为：", num2str(P1)));
disp(strcat("平均码长为：",num2str(avlen)));
disp(strcat("信道容量为：",num2str(C(1))));
disp(strcat("平均错误概率为：",num2str(Pe(1))));

subplot(223);imshow(I);title("原始图像");
subplot(224);imshow(uint8(imageH{2}));title("最二元删除信道的图像");
disp(strcat("传输概率为：", num2str(P1)));
disp(strcat("平均码长为：",num2str(avlen)));
disp(strcat("信道容量为：",num2str(C(2))));
disp(strcat("平均错误概率为：",num2str(Pe(2))));