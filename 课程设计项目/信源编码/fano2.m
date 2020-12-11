%% 费诺信源编码
%  1.将消息按概率递减排序
%  2.把消息集按概率进行分组，使得到的两个分组的概率之和尽量相等
%  3.把两个分组分别标记为0和1
%  3.然后递归操作，直到每个消息集中只含有一个消息
%  4.最终得到的码元排列起来就是编码

%% 函数
function cells = fano2(mul, cells, begin) % 可能会出现65位的
    [~, n] = size(mul);
    if n < 2
       return; 
    end
    % 降序排列
    mul = sort(mul, 'descend');
    
    % 计算概率和
    sum_p = 0;
    for x = 1 : n 
       sum_p = sum_p + mul(x); 
    end
    % 分组
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