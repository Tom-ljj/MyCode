%% �ŵ�����
% ʹ�õ����ظ����룬�ظ�����

%% ����
% Cn---��Դ����õ�������
function Ck = rep_code(Cn)
    [m, n] = size(Cn);
    Ck = cell(m, n);
    for x = 1 : m
        for y = 1 : n
            % �õ�ÿһ�����֣��������ֵ�ÿһλ�ظ�3��
            s = Cn{x, y};
            T = [s; s; s];
            Ck{x, y} = reshape(T, 1, 3 * length(s));
        end
    end
end

