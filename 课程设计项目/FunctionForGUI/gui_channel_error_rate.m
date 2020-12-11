%% GUI界面——不同信源编码方式的结果
% 输出：
% imageH---------不同信道得到的输出图像
%     Pe---------信道误码率
% 输入：
%  gary_I----------待传输的图像的灰度图
%      p---------一组信道错误转移概率
%    encd----------信源编码类型
% chan_mod---------信道类型
%  dec_mod---------信道译码方式
function [imageH, C, Pe1, Pe2] = gui_channel_error_rate(gray_I, p, encd, chan_mod, dec_mod)
    
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

    %% 模拟信道，使用二元对称信道和二元删除信道测试
    % 信道
    if chan_mod == 1
        Ce{1} = bsc(Ck, p(1));%通过二元对称信道的输出
        Ce{2} = bsc(Ck, p(2));%通过二元对称信道的输出
        Ce{3} = bsc(Ck, p(3));%通过二元对称信道的输出
    else
        Ce{1} = bec(Ck, p(1));%通过二元删除信道的输出
        Ce{2} = bec(Ck, p(2));%通过二元删除信道的输出
        Ce{3} = bec(Ck, p(3));%通过二元删除信道的输出
    end
    
    % 信道容量的计算
    if chan_mod == 1
        C(1) = log2(2) + p(1) * log2(p(1)) + (1 - p(1)) * log2(1 - p(1));% 二元对称信道的信道容量
        C(2) = log2(2) + p(2) * log2(p(2)) + (1 - p(2)) * log2(1 - p(2));% 二元对称信道的信道容量
        C(3) = log2(2) + p(3) * log2(p(3)) + (1 - p(3)) * log2(1 - p(3));% 二元对称信道的信道容量
    else
        C(1) = log2(2) - p(1) * log2(p(1));
        C(2) = log2(2) - p(2) * log2(p(2));
        C(3) = log2(2) - p(3) * log2(p(3));
    end
    %% 信道译码，使用最大后验概率译码准则和极大似然概率译码准则
    if chan_mod == 1
        [Cx{1}, Pe1(1)] = dec_bsc(Ce{1}, dec_mod, P_0, p(1));
        [Cx{2}, Pe1(2)] = dec_bsc(Ce{2}, dec_mod, P_0, p(2));
        [Cx{3}, Pe1(3)] = dec_bsc(Ce{3}, dec_mod, P_0, p(3));
    else
        [Cx{1}, Pe1(1)] = dec_bec(Ce{1}, dec_mod, P_0, p(1));
        [Cx{2}, Pe1(2)] = dec_bec(Ce{2}, dec_mod, P_0, p(2));
        [Cx{3}, Pe1(3)] = dec_bec(Ce{3}, dec_mod, P_0, p(3));
    end
    
    % 计算误码率
    cnt1 = 0;
    cnt2 = 0;
    cnt3 = 0;
    for x = 1 : m
        for y = 1 : n
            temp = str2num(Cn{x, y}(:))';
            
            for i = 1 : length(Cx{1}{x, y})
               if Cx{1}{x, y}(i) ~= temp(i)
                   cnt1 = cnt1 + 1;
               end
            end
            
            for i = 1 : length(Cx{2}{x, y})
               if Cx{2}{x, y}(i) ~= temp(i)
                   cnt2 = cnt2 + 1;
               end
            end
            
            for i = 1 : length(Cx{3}{x, y})
               if Cx{3}{x, y}(i) ~= temp(i)
                   cnt3 = cnt3 + 1;
               end
            end
        end
    end
    
    Pe2(1) = cnt1 / all;
    Pe2(2) = cnt2 / all;
    Pe2(3) = cnt3 / all;
    %% 信源译码，信道编码的逆过程
    imageH{1} = image_huffman(Cx{1}, Cm);
    imageH{2} = image_huffman(Cx{2}, Cm);
    imageH{3} = image_huffman(Cx{3}, Cm);
end