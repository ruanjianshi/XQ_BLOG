clc;
clear;
x = [3750,2700,1750,1250,400,300,400,550,1000,2100];
y = [200,100,150,950,600,1600,2050,2600,3500,3800];
plot(x,y,'o');

a = [1,2,3,4,5];
b = [1,2,3,4,5,6,7,8,9];

flag = 0;
for num = 1:length(a)
    if find(b == a(num))
        flag = flag + 1;
    if flag == 5
        disp(true)
    end
    end
end