%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 由圆上三点确定圆心和半径
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT
% p1   :  - 第一个点坐标, 行向量 1x3
% p2   :  - 第二个点坐标, 行向量 1x3
% p3   :  - 第三个点坐标, 行向量 1x3
% 若输入1x2的行向量, 末位自动补0, 变为1x3的行向量
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTPUT
% pc   :  - 圆心坐标, 行向量 1x3
% r    :  - 半径, 标量
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 调用示例1 - 平面上三个点
% [pc1,r1]=curvature_calculation([1,2],[-2,1],[0,-3])
% 调用示例2 - 空间中三个点
% [pc2,r2]=curvature_calculation([1,2,-1],[-2,1,2],[0,-3,-3])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [pc,r]=curvature_calculation(p1,p2,p3)

    % 输入检查
    validateattributes(p1,{'numeric'},{'row'},1);% 行向量
    validateattributes(p2,{'numeric'},{'row'},2);
    validateattributes(p3,{'numeric'},{'row'},3);
    num1=length(p1);num2=length(p2);num3=length(p3);
    if (num1 == num2) && (num2 == num3)
        if num1 == 2
            p1=[p1,0];p2=[p2,0];p3=[p3,0];
        elseif num1 ~= 3
            error('仅支持二维或三维坐标输入');
        end
    else
        error('输入坐标的维数不一致');
    end

    % 共线检查
    temp01=p1-p2;temp02=p3-p2;
    temp03=cross(temp01,temp02);
    temp=(temp03*temp03')/(temp01*temp01')/(temp02*temp02');
    if temp < 10^-10  %范围可变
        error('三点共线, 无法确定圆');
    end

    mat1=[p1,1;p2,1;p3,1];% size = 3x4

    m=+det(mat1(:,2:4));
    n=-det([mat1(:,1),mat1(:,3:4)]);
    p=+det([mat1(:,1:2),mat1(:,4)]);
    q=-det(mat1(:,1:3));

    mat2=[[p1*p1';p2*p2';p3*p3'],mat1;2*q,[-m,-n,-p,0]];% size = 4x5

    A=+det(mat2(:,2:5));
    B=-det([mat2(:,1),mat2(:,3:5)]);
    C=+det([mat2(:,1:2),mat2(:,4:5)]);
    D=-det([mat2(:,1:3),mat2(:,5)]);
    E=+det(mat2(:,1:4));

    pc=-[B,C,D]/2/A;
    r=sqrt(B^2+C^2+D^2-4*A*E)/2/abs(A);

end
