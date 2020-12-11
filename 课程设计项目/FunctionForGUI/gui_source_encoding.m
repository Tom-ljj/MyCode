%% GUI界面——不同信源编码方式的结果
% 输出：
% imageH---------不同信道得到的输出图像
%     P1---------信息传输率
%  avlen---------平均码长
% 输入：
% gary_I----------待传输的图像的灰度图
%      p----------错误转移概率
%  chan_mod-------信道类型
%  dec_mod--------信道译码方式
function [imageH, P1, avlen] = gui_source_encoding(gray_I, p, chan_mod, dec_mod)
    
    [m, n] = size(gray_I);
    %% 信源编码，使用三种信源编码方式
    
    [Cm{1}, P1(1), avlen(1)] = shannon(gray_I);
    [Cm{2}, P1(2), avlen(2)] = fano(gray_I);
    [Cm{3}, P1(3), avlen(3)] = huffman(gray_I);% 霍夫曼编码，得到编码后的二进制码字
            
    % 将原图像中的每一位灰度，转换为对应的码字，将该数值矩阵存入变量Cn中
    for x = 1 : m
        for y = 1 : n
            grayVal = gray_I(x, y);
            for k = 1 : 256
                if grayVal == (k - 1)
                    Cn{1}(x, y) = Cm{1}(k); 
                    Cn{2}(x, y) = Cm{2}(k);
                    Cn{3}(x, y) = Cm{3}(k);
                    break;
                end
            end
        end
    end
    
    % 统计整张图像的 0 出现的概率
    P_0 = zeros(1, 3);
    for i = 1 : 3
        all = 0;
        cnt = 0;
        for x = 1 : m
            for y = 1 : n
                temp = str2num(Cn{i}{x, y}(:))';
                all = length(temp) + all;
                cnt = cnt + sum(temp(:) == 0);
            end
        end
        P_0(i) = cnt / all;
    end
    %% 信道编码，三次重复编码
    Ck{1} = rep_code(Cn{1});
    Ck{2} = rep_code(Cn{2});
    Ck{3} = rep_code(Cn{3});

    %% 模拟信道，使用二元对称信道和二元删除信道测试
    % 信道
    if chan_mod == 1
        Ce{1} = bsc(Ck{1}, p);%通过二元对称信道的输出
        Ce{2} = bsc(Ck{2}, p);%通过二元对称信道的输出
        Ce{3} = bsc(Ck{3}, p);%通过二元对称信道的输出
    else
        Ce{1} = bec(Ck{1}, p);%通过二元删除信道的输出
        Ce{2} = bec(Ck{2}, p);%通过二元删除信道的输出
        Ce{3} = bec(Ck{3}, p);%通过二元删除信道的输出
    end
    %% 信道译码，使用最大后验概率译码准则和极大似然概率译码准则
    if chan_mod == 1
        [Cx{1}, ~] = dec_bsc(Ce{1}, dec_mod, P_0(1), p);
        [Cx{2}, ~] = dec_bsc(Ce{2}, dec_mod, P_0(2), p);
        [Cx{3}, ~] = dec_bsc(Ce{3}, dec_mod, P_0(3), p);
    else
        [Cx{1}, ~] = dec_bec(Ce{1}, dec_mod, P_0(1), p);
        [Cx{2}, ~] = dec_bec(Ce{2}, dec_mod, P_0(2), p);
        [Cx{3}, ~] = dec_bec(Ce{3}, dec_mod, P_0(3), p);
    end
    %% 信源译码，信道编码的逆过程
    imageH{1} = image_huffman(Cx{1}, Cm{1});
    imageH{2} = image_huffman(Cx{2}, Cm{2});
    imageH{3} = image_huffman(Cx{3}, Cm{3});
end