%% �ŵ�������
clc;clear;
%% ���Զ�Ԫɾ���ŵ����ŵ����뷽��
Ce = '112211000111022121';

C = [1 1 -0.2;-0.2 1 1;0 0 0;1 1 1;0 -0.2 -0.2;1 -0.2 1];
% T = reshape(str2num(Ce(:))', 3, length(Ce) / 3)';
% 
M = C * ones(1,3)';
M(find(M(:) <= 0)) = 0;
M(find(M(:) > 0)) = 1;
r = rand(1,1);
if r > 0.5
   M(find(M(:) == -0.6)) = 1;
else
   M(find(M(:) == -0.6)) = 0;
end
 
% Cx = num2str(N)';
%% ����ͳ���ַ�
% A = [1 0 1 0 1 1 1 0 1 1 0 1];
% num_all = length(A);

% A = [];
% res = ~isempty(A);
%% ���Զ�Ԫɾ���ŵ�
% Ck = '111000111111000111000';
% p = 0.2;
% len = length(Ck);
% c = str2num(Ck(:))';% ��ÿ�������е����֣����ַ���ת��Ϊ��ֵ����
% ran = rand(1,len);
% for i = 1 : len
%     if ran(i) < p
%         c(i) = 2;% ��������Ϊ 2�������� e�������ڲ��ñ�ʾ
%     end
% end
% Ce = c;% �ŵ������ 
% Ce = num2str(Ce, '%d');



%% ����
% ��ÿ�����ص��ŵ����ÿ��������Ϊһ�У����ɾ���
T = reshape(s(:), 3, length(s) / 3)';
% ���ÿһ�� 1 �ĸ������������ N ��
N = T * ones(1, 3)';
% �� N �е�С�ڵ��� 1 ����Ϊ 0
N(find(N(:) <= 1)) = 0;
% �� N �д��� 1 ����Ϊ 1
N(find(N(:) > 1)) = 1;
cnt = N';

% ��ÿ�����ص��ŵ����ÿ��������Ϊһ�У����ɾ���
T = reshape(s(:), 3, length(s) / 3)';
% ���ÿһ����Ӧλ�õ���Ϣ����1�ĸ�����0�ĸ������ߴ�����Ԫ������������� N ��
N = T * ones(1, 3)';
% �� N �е�С�ڵ��� 0 ����Ϊ 0
N(find(N(:) <= 0)) = 0;
% �� N �д��� 0 ����Ϊ 1
N(find(N(:) > 0)) = 1;
r = rand(1,1);% ������������ж�����λ��Ϊ eee ʱ��Ӧ����ν����ж�
if r > 0.5 % �涨��������� r ����0.5������λ���������Ϊ1��������Ϊ0
   N(find(N(:) == -0.6)) = 1;
else
   N(find(N(:) == -0.6)) = 0;
end
cnt = N';

% ��ÿ�����ص��ŵ����ÿ��������Ϊһ�У����ɾ���
T = reshape(s(:), 3, length(s) / 3)';
N = T * ones(1, 3)';
for i = 1 : length(N)
   cnt = N(i);
   % P_0 ��������ͼ��ı����������� 0 �ĸ���
   p0 = p^cnt * (1 - p)^(3 - cnt) * P_0;% ���P(xy)--000
   p1 = p^(3 - cnt) * (1 - p)^cnt * (1 - P_0);% ���P(xy)--111
   if p0 > p1
       N(i) = 0;
   elseif p0 < p1
       N(i) = 1; 
   else % ��ȵĻ���ȡ�����
       ran = rand(1, 1);
       if ran > 0.5
           N(i) = 1;
       else
           N(i) = 0;
       end
   end
end
cnt = N';


T = reshape(s(:), 3, length(s) / 3)';
N = T * ones(1, 3)';
% �������루�ŵ������������ظ����룩
N(find(N(:) <= 0)) = 0;
N(find(N(:) > 0)) = 1;
% ������Դ���ʣ����������������
if P_0 > 0.5
   N(find(N(:) == -0.6)) = 1;
else
   N(find(N(:) == -0.6)) = 0;
end
cnt = N';



function imageH = image_huffman(Cx, Cm)
    [m, n] = size(Cx);
    imageH = zeros(m, n) + 255;
    for x = 1 : m
        for y = 1 : n
            temp = num2str(Cx{x, y}, '%d');
            for k = 1 : 256
               if strcmp(temp, Cm{k}) == 1
                  imageH(x, y) = k - 1;
                  break;
               end
            end
        end
    end
end