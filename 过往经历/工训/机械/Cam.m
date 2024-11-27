%%
[num] = xlsread("D:\¹¤Ñµ\»úÐµ\¸ú×ÙÂ·¾¶3.xls","A1:B751");
x = num(:,1);
y = num(:,2);
hold on;
plot(-x,y,'r--')
legend('traceline');
title('car trace line');
xlabel('x:4000');
ylabel('y:4000');
hold off;
%%
t = (0:2:6)'*pi/4;
y = sin(t);
x = cos(t);
fill(x,y,'y');
axis square off;
text(0,0,'WAIT','Color','black','FontSize',80,...
    'FontWeight','bold','HorizontalAlignment','center');