%% 测试信道译码方式不同时，传输的结果
% I = imread('image/Lenna.jpg');
I = imread('image/house.tif');
[m,n,c] = size(I);
if c == 3
    gray_I = rgb2gray(I);
else 
    gray_I = I;
end
p = 0.01;
chan_mod = 1;% 信道类型，选择二元对称信道   
encd = 1;
tic;
[imageH, Pe1, Pe2] = gui_channel_decode(gray_I, p, chan_mod, encd);
toc;
figure(1); imshow(uint8(gray_I));
figure(2); imshow(uint8(imageH{1}));
figure(3); imshow(uint8(imageH{2}));
