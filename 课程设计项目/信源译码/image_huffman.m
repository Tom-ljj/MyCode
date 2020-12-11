%% 信源译码---使用的是霍夫曼编码的逆过程
% 在编码的时候，存储了所有的灰度值对应的码字信息
% 通过传输的码字还原成原来的灰度级

function imageH = image_huffman(Cx, Cm)
    [m, n] = size(Cx);
    imageH = zeros(m, n) + 255;
    for x = 1 : m
        for y = 1 : n
            temp = num2str(Cx{x, y}, '%d');
            for k = 1 : 256
               if strcmp(temp, Cm{k}) == 1
                  imageH(x, y) = k - 1;
                  break;
               end
            end
        end
    end
end