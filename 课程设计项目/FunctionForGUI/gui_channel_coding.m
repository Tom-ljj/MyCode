%% GUI���桪���Ƿ�����ŵ����뷽���õ��Ĵ�����
% �����
% imageH---------��ͬ�ŵ��õ������ͼ��
%     Pe---------�ŵ���ƽ��������ʣ��ŵ������ʣ�
% ���룺
% gary_I----------�������ͼ��ĻҶ�ͼ
%      p----------����ת�Ƹ���
%   encd----------��Դ���뷽ʽ
%  chan_mod-------�ŵ�����
%  dec_mod--------�ŵ����뷽ʽ
function [imageH, Pe1, Pe2] = gui_channel_coding(gray_I, p, encd, chan_mod, dec_mod)
    
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
    Ck{1} = rep_code(Cn);
    Ck{2} = Cn; % �������ŵ����룬��Ӧ�ĺ���Ҳû���ŵ�����

    %% ģ���ŵ���ʹ�ö�Ԫ�Գ��ŵ��Ͷ�Ԫɾ���ŵ�����
    % �ŵ�
    if chan_mod == 1
        Ce{1} = bsc(Ck{1}, p);%ͨ����Ԫ�Գ��ŵ������
        Ce{2} = bsc(Ck{2}, p);%ͨ����Ԫ�Գ��ŵ������
    else
        Ce{1} = bec(Ck{1}, p);%ͨ����Ԫɾ���ŵ������
        Ce{2} = bec(Ck{2}, p);%ͨ����Ԫɾ���ŵ������
    end
    
    
    %% �ŵ����룬ʹ���������������׼��ͼ�����Ȼ��������׼��
    if chan_mod == 1
        [Cx, Pe1] = dec_bsc(Ce{1}, dec_mod, P_0, p);
    else
        [Cx, Pe1] = dec_bec(Ce{1}, dec_mod, P_0, p);
    end
    
    % ����������
    cnt1 = 0;
    cnt2 = 0;
    for x = 1 : m
        for y = 1 : n
            temp = str2num(Cn{x, y}(:))';
            
            for i = 1 : length(Ce{2}{x, y})
               if Ce{2}{x, y}(i) ~= temp(i)
                   cnt2 = cnt2 + 1;
               end
            end
            
            for i = 1 : length(Cx{x, y})
               if Cx{x, y}(i) ~= temp(i)
                   cnt1 = cnt1 + 1;
               end
            end
        end
    end
    
    Pe2(1) = cnt1 / all;
    Pe2(2) = cnt2 / all;
    
    %% ��Դ���룬��Դ����������
    imageH{1} = image_huffman(Cx, Cm);
    imageH{2} = image_huffman(Ce{2}, Cm);% û�о����ŵ�����
end