%% ��ũ��Դ����
%  1.����Դ������M����Ϣ��������ʵݼ���˳���������
%  2.�������Ϣ����Ϣ��
%  3.������Ϣ���õ�ÿ����Ϣ���볤n����������
%  4.�����m���źŵ��ۼӸ���Pm����Pmת��Ϊ�����ƣ�ȡС��������nλ����Ϊ����

%% ����
function [Cz, P1, avlen] = shannon(image)
    %��ͼ���е�ÿһ���ҶȽ���ͳ��
    [m, n] = size(image);%�õ�ͼ��Ĵ�С������������
    nums = imhist(image)';
    %�õ�ÿһ���Ҷȵĳ��ָ��ʣ���������
    [P, K] = sort(nums / (m * n), 'descend');
    % ��������Ϣ��
    I = -log2(P);
    [~, q] = size(I);
    % �õ��볤
    Nm = zeros(1, q);
    for n = 1 : q
       if(I(n) ~= Inf)% ���ָ���Ϊ0�ĻҶȣ����볤����Ϊ0
           Nm(n) = ceil(I(n));%����ȡ��
       end
    end
    
    % �����ۼӸ���
    Pm = zeros(1, q);
    for x = 2 : q 
       Pm(x) = Pm(x - 1) + P(x - 1); 
    end
    % ���б��룬�����ظñ�����
    Cm = cell(1, q);
    for i = 1 : q
       Cm(i) = ten2two(Pm(i), Nm(i));
    end
    
    % ���ñ����ؽ�����Ӧ�ĻҶ���
    Cz = cell(1, q);
    for x = 1 : 256
        Cz{K(x)} = Cm{x};
    end
    % ��ƽ���볤
    L = zeros(1, q);
    for i = 1 : q
        [~, b] = size(char(Cm(i)));%ÿλ����תΪchar�ͣ�size��ÿ��i��Ӧ��1�У��볤�еľ���
        L(i) = b;%ȡb����ȡ�볤
    end
    avlen = sum(L.*P);  %ƽ���볤���볤���Ը������
    
    %����Դ��
    H = 0;
    for x = 1 : q
        if P(x) ~= 0
            H = H + (-P(x) * log2(P(x)));%����Դ��
        end
    end
    P1 = H / avlen ; %��Ϣ������ = �� / ƽ���볤
end