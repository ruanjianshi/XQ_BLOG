% ��matlab�������ɵ����ߵ���solidworks�в�����ʵ�壬��Ҫ�����¼������裺
% 1��ͨ�������������ߣ������ߵ�����д�뵽txt�ļ��У�
% 2����solidworks��ʹ�����߹��ܵ���txt���꣬����ʵ�����ߣ�
% 3�������ɵ�����ת��ʵ�����á�
% ���岽�裺
% 1����matlab�������߲�������д��txt�ļ��У�
%����Ĵ������ɵ�ͼ����һ��ֱ��������
clear;
clc;
x1=0:1:100;%����ֱ��1��x��Χ
y1=zeros(1,101);%����ֱ��1��y��Χ
Z=zeros(1,101);%����z������ȫ��Ϊ0
a=[x1;y1;Z]';%��x��y��zд��һ�������У�������ת��
fid1=fopen(['d:\','sw�ıպ�����ʵ����1.txt'],'w');%��ʼ��a��������ݴ浽D�̵�sw�ıպ�����ʵ����1.txt�ļ���
[l,m,n]=size(a);
for i=1:l
    for j=1:m
        for k=1:n
        fprintf(fid1,'%f\t',a(i,j,k));
        end
    end
    fprintf(fid1,'\r\n');
end
fclose(fid1);%����
x2=100;
x21=repmat(x2,1,101);
y2=0:1:100;
b=[x21;y2;Z]';
fid2=fopen(['d:\','sw�ıպ�����ʵ����2.txt'],'w');%��ʼ��b��������ݴ浽D�̵�sw�ıպ�����ʵ����2.txt�ļ���
[l,m,n]=size(b);
for i=1:l
    for j=1:m
        for k=1:n
        fprintf(fid1,'%f\t',b(i,j,k));
        end
    end
    fprintf(fid2,'\r\n');
end
fclose(fid2);%����
x3=0:1:100;
y3=x3;
c=[x3;y3;Z]';
fid3=fopen(['d:\','sw�ıպ�����ʵ����3.txt'],'w');%��ʼ��c��������ݴ浽D�̵�sw�ıպ�����ʵ����3.txt�ļ���
[l,m,n]=size(c);
for i=1:l
    for j=1:m
        for k=1:n
        fprintf(fid3,'%f\t',c(i,j,k));
        end
    end
    fprintf(fid3,'\r\n');
end
fclose(fid3);%����
%%
for i = 1:10000
    x(i) = rou(i)*cos(ct(i));
    y(i) = rou(i)*sin(ct(i));
    z(i) = 0;
end
cam1 = [x;y;z];
writematrix(cam1,'draw_cam1.txt');

