%% 信道译码
% 1.最大后验概率译码准则
% 2.极大似然概率译码准则
%
% 对每一个像素中的码字的每3位进行信道译码，采用极大似然译码准则

%% 函数
% 输入：
%       Ce------信道的输出
%  dec_mod------信道译码方式
%       Cn------信道编码得到的编码图像
%        p------信道错误转移概率
% 输出：
% Cx------信道译码的输出
% Pe-------误码率
function [Cx, Pe] = dec_bsc(Ce, dec_mod, P_0, p)% 还没有写
    [m, n] = size(Ce);
    Cx = cell(m, n);   
    if dec_mod == 1 % 极大似然译码准则
        if p < 0.5
            for x = 1 : m
                for y = 1 : n
                    % 将每个像素的信道输出每三个划分为一行，构成矩阵
                    T = reshape(Ce{x, y}(:), 3, length(Ce{x, y}) / 3)';
                    % 求出每一行 1 的个数，结果存在 N 中
                    N = T * ones(1, 3)';
                    % 将 N 中的小于等于 1 的置为 0
                    N(find(N(:) <= 1)) = 0;
                    % 将 N 中大于 1 的置为 1
                    N(find(N(:) > 1)) = 1;
                    Cx{x, y} = N';
                end
            end

            % 平均错误概率 Pe
            Pe = 3 * p * p - 2 * p * p * p;
        else 
            for x = 1 : m
                for y = 1 : n
                    T = reshape(Ce{x, y}(:), 3, length(Ce{x, y}) / 3)';
                    N = T * ones(1, 3)';
                    % 将 N 中的小于等于 1 的置为 1
                    N(find(N(:) <= 1)) = 1;
                    % 将 N 中大于 1 的置为 1
                    N(find(N(:) > 1)) = 0;
                    Cx{x, y} = N';
                end
            end

             % 平均错误概率 Pe
             Pe = 1 - (3 * p * p - 2 * p * p * p);
        end
    else % 最大后验概率译码准则
        for x = 1 : m
            for y = 1 : n
                T = reshape(Ce{x, y}(:), 3, length(Ce{x, y}) / 3)';
                N = T * ones(1, 3)';
                for i = 1 : length(N)
                   cnt = N(i);
                   p0 = p^cnt * (1 - p)^(3 - cnt) * P_0;% 求出P(xy)--000
                   p1 = p^(3 - cnt) * (1 - p)^cnt * (1 - P_0);% 求出P(xy)--111
                   if p0 > p1
                       N(i) = 0;
                   elseif p0 < p1
                       N(i) = 1; 
                   else % 相等的话就取随机数
                       ran = rand(1, 1);
                       if ran > 0.5
                           N(i) = 1;
                       else
                           N(i) = 0;
                       end
                   end
                end
                Cx{x, y} = N';
            end
        end
        % 平均错误概率 Pe
        Pxy1 = [(1 - p)^3, (1 - p)^2 * p, (1 - p)^2 * p, (1 - p) * p^2, (1 - p)^2 * p, (1 - p) * p^2, (1 - p) * p^2, p^3] * P_0;
        Pxy2 = [p^3, (1 - p) * p^2, (1 - p) * p^2, (1 - p)^2 * p, (1 - p) * p^2, (1 - p)^2 * p, (1 - p)^2 * p, (1 - p)^3] * (1 - P_0);
        Pe = 0;
        for i = 1 : 8
           if Pxy1(i) > Pxy2(i)
               Pe = Pe + Pxy2(i);
           else
               Pe = Pe + Pxy1(i);
           end
        end
    end
end