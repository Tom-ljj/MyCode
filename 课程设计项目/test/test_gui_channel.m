%% �����ŵ����Ͳ�ͬʱ������Ľ��
clc;clear;
I = imread('image/Lenna.jpg');
gray_I = rgb2gray(I);
p = 0.1;
chan_mod = 1;% �ŵ����ͣ�ѡ���Ԫ�Գ��ŵ�
dec_mod = 1;% �ŵ��������ͣ�ѡ�񼫴���Ȼ����׼��
encd = 1;% ��Դ���뷽��
tic;
[imageH, C, Pe1, Pe2] = gui_channel(gray_I, p, dec_mod, encd);
toc;
figure(1); imshow(uint8(gray_I));
figure(2); imshow(uint8(imageH{1}));
figure(3); imshow(uint8(imageH{2}));% û���ŵ�������̵����ͼ��
