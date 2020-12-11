%% 模拟信道特性
% 采用二元对称信道
% |1-p   p |
% | p  1-p |
%
% 现通过MATLAB编程实现该信道，由于该信道的转移特性与输入输出特性可知，
% 该信道可通过一个二元信源与一个同维的
% 仅含0或1的矩阵通过以概率p进行异或操作实现0。此函数可以采用两种方法编写，
% 一种方法是将图片转换为列向量或者行向量与同维的矩阵异或；
% 另外一种方法为与同维矩阵直接异或，无需转换。

%% 函数
% Ck-----信道编码的输出；p 为错误转移概率
% Ce-----信道的输出
function Ce = bsc(Ck, p)
    [m, n] = size(Ck);
    Ce = cell(m, n);
    for x = 1 : m
        for y = 1 : n
            len = length(Ck{x, y});
            c = str2num(Ck{x,y}(:))';
            ran = rand(1,len);
            for i = 1 : len
                if ran(i) < p
                    ran(i) = 1;
                else
                    ran(i) = 0;
                end
            end
            Ce{x, y} = xor(c, ran);
        end
    end
end