%% 费诺信源编码
%  1.将消息按概率递减排序
%  2.把消息集按概率进行分组，使得到的两个分组的概率之和尽量相等
%  3.把两个分组分别标记为0和1
%  3.然后递归操作，直到每个消息集中只含有一个消息
%  4.最终得到的码元排列起来就是编码

%% 函数
function [Cm, P1, avlen] = fano(image)
    %对图像中的每一级灰度进行统计
    [m, n] = size(image);%得到图像的大小，行数和列数
    nums = imhist(image)';
    %得到每一级灰度的出现概率，降序排序
    P = sort(nums / (m * n), 'descend');
    [~, q] = size(P);
    Cm = cell(1, q);
    Cm = fano2(P, Cm, 0);
    
    % 求平均码长
    L = zeros(1, q);
    for i = 1 : q
        [~, b] = size(char(Cm(i)));%每位数据转为char型，size后即每个i对应于1行，码长列的矩阵
        L(i) = b;%取b，即取码长
    end
    avlen = sum(L.*P);  %平均码长，码长乘以概率求和
    
    %求信源熵
    H = 0;
    for x = 1 : q
        if P(x) ~= 0
            H = H + (-P(x) * log2(P(x)));%求信源熵
        end
    end
    P1 = H / avlen ; %编码效率 = 熵 / 平均码长
end