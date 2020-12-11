%% 信道编码
% 使用的是重复编码，重复三次

%% 函数
% Cn---信源编码得到的码字
function Ck = rep_code(Cn)
    [m, n] = size(Cn);
    Ck = cell(m, n);
    for x = 1 : m
        for y = 1 : n
            % 得到每一个码字，将该码字的每一位重复3次
            s = Cn{x, y};
            T = [s; s; s];
            Ck{x, y} = reshape(T, 1, 3 * length(s));
        end
    end
end

