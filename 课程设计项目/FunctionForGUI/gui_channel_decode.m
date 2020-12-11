%% 信道译码方式对传输结果的影响
% 输出：
% imageH---------得到的系统输出的图像
%     Pe---------平均错误概率
% 输入：
% gary_I----------待传输的图像的灰度图
%      p----------错误转移概率
%   encd----------使用的信源编码方式
%  chan_mod-------信道选择
%  dec_mod--------信道译码方式
function [imageH, Pe1, Pe2] = gui_channel_decode(gray_I, p, chan_mod, encd)
    %% 设计一个GUI界面，将主要实现的功能的接口传入该位置
    [m, n] = size(gray_I);
    %% 信源编码，使用三种信源编码方式
    Cm = cell(1, 256);
    % 在 GUI 界面选择一种方式进行编码
    switch encd
        case 1
            [Cm, ~, ~] = shannon(gray_I);
        case 2
            [Cm, ~, ~] = fano(gray_I);
        case 3
            [Cm, ~, ~] = huffman(gray_I);% 霍夫曼编码，得到编码后的二进制码字
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

    %% 模拟信道
    if chan_mod == 1 % 两张图像，就应该分别通过这一个信道
        Ce{1} = bsc(Ck, p);%二元对称信道的输出
        Ce{2} = bsc(Ck, p);%二元对称信道的输出
    else
        Ce{1} = bec(Ck, p);%二元删除信道的输出
        Ce{2} = bec(Ck, p);%二元删除信道的输出
    end
    %% 信道译码，使用最大后验概率译码准则和极大似然概率译码准则
    if chan_mod == 1
        [Cx{1}, Pe1(1)] = dec_bsc(Ce{1}, 1, P_0, p);
        [Cx{2}, Pe1(2)] = dec_bsc(Ce{2}, 2, P_0, p);
    else
        [Cx{1}, Pe1(1)] = dec_bec(Ce{1}, 1, P_0, p);
        [Cx{2}, Pe1(2)] = dec_bec(Ce{2}, 2, P_0, p);
    end
    
    cnt1 = 0;
    cnt2 = 0;
    for x = 1 : m
        for y = 1 : n
            temp = str2num(Cn{x, y}(:))';
            
            for i = 1 : length(Cx{2}{x, y})
               if Cx{2}{x, y}(i) ~= temp(i)
                   cnt2 = cnt2 + 1;
               end
            end
            
            for i = 1 : length(Cx{1}{x, y})
               if Cx{1}{x, y}(i) ~= temp(i)
                   cnt1 = cnt1 + 1;
               end
            end
        end
    end
    
    Pe2(1) = cnt1 / all;
    Pe2(2) = cnt2 / all;
    %% 信源译码，使用霍夫曼编码的逆过程
    imageH{1} = image_huffman(Cx{1}, Cm);
    imageH{2} = image_huffman(Cx{2}, Cm);
end