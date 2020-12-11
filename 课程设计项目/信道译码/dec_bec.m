%% 信道译码
% 1.最大后验概率译码准则
% 2.极大似然概率译码准则
%
% 对每一个像素中的码字的每3位进行信道译码，采用极大似然译码准则

%% 函数
% Ce------信道的输出
% Cx------信道译码的输出
% Cn------信道编码得到的编码图像
%  p------错误转移概率
function [Cx, Pe] = dec_bec(Ce, dec_mod, P_0, p)
    [m, n] = size(Ce);
    Cx = cell(m, n);
    if dec_mod == 1 % 极大似然译码准则
        for x = 1 : m
            for y = 1 : n
                T = reshape(Ce{x, y}(:), 3, length(Ce{x, y}) / 3)';
                N = T * ones(1, 3)';
                N(find(N(:) <= 0)) = 0;
                N(find(N(:) > 0)) = 1;
                r = rand(1,1);
                if r > 0.5
                   N(find(N(:) == -0.6)) = 1;
                else
                   N(find(N(:) == -0.6)) = 0;
                end
                Cx{x, y} = N';
            end
        end
        
        % 平均错误概率: 000 译为 eee 或 111 译为 eee，概率为 p^3，其他方式均为正确译码
        % 0.5 * 2 * (p^3)
        Pe = p^3;
    else % 最大后验概率译码准则
        for x = 1 : m
            for y = 1 : n
                T = reshape(Ce{x, y}(:), 3, length(Ce{x, y}) / 3)';
                N = T * ones(1, 3)';
                
                % 反向译码（信道编码是三次重复编码）
                N(find(N(:) <= 0)) = 0;
                N(find(N(:) > 0)) = 1;
                % 根据信源概率，单独处理这种情况
                if P_0 > 0.5
                   N(find(N(:) == -0.6)) = 1;
                else
                   N(find(N(:) == -0.6)) = 0;
                end
                Cx{x, y} = N';
            end
        end
        
        % 平均错误概率
        Pe = p^3;
    end
end