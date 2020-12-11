%% ��ŵ��Դ����
%  1.����Ϣ�����ʵݼ�����
%  2.����Ϣ�������ʽ��з��飬ʹ�õ�����������ĸ���֮�;������
%  3.����������ֱ���Ϊ0��1
%  3.Ȼ��ݹ������ֱ��ÿ����Ϣ����ֻ����һ����Ϣ
%  4.���յõ�����Ԫ�����������Ǳ���

%% ����
function cells = fano2(mul, cells, begin) % ���ܻ����65λ��
    [~, n] = size(mul);
    if n < 2
       return; 
    end
    % ��������
    mul = sort(mul, 'descend');
    
    % ������ʺ�
    sum_p = 0;
    for x = 1 : n 
       sum_p = sum_p + mul(x); 
    end
    % ����
    min = sum_p;
    index = 1;
    sum = 0;
    for x = 1 : n
        sum = sum + mul(x);
        if abs(sum_p - 2 * sum) < min
           min = sum_p - 2 * sum; 
           index = x;
        else
            break;
        end
    end
    l = mul(1 : index);
    r = mul(index + 1 : n);
    
    for x = begin + 1 : index + begin
       cells{x} = strcat(cells{x}, '0');  
    end
    for x = begin + index + 1 : n + begin
       cells{x} = strcat(cells{x}, '1'); 
    end
    cells = fano2(l, cells, begin);
    cells = fano2(r, cells, begin + index);
end