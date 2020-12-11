%% ��Դ����---ʹ�õ��ǻ���������������
% �ڱ����ʱ�򣬴洢�����еĻҶ�ֵ��Ӧ��������Ϣ
% ͨ����������ֻ�ԭ��ԭ���ĻҶȼ�

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