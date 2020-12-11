%% 二元删除信道
% 信道转移概率矩阵：(p 为信道错误转移概率)
%     0   e  1
% 0| 1-p  p  0 |
% 1|  0  1-p 1 |
%
% 借用二元对称信道的思路
% 只要概率小于 p ，将该位置上的码元设置为 e。
%% 函数
% Ck-----信道编码的输出；p 为错误转移概率
% Ce-----信道的输出
function Ce = bec(Ck, p)
    [m, n] = size(Ck);
    Ce = cell(m, n);
    for x = 1 : m
        for y = 1 : n
            len = length(Ck{x, y});
            c = str2num(Ck{x,y}(:))';% 将每个像素中的码字，从字符串转换为数值数组
            ran = rand(1,len);
            for i = 1 : len
                if ran(i) < p
                    c(i) = -0.2;% 错误码译为 2，本来是 e，但由于不好表示
                end
            end
            Ce{x, y} = c;% 信道的输出 
        end
    end
end