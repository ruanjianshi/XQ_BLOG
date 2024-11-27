function AI_train()
pole_dot = [3750,2700,1750,1250,400,300,400,550,1000,2100;200,100,150,950,600,1600,2050,2600,3500,3800];
pole_dot = pole_dot';
fixed_point = [3750,2700,1750,1250,400,300,400,550,1000,2100;200,100,150,950,600,1600,2050,2600,3500,3800];
fixed_point = fixed_point';
Ai_Train_times = 100;
Reasonable_Judgment_value = 50;
offset_speed = 1; %偏移的速度
get_value_width = 100; %取值宽度
flag_sum = 0;%总标志位判断
%mask_state = 100;
% couse_flag_one_x = 1;
% couse_flag_one_y = 1;
% couse_flag_two_x = 1;
% couse_flag_two_y = 1;
% couse_flag_third_x= 1;
% couse_flag_third_y = 1;
% couse_flag_fouth_x =1;
% couse_flag_fifth = 1;
% couse_flag_six = 1;
% couse_flag_seven = 1;
% couse_flag_eight = 1;
% couse_flag_nine = 1;
% couse_flag_ten = 1;

M = 10000;
N=length(pole_dot);

ta=zeros(N,N);%%对数组进行初始化
%%杨辉三角左右两边的值赋1
 
% 杨辉三角的数的规律
% 1
% 1 1
% 1 2 1
% 1 3 3 1
% 1 4 6 4 1
for i_flag=1:N
    ta(i_flag,1)=1;
    ta(i_flag,i_flag)=1;
end
%%从第二个数开始，也就是从第三行开始，等于前列的左边加上正上方的一个
for row=3:N
    for col=2:row-1
        ta(row,col)=ta(row-1,col-1)+ta(row-1,col);
    end
end

%0<t<1

%p = zeros(M,2);

pole_dot_change();
%The offset function
function pole_dot_change()
%flag_third = fixed_dot_judgement();
for dot_change = 2:9
    mask_state = 100;
    while mask_state
        
         p = zeros(M,2);
         hold off;
         disp(mask_state);
         mask_state = mask_state - 1;
         for i=1:M
             t=i/M;%%确定每一个点的比例
         for k=0:N-1
             c=k;%分别确定a,b,c三个系数
             b=N-c-1;%分别确定a,b,c三个系数
             a=ta(N,k+1);%分别确定a,b,c三个系数

             p(i,1)= p(i,1)+a*(1-t)^b*t^c*pole_dot(k+1,1);%确定点的x坐标

             p(i,2)= p(i,2)+a*(1-t)^b*t^c*pole_dot(k+1,2);%确定点的y坐标
         end

         end
        %flag_third = fixed_dot_judgement();
        pole_dot(dot_change,1) = pole_dot(dot_change,1) - offset_speed;
        pole_dot(dot_change,2) = pole_dot(dot_change,2) - offset_speed;
        
        flag_one = 1:10;
        plot(fixed_point(flag_one,1),fixed_point(flag_one,2),'o');
        hold on;
        plot(pole_dot(flag_one,1),pole_dot(flag_one,2),'g-');
        flag_two = 1:M;

        plot(p(flag_two,1),p(flag_two,2));

        pause(0.01);
        
    end
end
disp('finished');
end
%judge the point whether curve the bezier
function flag_third = fixed_dot_judgement()

for num_on = 1:N
    if find(p == fixed_point(num_one))
        flag_sum = flag_sum + 1;
    if flag_sum == length(N)
        disp("All points are bezier curve ");
        flag_third = True;
    else
        flag_sum = False;
    end
    end
end     
end

%Offset direction judgment  -1 left or 1 right
%     function offset_flag = offset_direction_judgment()
%        for flag_fouth = 1:N
%             for flag_fifth = 1:M
%                 switch flag_fouth
%                     case 1  
%                         if fixed_point(flag_fouth,1)-get_value_width < p(flag_fifth,1)<fixed_point(flag_fouth,1)+100
%                             couse_flag_one_x = couse_flag_one_x + 1;
%                             course_one(couse_flag_one_x,1) = p(couse_flag_one_x,1);
%                         end
%                         if fixed_point(flag_fouth,2)-get_value_width < p(flag_fifth,2)<fixed_point(flag_fouth,2)+100
%                             couse_flag_one_y = couse_flag_one_y + 1;
%                             course_one(couse_flag_one_y,2) = p(couse_flag_one_y,2);
%                         end
%                     case 2
%                         if fixed_point(flag_fouth,1)-get_value_width < p(flag_fifth,1)<fixed_point(flag_fouth,1)+100
%                            
%                             course_two(flag_fifth,1) = p(flag_fifith,1);
%                         end
%                         if fixed_point(flag_fouth,2)-get_value_width < p(flag_fifth,2)<fixed_point(flag_fouth,2)+100
%                             course_two(flag_fifth,2) = p(flag_fifith,2);
%                         end
%                     case 3
%                         if fixed_point(flag_fouth,1)-get_value_width < p(flag_fifth,1)<fixed_point(flag_fouth,1)+100
%                             course_third(flag_fifth,1) = p(flag_fifith,1);
%                         end
%                         if fixed_point(flag_fouth,2)-get_value_width < p(flag_fifth,2)<fixed_point(flag_fouth,2)+100
%                             course_third(flag_fifth,2) = p(flag_fifith,2);
%                         end
%                     case 4
%                         if fixed_point(flag_fouth,1)-get_value_width < p(flag_fifth,1)<fixed_point(flag_fouth,1)+100
%                             course_fouth(flag_fifth,1) = p(flag_fifith,1);
%                         end
%                         if fixed_point(flag_fouth,2)-get_value_width < p(flag_fifth,2)<fixed_point(flag_fouth,2)+100
%                             course_fouth(flag_fifth,2) = p(flag_fifith,2);
%                         end
%                     case 5
%                         if fixed_point(flag_fouth,1)-get_value_width < p(flag_fifth,1)<fixed_point(flag_fouth,1)+100
%                             course_fifth(flag_fifth,1) = p(flag_fifith,1);
%                         end
%                         if fixed_point(flag_fouth,2)-get_value_width < p(flag_fifth,2)<fixed_point(flag_fouth,2)+100
%                             course_fifth(flag_fifth,2) = p(flag_fifith,2);
%                         end
%                      case 6
%                         if fixed_point(flag_fouth,1)-get_value_width < p(flag_fifth,1)<fixed_point(flag_fouth,1)+100
%                             course_six(flag_fifth,1) = p(flag_fifith,1);
%                         end
%                         if fixed_point(flag_fouth,2)-get_value_width < p(flag_fifth,2)<fixed_point(flag_fouth,2)+100
%                             course_six(flag_fifth,2) = p(flag_fifith,2);
%                         end
%                     case 7
%                         if fixed_point(flag_fouth,1)-get_value_width < p(flag_fifth,1)<fixed_point(flag_fouth,1)+100
%                             course_seven(flag_fifth,1) = p(flag_fifith,1);
%                         end
%                         if fixed_point(flag_fouth,2)-get_value_width < p(flag_fifth,2)<fixed_point(flag_fouth,2)+100
%                             course_seven(flag_fifth,2) = p(flag_fifith,2);
%                         end
%                     case 8
%                         if fixed_point(flag_fouth,1)-get_value_width < p(flag_fifth,1)<fixed_point(flag_fouth,1)+100
%                             course_eight(flag_fifth,1) = p(flag_fifith,1);
%                         end
%                         if fixed_point(flag_fouth,2)-get_value_width < p(flag_fifth,2)<fixed_point(flag_fouth,2)+100
%                             course_eight(flag_fifth,2) = p(flag_fifith,2);
%                         end
%                     case 9
%                         if fixed_point(flag_fouth,1)-get_value_width < p(flag_fifth,1)<fixed_point(flag_fouth,1)+100
%                             course_nine(flag_fifth,1) = p(flag_fifith,1);
%                         end
%                         if fixed_point(flag_fouth,2)-get_value_width < p(flag_fifth,2)<fixed_point(flag_fouth,2)+100
%                             course_nine(flag_fifth,2) = p(flag_fifith,2);
%                         end
%                     case 10
%                         if fixed_point(flag_fouth,1)-get_value_width < p(flag_fifth,1)<fixed_point(flag_fouth,1)+100
%                             course_ten(flag_fifth,1) = p(flag_fifith,1);
%                         end
%                         if fixed_point(flag_fouth,2)-get_value_width < p(flag_fifth,2)<fixed_point(flag_fouth,2)+100
%                             course_ten(flag_fifth,2) = p(flag_fifith,2);
%                         end
%                     otherwise
%                         disp("error");
%                 end
%             end
%        end
%         
%     end
        

end