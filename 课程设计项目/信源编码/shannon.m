%% 香农信源编码
%  1.将信源发出的M个消息，按其概率递减的顺序进行排列
%  2.计算各消息的信息量
%  3.根据信息量得到每个消息的码长n，四舍五入
%  4.计算第m个信号的累加概率Pm，将Pm转换为二进制，取小数点后面的n位，作为码组

%% 函数
function [Cz, P1, avlen] = shannon(image)
    %对图像中的每一级灰度进行统计
    [m, n] = size(image);%得到图像的大小，行数和列数
    nums = imhist(image)';
    %得到每一级灰度的出现概率，降序排序
    [P, K] = sort(nums / (m * n), 'descend');
    % 计算自信息量
    I = -log2(P);
    [~, q] = size(I);
    % 得到码长
    Nm = zeros(1, q);
    for n = 1 : q
       if(I(n) ~= Inf)% 出现概率为0的灰度，其码长设置为0
           Nm(n) = ceil(I(n));%向上取整
       end
    end
    
    % 计算累加概率
    Pm = zeros(1, q);
    for x = 2 : q 
       Pm(x) = Pm(x - 1) + P(x - 1); 
    end
    % 进行编码，并返回该编码结果
    Cm = cell(1, q);
    for i = 1 : q
       Cm(i) = ten2two(Pm(i), Nm(i));
    end
    
    % 将该编码重建到对应的灰度上
    Cz = cell(1, q);
    for x = 1 : 256
        Cz{K(x)} = Cm{x};
    end
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
    P1 = H / avlen ; %信息传输率 = 熵 / 平均码长
end