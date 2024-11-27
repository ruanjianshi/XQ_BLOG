[num] = xlsread("D:\工训\机械\跟踪路径3.xls","A1:B751");
x = num(:,1);
y = num(:,2);
%eq = [(x1-x0)^2+(y1-y0)^2-r^2,(x2-x0)^2+(y2-y0)^2-r^2,(x3-x0)^2+(y3-y0)^2-r^2];

r = zeros(1,700);
for i = 1:700
    [pc,r(i)]=curvature_calculation([x(i),y(i)],[x(i+1),y(i+1)],[x(i+2),y(i+2)]);
 
end
  

fid=fopen(['D:\工训\机械\','trace_dot.txt'],'w');%开始将b矩阵的数据存到D盘的sw的闭合曲线实验线2.txt文件中
for num =1:700
    fprintf(fid,'%f\t%f\t%f\n',x(num),y(num),r(num));
end
fclose(fid);
