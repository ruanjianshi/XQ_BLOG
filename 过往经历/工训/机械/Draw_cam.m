clear;
clc;
%С������
M = 80;
m = 10;
E = 20;
L = 120;
e = 50;
evluation_value = 100; %ȡֵ����

%��������
subplot(2,2,1);
XYR = textread('trace_dot.txt');
X = XYR(:,1);
Y = XYR(:,2);
R = XYR(:,3);
plot(X,Y,'b-');
hold on;
axis equal;


%����������·��
s(1) = 0;
for i = 2:evluation_value
    s(i) = s(i-1) +sqrt((X(i)-X(i-1))^2+(Y(i)-Y(i-1))^2)*(R(i)-M/2)/R(i);
end

%����͹�ֵ�ct
ct = s./s(evluation_value)*2*pi;

subplot(2,2,2);
%����͹�ֵ�rou
rou = e+E*sin(atan(L./(R+m)));
%����͹��
polar(ct,rou');

%����͹��
x = zeros(1,evluation_value);
y = zeros(1,evluation_value);
z = zeros(1,evluation_value);
for i = 1:evluation_value
    x(i) = rou(i)*cos(ct(i));
    y(i) = rou(i)*sin(ct(i));
    z(i) = 0;
end
cam1 = [x;y;z];
fid=fopen('trace_output.txt','wt'); %д�ķ�ʽ���ļ����������ڣ������ļ�����
for i = 1:evluation_value
    fprintf(fid,'%f\t%f\t%f\n ',x(i),y(i),z(i));  
end
fclose(fid);  %�ر��ļ���

