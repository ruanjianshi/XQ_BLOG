[num] = xlsread("D:\工训\机械\跟踪路径3.xls","A1:B751");
x = num(:,1);
y = num(:,2);
dotx = [3750,2700,1750,1250,400,300,400,550,1000,2100];
doty = [200,100,150,950,600,1600,2050,2600,3500,3800];
hold on;
%plot(dotx,doty,'ob');
h =plot(-x,y,'r--');
%set(gca,'XLim',[0,4000]);
%set(gca,'YLim',[0,4000]);
legend('traceline');
title('car trace line');
xlabel('x:4000');
ylabel('y:4000');
grid on
box on
hold off;
saveas(gcf,'track_line','png');
get(h,'YLabel')
%%
subplot(2,2,[1,2]);
pic=imread(['.\','凸轮设计原理','.png']);
image(pic)
axis off

subplot(2,2,3);
plot(1:5);