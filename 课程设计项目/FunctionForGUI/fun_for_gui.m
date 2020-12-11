%% һ��������ͨ��ϵͳ
% �����
% imageH---------�õ���ϵͳ�����ͼ��
%     P1---------��Ϣ������
%  avlen---------ƽ���볤
%      C---------�ŵ�����
%     Pe---------������
% ���룺
% gary_I----------�������ͼ��ĻҶ�ͼ
%      p----------����ת�Ƹ���
%   encd----------ʹ�õ���Դ���뷽ʽ
%  chan_mod-------�ŵ�ѡ��
%  dec_mod--------�ŵ����뷽ʽ
function [imageH, P1, avlen, C, Pe1, Pe2] = fun_for_gui(gray_I, p, dec_mod, chan_mod, encd)
    %% ���һ��GUI���棬����Ҫʵ�ֵĹ��ܵĽӿڴ����λ��
    [m, n] = size(gray_I);
    %% ��Դ���룬ʹ��������Դ���뷽ʽ
    Cm = cell(1, 256);
    % �� GUI ����ѡ��һ�ַ�ʽ���б���
    switch encd
        case 1
            [Cm, P1, avlen] = shannon(gray_I);
        case 2
            [Cm, P1, avlen] = fano(gray_I);
        case 3
            [Cm, P1, avlen] = huffman(gray_I);% ���������룬�õ������Ķ���������
    end
    % ��ԭͼ���е�ÿһλ�Ҷȣ�ת��Ϊ��Ӧ�����֣�������ֵ����������Cn��
    Cn = cell(m, n);
    for x = 1 : m
        for y = 1 : n
            grayVal = gray_I(x, y);
            for k = 1 : 256
                if grayVal == (k - 1)
                    Cn(x, y) = Cm(k); 
                    break;
                end
            end
        end
    end
    
    % ͳ������ͼ��� 0 ���ֵĸ���
    all = 0;
    cnt = 0;
    for x = 1 : m
        for y = 1 : n
            temp = str2num(Cn{x, y}(:))';
            all = length(temp) + all;
            cnt = cnt + sum(temp(:) == 0);
        end
    end
    P_0 = cnt / all;
    %% �ŵ����룬�����ظ�����
    Ck = rep_code(Cn);

    %% ģ���ŵ���ʹ�ö�Ԫ�Գ��ŵ�
    C = log2(2) + p * log2(p) + (1 - p) * log2(1 - p);% ��Ԫ�Գ��ŵ����ŵ�����
    
    % ����ת�Ƹ���Ϊp
    if chan_mod == 1
        Ce = bsc(Ck, p);%��Ԫ�Գ��ŵ������
    else
        Ce = bec(Ck, p);%��Ԫɾ���ŵ������
    end
    %% �ŵ����룬ʹ���������������׼��ͼ�����Ȼ��������׼��
    if chan_mod == 1
        [Cx, Pe1] = dec_bsc(Ce, dec_mod, P_0, p);
    else
        [Cx, Pe1] = dec_bec(Ce, dec_mod, P_0, p);
    end
    
    % ���������� Pe2
    cnt = 0;
    for x = 1 : m
        for y = 1 : n
            temp = str2num(Cn{x, y}(:))';
            for i = 1 : length(Cx{x, y})
               if Cx{x, y}(i) ~= temp(i)
                   cnt = cnt + 1;
               end
            end
        end
    end
    Pe2 = cnt / all;
    
    %% ��Դ���룬ʹ����Դ����������
    imageH = image_huffman(Cx, Cm);
end