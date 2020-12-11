%% 一个完整的通信系统
% 输出：
% imageH---------得到的系统输出的图像
%     P1---------信息传输率
%  avlen---------平均码长
%      C---------信道容量
%     Pe---------误码率
% 输入：
% gary_I----------待传输的图像的灰度图
%      p----------错误转移概率
%   encd----------使用的信源编码方式
%  chan_mod-------信道选择
%  dec_mod--------信道译码方式
function [imageH, P1, avlen, C, Pe1, Pe2] = fun_for_gui(gray_I, p, dec_mod, chan_mod, encd)
    %% 设计一个GUI界面，将主要实现的功能的接口传入该位置
    [m, n] = size(gray_I);
    %% 信源编码，使用三种信源编码方式
    Cm = cell(1, 256);
    % 在 GUI 界面选择一种方式进行编码
    switch encd
        case 1
            [Cm, P1, avlen] = shannon(gray_I);
        case 2
            [Cm, P1, avlen] = fano(gray_I);
        case 3
            [Cm, P1, avlen] = huffman(gray_I);% 霍夫曼编码，得到编码后的二进制码字
    end
    % 将原图像中的每一位灰度，转换为对应的码字，将该数值矩阵存入变量Cn中
    Cn = cell(m, n);
    for x = 1 : m
        for y = 1 : n
            grayVal = gray_I(x, y);
            for k = 1 : 256
                if grayVal == (k - 1)
                    Cn(x, y) = Cm(k); 
                    break;
                end
            end
        end
    end
    
    % 统计整张图像的 0 出现的概率
    all = 0;
    cnt = 0;
    for x = 1 : m
        for y = 1 : n
            temp = str2num(Cn{x, y}(:))';
            all = length(temp) + all;
            cnt = cnt + sum(temp(:) == 0);
        end
    end
    P_0 = cnt / all;
    %% 信道编码，三次重复编码
    Ck = rep_code(Cn);

    %% 模拟信道，使用二元对称信道
    C = log2(2) + p * log2(p) + (1 - p) * log2(1 - p);% 二元对称信道的信道容量
    
    % 错误转移概率为p
    if chan_mod == 1
        Ce = bsc(Ck, p);%二元对称信道的输出
    else
        Ce = bec(Ck, p);%二元删除信道的输出
    end
    %% 信道译码，使用最大后验概率译码准则和极大似然概率译码准则
    if chan_mod == 1
        [Cx, Pe1] = dec_bsc(Ce, dec_mod, P_0, p);
    else
        [Cx, Pe1] = dec_bec(Ce, dec_mod, P_0, p);
    end
    
    % 计算误码率 Pe2
    cnt = 0;
    for x = 1 : m
        for y = 1 : n
            temp = str2num(Cn{x, y}(:))';
            for i = 1 : length(Cx{x, y})
               if Cx{x, y}(i) ~= temp(i)
                   cnt = cnt + 1;
               end
            end
        end
    end
    Pe2 = cnt / all;
    
    %% 信源译码，使用信源编码的逆过程
    imageH = image_huffman(Cx, Cm);
end