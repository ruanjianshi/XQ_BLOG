%%judge the min distance,attain the x value and y value
M = 10;
p =[60,8,3,1,5,8,9,6,5,4;8,59,6,5,4,1,8,2,5,9];
dot_change = 2;
fixed_point = [2,4;6,8];
temple = zeros(1,M);
for  i = 1:M
    temple(1,i) = sqrt((fixed_point(dot_change,1)-p(1,i))^2+(fixed_point(dot_change,2)-p(2,i))^2);
    disp(temple(1,i));
end
temple = temple';
min_one = min(temple);
disp(min_one);
value_suo = find(temple == min_one);
disp(find(temple == min_one));
x = p(1,value_suo);
y = p(2,value_suo);
fprintf('%d\t%d',x,y);
%%
%%judging offset direction and speed,(x,y)
%having some problem need to solve;
speed = 10;
x_min = 4;
y_min = 9;
fixed_x = 6;
fixed_y = 8;
if fixed_x - x_min < 0
    offset_direction_x = -(offset_direction_x);
else
    offset_direction_x = +(offset_direction_x);
end
if fixed_y - y_min <0
    offset_direction_y = -(fixed_y - y_min)/speed;
else
    offset_direction_y = +(fixed_y - y_min)/speed;
end
%%judge the dot whether equal the fixed dot
scope_value = 10;%judge the scope
if fixed_x - scope_value<p(1,value_suo)<fixed_x + scope_value  &&  fixed_y - scope_value<p(2,value_suo)<fixed_y + scope_value
    delete the fixed_x;%Don't move the fixed_x
end
%%addition two pole to adjust the curvature



%%judge the curvature radius whether reasonable


    

