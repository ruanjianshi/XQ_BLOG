% 将matlab程序生成的曲线导入solidworks中并生成实体，主要有以下几个步骤：
% 1、通过程序生成曲线，将曲线的坐标写入到txt文件中；
% 2、在solidworks中使用曲线功能导入txt坐标，生成实体曲线；
% 3、将生成的曲线转换实体引用。
% 具体步骤：
% 1、用matlab生成曲线并将坐标写入txt文件中：
%下面的代码生成的图形是一个直角三角形
clear;
clc;
x1=0:1:100;%定义直线1的x范围
y1=zeros(1,101);%定义直线1的y范围
Z=zeros(1,101);%生成z轴坐标全部为0
a=[x1;y1;Z]';%将x，y，z写进一个矩阵中，并进行转置
fid1=fopen(['d:\','sw的闭合曲线实验线1.txt'],'w');%开始将a矩阵的数据存到D盘的sw的闭合曲线实验线1.txt文件中
[l,m,n]=size(a);
for i=1:l
    for j=1:m
        for k=1:n
        fprintf(fid1,'%f\t',a(i,j,k));
        end
    end
    fprintf(fid1,'\r\n');
end
fclose(fid1);%结束
x2=100;
x21=repmat(x2,1,101);
y2=0:1:100;
b=[x21;y2;Z]';
fid2=fopen(['d:\','sw的闭合曲线实验线2.txt'],'w');%开始将b矩阵的数据存到D盘的sw的闭合曲线实验线2.txt文件中
[l,m,n]=size(b);
for i=1:l
    for j=1:m
        for k=1:n
        fprintf(fid1,'%f\t',b(i,j,k));
        end
    end
    fprintf(fid2,'\r\n');
end
fclose(fid2);%结束
x3=0:1:100;
y3=x3;
c=[x3;y3;Z]';
fid3=fopen(['d:\','sw的闭合曲线实验线3.txt'],'w');%开始将c矩阵的数据存到D盘的sw的闭合曲线实验线3.txt文件中
[l,m,n]=size(c);
for i=1:l
    for j=1:m
        for k=1:n
        fprintf(fid3,'%f\t',c(i,j,k));
        end
    end
    fprintf(fid3,'\r\n');
end
fclose(fid3);%结束
%%
for i = 1:10000
    x(i) = rou(i)*cos(ct(i));
    y(i) = rou(i)*sin(ct(i));
    z(i) = 0;
end
cam1 = [x;y;z];
writematrix(cam1,'draw_cam1.txt');

