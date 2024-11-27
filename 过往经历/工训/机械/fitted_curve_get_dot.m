fid=fopen(['D:\工训\机械\','trace_dot.txt'],'w');%开始将b矩阵的数据存到D盘的sw的闭合曲线实验线2.txt文件中
for num =1:M
    fprintf(fid,'%f\t%f\t%f\n',p(num,1),p(num,2),r(num));
end
fclose(fid);