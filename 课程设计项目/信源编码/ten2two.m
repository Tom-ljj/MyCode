%% ��ʮ������ת��Ϊ��������������С����
%  ȡ��С�����ֲ��Զ����Ƶ���ʽ���淵�أ��˻�ȡ����

%% ����
% num ��һ����������NΪ��ȡС�����ֵ�λ��
function y = ten2two(num, N)
    dec = num - floor(num);%�������ȥ���������֣�������С������
    
    i = 1;
    bin = zeros(1, N);%�����洢���յĽ��
    while dec ~= 0 && i <= N
        dec = dec * 2;
        bin(i) = floor(dec);
        dec = dec - floor(dec);% numȡ��С������
        i = i + 1;
    end
    
    y = cellstr(num2str(bin,'%d'));
%     disp(y);
end