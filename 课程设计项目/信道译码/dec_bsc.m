%% �ŵ�����
% 1.�������������׼��
% 2.������Ȼ��������׼��
%
% ��ÿһ�������е����ֵ�ÿ3λ�����ŵ����룬���ü�����Ȼ����׼��

%% ����
% ���룺
%       Ce------�ŵ������
%  dec_mod------�ŵ����뷽ʽ
%       Cn------�ŵ�����õ��ı���ͼ��
%        p------�ŵ�����ת�Ƹ���
% �����
% Cx------�ŵ���������
% Pe-------������
function [Cx, Pe] = dec_bsc(Ce, dec_mod, P_0, p)% ��û��д
    [m, n] = size(Ce);
    Cx = cell(m, n);   
    if dec_mod == 1 % ������Ȼ����׼��
        if p < 0.5
            for x = 1 : m
                for y = 1 : n
                    % ��ÿ�����ص��ŵ����ÿ��������Ϊһ�У����ɾ���
                    T = reshape(Ce{x, y}(:), 3, length(Ce{x, y}) / 3)';
                    % ���ÿһ�� 1 �ĸ������������ N ��
                    N = T * ones(1, 3)';
                    % �� N �е�С�ڵ��� 1 ����Ϊ 0
                    N(find(N(:) <= 1)) = 0;
                    % �� N �д��� 1 ����Ϊ 1
                    N(find(N(:) > 1)) = 1;
                    Cx{x, y} = N';
                end
            end

            % ƽ��������� Pe
            Pe = 3 * p * p - 2 * p * p * p;
        else 
            for x = 1 : m
                for y = 1 : n
                    T = reshape(Ce{x, y}(:), 3, length(Ce{x, y}) / 3)';
                    N = T * ones(1, 3)';
                    % �� N �е�С�ڵ��� 1 ����Ϊ 1
                    N(find(N(:) <= 1)) = 1;
                    % �� N �д��� 1 ����Ϊ 1
                    N(find(N(:) > 1)) = 0;
                    Cx{x, y} = N';
                end
            end

             % ƽ��������� Pe
             Pe = 1 - (3 * p * p - 2 * p * p * p);
        end
    else % �������������׼��
        for x = 1 : m
            for y = 1 : n
                T = reshape(Ce{x, y}(:), 3, length(Ce{x, y}) / 3)';
                N = T * ones(1, 3)';
                for i = 1 : length(N)
                   cnt = N(i);
                   p0 = p^cnt * (1 - p)^(3 - cnt) * P_0;% ���P(xy)--000
                   p1 = p^(3 - cnt) * (1 - p)^cnt * (1 - P_0);% ���P(xy)--111
                   if p0 > p1
                       N(i) = 0;
                   elseif p0 < p1
                       N(i) = 1; 
                   else % ��ȵĻ���ȡ�����
                       ran = rand(1, 1);
                       if ran > 0.5
                           N(i) = 1;
                       else
                           N(i) = 0;
                       end
                   end
                end
                Cx{x, y} = N';
            end
        end
        % ƽ��������� Pe
        Pxy1 = [(1 - p)^3, (1 - p)^2 * p, (1 - p)^2 * p, (1 - p) * p^2, (1 - p)^2 * p, (1 - p) * p^2, (1 - p) * p^2, p^3] * P_0;
        Pxy2 = [p^3, (1 - p) * p^2, (1 - p) * p^2, (1 - p)^2 * p, (1 - p) * p^2, (1 - p)^2 * p, (1 - p)^2 * p, (1 - p)^3] * (1 - P_0);
        Pe = 0;
        for i = 1 : 8
           if Pxy1(i) > Pxy2(i)
               Pe = Pe + Pxy2(i);
           else
               Pe = Pe + Pxy1(i);
           end
        end
    end
end