%% �γ������Ŀ
% ��Ŀ������ͼ��ѹ������ 
% �������һ����ͨ��ϵͳ����ɽ�һ��ԭʼͼ����Դ����ѹ��������䡢�ָ�������Ϊ���շ������ޣ����յĹ��̡� 
% ��Դ���趨�������ͼ����һ��8��8�ĺڰ׶�ֵͼ��
% ��Դ���룺��ũ����ŵ������������
% �ŵ����룺���ظ�����
% �ŵ��������ƶԳ��ŵ�����Ԫɾ���ŵ�
% �ŵ����룺��������ʡ�������Ȼ��������׼��
% ��Դ���룺��ʧ�����
%% �ֶ�����һ��ͼƬ����������
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
%             H = H + (-P(x) * log2(P(x)));%����Դ��
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
%% �ŵ��Ĵ���ת�Ƹ���
p = 0.1;
subplot(221);imshow(I);title("ԭʼͼ��");
[imageH, P1, avlen, C, Pe1, Pe2] = fun_for_gui(I, p, 1, 2, 1);
subplot(222);imshow(uint8(imageH));title("������Ȼ����׼���ͼ��");
disp(strcat("�������Ϊ��", num2str(P1)));
disp(strcat("ƽ���볤Ϊ��",num2str(avlen)));
disp(strcat("�ŵ�����Ϊ��",num2str(C)));
disp(strcat("ƽ���������Ϊ��",num2str(Pe1)));
% 
% subplot(223);imshow(I);title("ԭʼͼ��");
% [imageH, P1, avlen, C, Pe] = fun_for_gui(I, p, 2, 2, 1);
% subplot(224);imshow(uint8(imageH));title("���������׼���ͼ��");
% disp(strcat("�������Ϊ��", num2str(P1)));
% disp(strcat("ƽ���볤Ϊ��",num2str(avlen)));
% disp(strcat("�ŵ�����Ϊ��",num2str(C)));
% disp(strcat("ƽ���������Ϊ��",num2str(Pe)));