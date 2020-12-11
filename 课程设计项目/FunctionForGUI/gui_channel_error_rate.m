%% GUI���桪����ͬ��Դ���뷽ʽ�Ľ��
% �����
% imageH---------��ͬ�ŵ��õ������ͼ��
%     Pe---------�ŵ�������
% ���룺
%  gary_I----------�������ͼ��ĻҶ�ͼ
%      p---------һ���ŵ�����ת�Ƹ���
%    encd----------��Դ��������
% chan_mod---------�ŵ�����
%  dec_mod---------�ŵ����뷽ʽ
function [imageH, C, Pe1, Pe2] = gui_channel_error_rate(gray_I, p, encd, chan_mod, dec_mod)
    
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
    % �ŵ�
    if chan_mod == 1
        Ce{1} = bsc(Ck, p(1));%ͨ����Ԫ�Գ��ŵ������
        Ce{2} = bsc(Ck, p(2));%ͨ����Ԫ�Գ��ŵ������
        Ce{3} = bsc(Ck, p(3));%ͨ����Ԫ�Գ��ŵ������
    else
        Ce{1} = bec(Ck, p(1));%ͨ����Ԫɾ���ŵ������
        Ce{2} = bec(Ck, p(2));%ͨ����Ԫɾ���ŵ������
        Ce{3} = bec(Ck, p(3));%ͨ����Ԫɾ���ŵ������
    end
    
    % �ŵ������ļ���
    if chan_mod == 1
        C(1) = log2(2) + p(1) * log2(p(1)) + (1 - p(1)) * log2(1 - p(1));% ��Ԫ�Գ��ŵ����ŵ�����
        C(2) = log2(2) + p(2) * log2(p(2)) + (1 - p(2)) * log2(1 - p(2));% ��Ԫ�Գ��ŵ����ŵ�����
        C(3) = log2(2) + p(3) * log2(p(3)) + (1 - p(3)) * log2(1 - p(3));% ��Ԫ�Գ��ŵ����ŵ�����
    else
        C(1) = log2(2) - p(1) * log2(p(1));
        C(2) = log2(2) - p(2) * log2(p(2));
        C(3) = log2(2) - p(3) * log2(p(3));
    end
    %% �ŵ����룬ʹ���������������׼��ͼ�����Ȼ��������׼��
    if chan_mod == 1
        [Cx{1}, Pe1(1)] = dec_bsc(Ce{1}, dec_mod, P_0, p(1));
        [Cx{2}, Pe1(2)] = dec_bsc(Ce{2}, dec_mod, P_0, p(2));
        [Cx{3}, Pe1(3)] = dec_bsc(Ce{3}, dec_mod, P_0, p(3));
    else
        [Cx{1}, Pe1(1)] = dec_bec(Ce{1}, dec_mod, P_0, p(1));
        [Cx{2}, Pe1(2)] = dec_bec(Ce{2}, dec_mod, P_0, p(2));
        [Cx{3}, Pe1(3)] = dec_bec(Ce{3}, dec_mod, P_0, p(3));
    end
    
    % ����������
    cnt1 = 0;
    cnt2 = 0;
    cnt3 = 0;
    for x = 1 : m
        for y = 1 : n
            temp = str2num(Cn{x, y}(:))';
            
            for i = 1 : length(Cx{1}{x, y})
               if Cx{1}{x, y}(i) ~= temp(i)
                   cnt1 = cnt1 + 1;
               end
            end
            
            for i = 1 : length(Cx{2}{x, y})
               if Cx{2}{x, y}(i) ~= temp(i)
                   cnt2 = cnt2 + 1;
               end
            end
            
            for i = 1 : length(Cx{3}{x, y})
               if Cx{3}{x, y}(i) ~= temp(i)
                   cnt3 = cnt3 + 1;
               end
            end
        end
    end
    
    Pe2(1) = cnt1 / all;
    Pe2(2) = cnt2 / all;
    Pe2(3) = cnt3 / all;
    %% ��Դ���룬�ŵ�����������
    imageH{1} = image_huffman(Cx{1}, Cm);
    imageH{2} = image_huffman(Cx{2}, Cm);
    imageH{3} = image_huffman(Cx{3}, Cm);
end