%% ������Դ���뷽ʽ��ͬʱ������Ľ��
I = imread('image/test30_28.png');
gray_I = rgb2gray(I);
p = 0.01;
chan_mod = 1;% �ŵ����ͣ�ѡ���Ԫ�Գ��ŵ�
dec_mod = 1;% �ŵ��������ͣ�ѡ�񼫴���Ȼ����׼��
tic;
[imageH, P1, avlen] = gui_source_encoding(gray_I, p, chan_mod, dec_mod);
toc;
figure(1); imshow(uint8(gray_I));
figure(2); imshow(uint8(imageH{1}));
figure(3); imshow(uint8(imageH{2}));
figure(4); imshow(uint8(imageH{3}));