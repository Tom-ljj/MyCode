%A=[0.19 0.2 0.18 0.17 0.15 0.1 0.01];
A=[0.4 0.2 0.2 0.1 0.1 ];
A=sort(A,'descend'); %按降序排列
T=A;
[m,n]=size(A);
B=zeros(n,n-1); %空的编码表矩阵
B(:,1)=T;   %生成编码表的第一列
r=B(n,1)+B(n-1,1); %最后两个元素相加
T(n-1)=r;
T(n)=0;
T=sort(T,'descend');

t=n-1;
for j=2:n-1   %生成编码表的其他各列
    B(1:t,j)=T(1:t);
    K=find(T==r);   %取T矩阵中为r的索引值，及下标位置
   % B(n,j)=K(end); %从第二列开始，每列的最后一个元素记录特征元素在该列的位置,概率之和往下排
   B(n,j)=K(1);   %从第二列开始，每列的最后一个元素记录特征元素在该列的位置,概率之和往上排
    r=(B(t-1,j)+B(t,j));  %最后两个元素相加
    T(t-1)=r;
    T(t)=0;
    T=sort(T,'descend');
    t=t-1;
end

%B输出编码表
ENDc1={'1','0'};%第(n-1)级从上到下按1，0赋值编码
ENDc=ENDc1;    %存码字
t=3;%在j=n-2，即第(n-2)列时，只有三个有效概率，即有值的概率
d=1;
for j=n-2:-1:1  %从倒数第二列开始依次对各列元素编码
    for i=1:t-2 %每级从第一行开始。该循环完成继承编码工作，即图形上跨列相等概率的长直线
        if i>1&&B(i,j)==B(i-1,j)%若i>1且在第J列时，有第i行与(i-1)行值相等，则第i行时42行继承第二个相等的值，因为这两个值都是可以由后一级继承的。在第J列时，第i行在(i-1)行下面一位，在第J+1列时同样
             d=d+1;
        else
            d=1;%若i>1且在第J列时，没有相等，则42行直接继承
        end
        B(B(n,j+1),j+1)=-1;  %B(n,j+1)为最后一行的数，即前面记录的相加后数的下标
        temp=B(:,j+1);%选取后一级所有元素
        x=find(temp==B(i,j));%从矩阵最右端(n-1)开始，找前一级的前(t-2)位分别对应于后一级的第几位，每级从第一行开始。为什么选前(t-2)位呢？因为第t位为最后一位有效概率，倒数第一二位要相加求和
        ENDc(i)=ENDc1(x(d)); %继承上一级相等处的编码，即图形中表示同一概率的长横线
    end
    
%该循环完成相加求和部分的编码工作，即图形上跨列不相等概率的长直线
    y=B(n,j+1);%取出前一级的低D位加和对应于后一级的第几位的索引值，前一级相加后索引值的存放在后一级
      ENDc(t-1)=strcat(ENDc1(y),'1');%每一级的第(t-1)位，即用于相加的第一位，编码尾后加'1'，也即每一级的倒数第二位
      ENDc(t)=strcat(ENDc1(y),'0');%每一级的第t位，即用于相加的第二位，编码尾后加'0'，也即每一级的倒数第一位
    t=t+1;%当列数从j=n-2到1时，t每级加一，即每一列存在的有效概率每级加一
    ENDc1=ENDc;%第(n-1)级之前的，每级用后一级的编码迭代
end
%A 排序后的原概率序列
%ENDc 编码结果
fprintf('信源向上排：');

for i=1:n
    [a,b]=size(char(ENDc(i)));%每位数据转为char型，size后即每个i对应于1行，码长列的矩阵
    L(i)=b;%取b即取码长
end
avlen=sum(L.*A);  %平均码长
fprintf('平均码长为');disp(avlen);
selen=(L-avlen).^2 ; %方差
fprintf('方差为');disp(selen);
mselen=sum((selen).*A); %码长均方差
fprintf('码长均方差为');disp(mselen);
H=-A*(log2(A'));%熵
fprintf('熵');disp(H);
P=H/avlen ; %编码效率
fprintf('编码效率为');disp(P);

figure;
subplot(2,1,1);
h=stem(1:n,selen);
axis([0 n+1 0 max(selen)+0.1]);
set(h,'MarkerFaceColor','blue','linewidth',2)
xlabel('信源向上排');ylabel('方差值');
hold on;
plot(0:n+1,mselen*ones(1,n+2),'r','linewidth',2);
hold off
legend('每个码长与平均码长的方差','码长均方差');



%A=[0.19 0.2 0.18 0.17 0.15 0.1 0.01];
A=[0.4 0.2 0.2 0.1 0.1 ];
A=sort(A,'descend'); %按降序排列
T=A;
[m,n]=size(A);
B=zeros(n,n-1); %空的编码表矩阵
B(:,1)=T;   %生成编码表的第一列
r=B(n,1)+B(n-1,1); %最后两个元素相加
T(n-1)=r;
T(n)=0;
T=sort(T,'descend');

t=n-1;
for j=2:n-1   %生成编码表的其他各列
    B(1:t,j)=T(1:t);
    K=find(T==r);   %取T矩阵中为r的索引值，及下标位置
    B(n,j)=K(end); %从第二列开始，每列的最后一个元素记录特征元素在该列的位置,概率之和往下排
   %B(n,j)=K(1);   %从第二列开始，每列的最后一个元素记录特征元素在该列的位置,概率之和往上排
    r=(B(t-1,j)+B(t,j));  %最后两个元素相加
    T(t-1)=r;
    T(t)=0;
    T=sort(T,'descend');
    t=t-1;
end
%B输出编码表

ENDc1={'1','0'};
ENDc=ENDc1;    %存码字
t=3;
d=1;
for j=n-2:-1:1  %从倒数第二列开始依次对各列元素编码
    for i=1:t-2
        if i>1&&B(i,j)==B(i-1,j)
             d=d+1;
        else
            d=1;
        end
        B(B(n,j+1),j+1)=-1;  %B(n,j+1)为最后一行的数，即前面记录的相加后数的下标
        temp=B(:,j+1);
        x=find(temp==B(i,j));
        ENDc(i)=ENDc1(x(d)); 
    end
    y=B(n,j+1);
      ENDc(t-1)=strcat(ENDc1(y),'1');
      ENDc(t)=strcat(ENDc1(y),'0');
    t=t+1;
    ENDc1=ENDc;
end
%A 排序后的原概率序列
%ENDc 编码结果
fprintf('信源向下排：');

for i=1:n
    [a,b]=size(char(ENDc(i)));
    L(i)=b;
end
avlen=sum(L.*A);  %平均码长
fprintf('平均码长为');disp(avlen);
selen=(L-avlen).^2 ; %方差
fprintf('方差为');disp(selen);
mselen=sum((selen).*A); %码长均方差
fprintf('码长均方差为');disp(mselen);
H=-A*(log2(A'));%熵
fprintf('熵');disp(H);
P=H/avlen ; %编码效率
fprintf('编码效率为');disp(P);

subplot(2,1,2);
h=stem(1:n,selen);
axis([0 n+1 0 max(selen)+0.1]);
set(h,'MarkerFaceColor','blue','linewidth',2)
xlabel('信源向下排');ylabel('方差值');
hold on;
plot(0:n+1,mselen*ones(1,n+2),'r','linewidth',2);
hold off
legend('每个码长与平均码长的方差','码长均方差');