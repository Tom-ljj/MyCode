%% 信源译码---使用的是费诺编码的逆过程
% 在编码的时候，存储了所有的灰度值对应的码字信息
% 通过传输的码字还原成原来的灰度级

%% 函数
function imageH = image_fano(Cx, Cm)
    [m, n] = size(Cx);
    imageH = zeros(m, n) + 255;
    for x = 1 : m
        for y = 1 : n
            for k = 1 : 256
               if strcmp(Cx{x, y}, Cm{k}) == 1
                  imageH(x, y) = k - 1; 
               end
            end
        end
    end
end