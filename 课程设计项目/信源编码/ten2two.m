%% 将十进制数转换为二进制数（包括小数）
%  取出小数部分并以二进制的形式保存返回：乘基取整法

%% 函数
% num 是一个浮点数，N为所取小数部分的位数
function y = ten2two(num, N)
    dec = num - floor(num);%这个数减去其整数部分，即得其小数部分
    
    i = 1;
    bin = zeros(1, N);%用来存储最终的结果
    while dec ~= 0 && i <= N
        dec = dec * 2;
        bin(i) = floor(dec);
        dec = dec - floor(dec);% num取其小数部分
        i = i + 1;
    end
    
    y = cellstr(num2str(bin,'%d'));
%     disp(y);
end