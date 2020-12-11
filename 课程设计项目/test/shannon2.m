%% ����
function res = shannon2(mul)
    [~, n] = size(mul);%�õ�һά����ĳ���
    P = sort(mul, 'descend');
    % ��������Ϣ��
    I = -log2(P);
    % �õ��볤
    Nm = zeros(1, n);
    for x = 1 : n
       Nm(x) = ceil(I(x));%����ȡ��
    end
    
    % �����ۼӸ���
    Pm = zeros(1, n);
    for x = 2 : n 
       Pm(x) = Pm(x - 1) + P(x - 1); 
    end
    disp("-----����------");
    disp(P);
    disp("-----����Ϣ��------");
    disp(I);
    disp("------�볤-----");
    disp(Nm);
    disp("-----�ۼӸ���------");
    disp(Pm);
    
    Cm = cell(1, n);
    for i = 1 : n
       Cm(i) = ten2two(Pm(i), Nm(i)); % �ұߵ���һ���ַ�������ߵ���һ��double���͵����飬�޷��洢�ַ���
    end
    res = Cm;
end