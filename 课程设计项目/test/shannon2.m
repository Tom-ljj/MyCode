%% 函数
function res = shannon2(mul)
    [~, n] = size(mul);%得到一维矩阵的长度
    P = sort(mul, 'descend');
    % 计算自信息量
    I = -log2(P);
    % 得到码长
    Nm = zeros(1, n);
    for x = 1 : n
       Nm(x) = ceil(I(x));%向上取整
    end
    
    % 计算累加概率
    Pm = zeros(1, n);
    for x = 2 : n 
       Pm(x) = Pm(x - 1) + P(x - 1); 
    end
    disp("-----概率------");
    disp(P);
    disp("-----自信息量------");
    disp(I);
    disp("------码长-----");
    disp(Nm);
    disp("-----累加概率------");
    disp(Pm);
    
    Cm = cell(1, n);
    for i = 1 : n
       Cm(i) = ten2two(Pm(i), Nm(i)); % 右边的是一个字符串，左边的是一个double类型的数组，无法存储字符串
    end
    res = Cm;
end