%% 课程设计项目
% 题目：数字图像压缩传输 
% 任务：设计一数字通信系统，完成将一幅原始图像（信源）经压缩编码后传输、恢复，最终为接收方（信宿）接收的过程。 
% 信源：设定待传输的图像是一幅8×8的黑白二值图像
% 信源编码：香农、费诺、哈夫曼编码
% 信道编码：简单重复编码
% 信道：二进制对称信道、二元删除信道
% 信道解码：最大后验概率、极大似然概率译码准则
% 信源解码：无失真解码
%% 手动输入一张图片，用来测试
clc; clear;
I = imread('image/baby_GT.bmp');
% I = imread('image/house.tif');
% I = imread('Lenna.jpg');
% size(I);
[m, n, c] = size(I);
if c == 3
    I = rgb2gray(I);
end
% [H, D] = imhist(I);
% H = H';
% t = find(H);
% P = [0.2 0.19 0.18 0.17 0.15 0.11 0];
% T = P(find(P ~= 0));
% S = -sum(T .* log2(T)); 
%     H = 0;
%     for x = 1 : 7
%         if P(x) ~= 0
%             H = H + (-P(x) * log2(P(x)));%求信源熵
%         end
%     end

% s = '000111111000111000000';
% s = str2num(s(:))';
% G = reshape(s, 3, length(s) / 3)';
% t = G(1, :);
% 
% c = num2str(t, '%d');
% T = [s; s; s];
% R = reshape(T, 1, 3 * length(s));

% A = 1 : 5;
% R = A(find(A == 2));

% k = '101010001011100000100010';
% T = reshape(str2num(k(:))', 3, length(k) / 3)';
% N = T * ones(1, 3)';
% p = 0.01;
% P_0 = 0.6;
% Pe = 0;
% for i = 1 : length(N)
%    cnt = N(i);
%    p1 = p^cnt * (1 - p)^(3 - cnt) * P_0;
%    p0 = p^(3 - cnt) * (1 - p)^cnt * (1 - P_0);
%    if p0 > p1
%        N(i) = 0;
%        Pe = Pe + p1;
%    elseif p0 > p1
%        N(i) = 1;
%        Pe = Pe + p0;
%    else
%        ran = rand(1, 1);
%        if ran > 0.5
%            N(i) = 1;
%        else
%            N(i) = 0;
%        end
%        Pe = Pe + p0;
%    end
% end
%% 信道的错误转移概率
p = 0.1;
subplot(221);imshow(I);title("原始图像");
[imageH, P1, avlen, C, Pe1, Pe2] = fun_for_gui(I, p, 1, 2, 1);
subplot(222);imshow(uint8(imageH));title("极大似然译码准则的图像");
disp(strcat("传输概率为：", num2str(P1)));
disp(strcat("平均码长为：",num2str(avlen)));
disp(strcat("信道容量为：",num2str(C)));
disp(strcat("平均错误概率为：",num2str(Pe1)));
% 
% subplot(223);imshow(I);title("原始图像");
% [imageH, P1, avlen, C, Pe] = fun_for_gui(I, p, 2, 2, 1);
% subplot(224);imshow(uint8(imageH));title("最大后验概率准则的图像");
% disp(strcat("传输概率为：", num2str(P1)));
% disp(strcat("平均码长为：",num2str(avlen)));
% disp(strcat("信道容量为：",num2str(C)));
% disp(strcat("平均错误概率为：",num2str(Pe)));