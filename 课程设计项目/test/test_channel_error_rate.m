%% ������Դ���뷽ʽ��ͬʱ������Ľ��
clc; clear;
I = imread('image/Lenna.jpg');
gray_I = rgb2gray(I);
p = [0.01 0.05 0.1];
chan_mod = 1;% �ŵ����ͣ�ѡ���Ԫ�Գ��ŵ�
dec_mod = 2;% �ŵ��������ͣ�ѡ�񼫴���Ȼ����׼��
encd = 1;
tic;
[imageH, C, Pe1, Pe2] = gui_channel_error_rate(gray_I, p, encd, chan_mod, dec_mod);
toc;
figure(1); imshow(uint8(gray_I));
figure(2); imshow(uint8(imageH{1}));
figure(3); imshow(uint8(imageH{2}));
figure(4); imshow(uint8(imageH{3}));
% ���ں����ص�����