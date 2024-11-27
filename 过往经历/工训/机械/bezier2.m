control_points =[3750,2700,1750,1250,400,300,400,550,1000,2100;200,100,150,950,600,1600,2050,2600,3500,3800];
control_points = control_points';
M = 10000;

N=length(control_points);
ta=zeros(N,N);%%��������г�ʼ��

for i=1:N
    ta(i,1)=1;
    ta(i,i)=1;
end
%%�ӵڶ�������ʼ��Ҳ���Ǵӵ����п�ʼ������ǰ�е���߼������Ϸ���һ��
for row=3:N
    for col=2:row-1
        ta(row,col)=ta(row-1,col-1)+ta(row-1,col);
    end
end

%0<t<1

p = zeros(M+1,2);

 for i=1:M
    t=i/M;%%ȷ��ÿһ����ı���
    for k=0:N-1
        c=k;%�ֱ�ȷ��a,b,c����ϵ��
        b=N-c-1;%�ֱ�ȷ��a,b,c����ϵ��
        a=ta(N,k+1);%�ֱ�ȷ��a,b,c����ϵ��

        p(i,1)= p(i,1)+a*(1-t)^b*t^c*control_points(k+1,1);%ȷ�����x����

        p(i,2)= p(i,2)+a*(1-t)^b*t^c*control_points(k+1,2);%ȷ�����y����
    end

end

i = 1:M;
flag = 1:10;
plot(control_points(flag,1),control_points(flag,2),'o');
hold on
plot(p(i,1),p(i,2));
hold off
