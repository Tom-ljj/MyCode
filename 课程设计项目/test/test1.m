%% 信道的特性
clc;clear;
%% 测试二元删除信道的信道译码方法
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
%% 测试统计字符
% A = [1 0 1 0 1 1 1 0 1 1 0 1];
% num_all = length(A);

% A = [];
% res = ~isempty(A);
%% 测试二元删除信道
% Ck = '111000111111000111000';
% p = 0.2;
% len = length(Ck);
% c = str2num(Ck(:))';% 将每个像素中的码字，从字符串转换为数值数组
% ran = rand(1,len);
% for i = 1 : len
%     if ran(i) < p
%         c(i) = 2;% 错误码译为 2，本来是 e，但由于不好表示
%     end
% end
% Ce = c;% 信道的输出 
% Ce = num2str(Ce, '%d');



%% 商用
% 将每个像素的信道输出每三个划分为一行，构成矩阵
T = reshape(s(:), 3, length(s) / 3)';
% 求出每一行 1 的个数，结果存在 N 中
N = T * ones(1, 3)';
% 将 N 中的小于等于 1 的置为 0
N(find(N(:) <= 1)) = 0;
% 将 N 中大于 1 的置为 1
N(find(N(:) > 1)) = 1;
cnt = N';

% 将每个像素的信道输出每三个划分为一行，构成矩阵
T = reshape(s(:), 3, length(s) / 3)';
% 求出每一行相应位置的信息（如1的个数，0的个数或者错误码元数），结果存在 N 中
N = T * ones(1, 3)';
% 将 N 中的小于等于 0 的置为 0
N(find(N(:) <= 0)) = 0;
% 将 N 中大于 0 的置为 1
N(find(N(:) > 0)) = 1;
r = rand(1,1);% 随机数，用于判定当三位都为 eee 时，应当如何进行判定
if r > 0.5 % 规定：当随机数 r 大于0.5，则将三位都错误的判为1；否则判为0
   N(find(N(:) == -0.6)) = 1;
else
   N(find(N(:) == -0.6)) = 0;
end
cnt = N';

% 将每个像素的信道输出每三个划分为一行，构成矩阵
T = reshape(s(:), 3, length(s) / 3)';
N = T * ones(1, 3)';
for i = 1 : length(N)
   cnt = N(i);
   % P_0 就是输入图像的编码后的码字中 0 的概率
   p0 = p^cnt * (1 - p)^(3 - cnt) * P_0;% 求出P(xy)--000
   p1 = p^(3 - cnt) * (1 - p)^cnt * (1 - P_0);% 求出P(xy)--111
   if p0 > p1
       N(i) = 0;
   elseif p0 < p1
       N(i) = 1; 
   else % 相等的话就取随机数
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
% 反向译码（信道编码是三次重复编码）
N(find(N(:) <= 0)) = 0;
N(find(N(:) > 0)) = 1;
% 根据信源概率，单独处理这种情况
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