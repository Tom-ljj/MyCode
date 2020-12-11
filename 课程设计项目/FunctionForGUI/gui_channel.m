%% GUI���桪����ͬ�ŵ��Ľ��
% �����
% imageH---------��ͬ�ŵ��õ������ͼ��
%     P1---------��Ϣ������
%  avlen---------ƽ���볤
%      C---------�ŵ�����
%     Pe---------ƽ���������
% ���룺
% gary_I----------�������ͼ��ĻҶ�ͼ
%      p----------����ת�Ƹ���
%   encd----------ʹ�õ���Դ���뷽ʽ
%  dec_mod--------�ŵ����뷽ʽ
function [imageH, C, Pe1, Pe2] = gui_channel(gray_I, p, dec_mod, encd)
    
    [m, n] = size(gray_I);
    %% ��Դ���룬ʹ��������Դ���뷽ʽ
    Cm = cell(1, 256);
    % �� GUI ����ѡ��һ�ַ�ʽ���б���
    switch encd
        case 1
            [Cm, ~, ~] = shannon(gray_I);
        case 2
            [Cm, ~, ~] = fano(gray_I);
        case 3
            [Cm, ~, ~] = huffman(gray_I);% ���������룬�õ������Ķ���������
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

    %% ģ���ŵ���ʹ�ö�Ԫ�Գ��ŵ��Ͷ�Ԫɾ���ŵ�����
    % �ŵ������ļ��㡾������Ϣ������롷�鱾��
    % 1.��Ԫ�Գ��ŵ��ŵ������ļ��㡪�����öԳ��ŵ����ŵ��������㷽����P86)
    C(1) = log2(2) + p * log2(p) + (1 - p) * log2(1 - p);% ��Ԫ�Գ��ŵ����ŵ�����
    
    % 2.��Ԫɾ���ŵ��ŵ������ļ��㡪�����á�׼�Գ��ŵ������ŵ��������㷽��(P87)
%     C(2) = log2(2) - (1 - p) * log2(1 - p) - p * log2(2 * p) + (1 - p) * log2(1 - p) + p * log2(p);
    C(2) = log2(2) - p * log2(p);
    
    Ce{1} = bsc(Ck, p);%ͨ����Ԫ�Գ��ŵ������
    Ce{2} = bec(Ck, p);%ͨ����Ԫɾ���ŵ������
    
    %% �ŵ����룬ʹ���������������׼��ͼ�����Ȼ��������׼��
    [Cx{1}, Pe1(1)] = dec_bsc(Ce{1}, dec_mod, P_0, p);
    [Cx{2}, Pe1(2)] = dec_bec(Ce{2}, dec_mod, P_0, p);
    
    % ����������
    cnt1 = 0;
    cnt2 = 0;
    for x = 1 : m
        for y = 1 : n
            temp = str2num(Cn{x, y}(:))';
            
            for i = 1 : length(Cx{2}{x, y})
               if Cx{2}{x, y}(i) ~= temp(i)
                   cnt2 = cnt2 + 1;
               end
            end
            
            for i = 1 : length(Cx{1}{x, y})
               if Cx{1}{x, y}(i) ~= temp(i)
                   cnt1 = cnt1 + 1;
               end
            end
        end
    end
    
    Pe2(1) = cnt1 / all;
    Pe2(2) = cnt2 / all;
    %% ��Դ���룬�ŵ�����������
    imageH{1} = image_huffman(Cx{1}, Cm);
    imageH{2} = image_huffman(Cx{2}, Cm);
end