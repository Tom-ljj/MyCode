%% ��Դ����---ʹ�õ��Ƿ�ŵ����������
% �ڱ����ʱ�򣬴洢�����еĻҶ�ֵ��Ӧ��������Ϣ
% ͨ����������ֻ�ԭ��ԭ���ĻҶȼ�

%% ����
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