control_points =[3750,2700,1750,1250,400,300,400,550,1000,2100;200,100,150,950,600,1600,2050,2600,3500,3800];
control_points = control_points';
M = 10000;

N=length(control_points);
ta=zeros(N,N);%%对数组进行初始化

for i=1:N
    ta(i,1)=1;
    ta(i,i)=1;
end
%%从第二个数开始，也就是从第三行开始，等于前列的左边加上正上方的一个
for row=3:N
    for col=2:row-1
        ta(row,col)=ta(row-1,col-1)+ta(row-1,col);
    end
end

%0<t<1

p = zeros(M+1,2);

 for i=1:M
    t=i/M;%%确定每一个点的比例
    for k=0:N-1
        c=k;%分别确定a,b,c三个系数
        b=N-c-1;%分别确定a,b,c三个系数
        a=ta(N,k+1);%分别确定a,b,c三个系数

        p(i,1)= p(i,1)+a*(1-t)^b*t^c*control_points(k+1,1);%确定点的x坐标

        p(i,2)= p(i,2)+a*(1-t)^b*t^c*control_points(k+1,2);%确定点的y坐标
    end

end

i = 1:M;
flag = 1:10;
plot(control_points(flag,1),control_points(flag,2),'o');
hold on
plot(p(i,1),p(i,2));
hold off
