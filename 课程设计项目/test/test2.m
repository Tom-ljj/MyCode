%% �ŵ���ͬʱ�Ĳ���
clc; clear;
I = imread('Lenna.jpg');
I = rgb2gray(I);

p = 0.01;

tic;
[imageH, P1, avlen, C, Pe] = gui_channel(I, p, 1, 1);
toc;

subplot(221);imshow(I);title("ԭʼͼ��");
subplot(222);imshow(uint8(imageH{1}));title("��Ԫ�Գ��ŵ���ͼ��");
disp(strcat("�������Ϊ��", num2str(P1)));
disp(strcat("ƽ���볤Ϊ��",num2str(avlen)));
disp(strcat("�ŵ�����Ϊ��",num2str(C(1))));
disp(strcat("ƽ���������Ϊ��",num2str(Pe(1))));

subplot(223);imshow(I);title("ԭʼͼ��");
subplot(224);imshow(uint8(imageH{2}));title("���Ԫɾ���ŵ���ͼ��");
disp(strcat("�������Ϊ��", num2str(P1)));
disp(strcat("ƽ���볤Ϊ��",num2str(avlen)));
disp(strcat("�ŵ�����Ϊ��",num2str(C(2))));
disp(strcat("ƽ���������Ϊ��",num2str(Pe(2))));