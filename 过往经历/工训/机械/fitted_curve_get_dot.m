fid=fopen(['D:\��ѵ\��е\','trace_dot.txt'],'w');%��ʼ��b��������ݴ浽D�̵�sw�ıպ�����ʵ����2.txt�ļ���
for num =1:M
    fprintf(fid,'%f\t%f\t%f\n',p(num,1),p(num,2),r(num));
end
fclose(fid);