%% GUI���桪����ͬ��Դ���뷽ʽ�Ľ��
% �����
% imageH---------��ͬ�ŵ��õ������ͼ��
%     P1---------��Ϣ������
%  avlen---------ƽ���볤
% ���룺
% gary_I----------�������ͼ��ĻҶ�ͼ
%      p----------����ת�Ƹ���
%  chan_mod-------�ŵ�����
%  dec_mod--------�ŵ����뷽ʽ
function [imageH, P1, avlen] = gui_source_encoding(gray_I, p, chan_mod, dec_mod)
    
    [m, n] = size(gray_I);
    %% ��Դ���룬ʹ��������Դ���뷽ʽ
    
    [Cm{1}, P1(1), avlen(1)] = shannon(gray_I);
    [Cm{2}, P1(2), avlen(2)] = fano(gray_I);
    [Cm{3}, P1(3), avlen(3)] = huffman(gray_I);% ���������룬�õ������Ķ���������
            
    % ��ԭͼ���е�ÿһλ�Ҷȣ�ת��Ϊ��Ӧ�����֣�������ֵ����������Cn��
    for x = 1 : m
        for y = 1 : n
            grayVal = gray_I(x, y);
            for k = 1 : 256
                if grayVal == (k - 1)
                    Cn{1}(x, y) = Cm{1}(k); 
                    Cn{2}(x, y) = Cm{2}(k);
                    Cn{3}(x, y) = Cm{3}(k);
                    break;
                end
            end
        end
    end
    
    % ͳ������ͼ��� 0 ���ֵĸ���
    P_0 = zeros(1, 3);
    for i = 1 : 3
        all = 0;
        cnt = 0;
        for x = 1 : m
            for y = 1 : n
                temp = str2num(Cn{i}{x, y}(:))';
                all = length(temp) + all;
                cnt = cnt + sum(temp(:) == 0);
            end
        end
        P_0(i) = cnt / all;
    end
    %% �ŵ����룬�����ظ�����
    Ck{1} = rep_code(Cn{1});
    Ck{2} = rep_code(Cn{2});
    Ck{3} = rep_code(Cn{3});

    %% ģ���ŵ���ʹ�ö�Ԫ�Գ��ŵ��Ͷ�Ԫɾ���ŵ�����
    % �ŵ�
    if chan_mod == 1
        Ce{1} = bsc(Ck{1}, p);%ͨ����Ԫ�Գ��ŵ������
        Ce{2} = bsc(Ck{2}, p);%ͨ����Ԫ�Գ��ŵ������
        Ce{3} = bsc(Ck{3}, p);%ͨ����Ԫ�Գ��ŵ������
    else
        Ce{1} = bec(Ck{1}, p);%ͨ����Ԫɾ���ŵ������
        Ce{2} = bec(Ck{2}, p);%ͨ����Ԫɾ���ŵ������
        Ce{3} = bec(Ck{3}, p);%ͨ����Ԫɾ���ŵ������
    end
    %% �ŵ����룬ʹ���������������׼��ͼ�����Ȼ��������׼��
    if chan_mod == 1
        [Cx{1}, ~] = dec_bsc(Ce{1}, dec_mod, P_0(1), p);
        [Cx{2}, ~] = dec_bsc(Ce{2}, dec_mod, P_0(2), p);
        [Cx{3}, ~] = dec_bsc(Ce{3}, dec_mod, P_0(3), p);
    else
        [Cx{1}, ~] = dec_bec(Ce{1}, dec_mod, P_0(1), p);
        [Cx{2}, ~] = dec_bec(Ce{2}, dec_mod, P_0(2), p);
        [Cx{3}, ~] = dec_bec(Ce{3}, dec_mod, P_0(3), p);
    end
    %% ��Դ���룬�ŵ�����������
    imageH{1} = image_huffman(Cx{1}, Cm{1});
    imageH{2} = image_huffman(Cx{2}, Cm{2});
    imageH{3} = image_huffman(Cx{3}, Cm{3});
end