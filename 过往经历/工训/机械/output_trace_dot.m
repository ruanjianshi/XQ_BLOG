[num] = xlsread("D:\��ѵ\��е\����·��3.xls","A1:B751");
x = num(:,1);
y = num(:,2);
%eq = [(x1-x0)^2+(y1-y0)^2-r^2,(x2-x0)^2+(y2-y0)^2-r^2,(x3-x0)^2+(y3-y0)^2-r^2];

r = zeros(1,700);
for i = 1:700
    [pc,r(i)]=curvature_calculation([x(i),y(i)],[x(i+1),y(i+1)],[x(i+2),y(i+2)]);
 
end
  

fid=fopen(['D:\��ѵ\��е\','trace_dot.txt'],'w');%��ʼ��b��������ݴ浽D�̵�sw�ıպ�����ʵ����2.txt�ļ���
for num =1:700
    fprintf(fid,'%f\t%f\t%f\n',x(num),y(num),r(num));
end
fclose(fid);
