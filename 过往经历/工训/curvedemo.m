function curvedemo()

close all;
clc

WindowWidth = 1000;
WindowHeight = 600;

%% 搭框架
Fig = figure('Position',[100,100,WindowWidth,WindowHeight],'menu','none',...
    'Color',[0.9,0.9,0.9],'NumberTitle','off','Name','Curve Editor');
Fig.ResizeFcn = @ResizeWindow;

% 回调
set(Fig,'WindowButtonDownFcn',@ButtonDown);
set(Fig,'WindowButtonUpFcn',@ButtonUp);
set(Fig,'WindowButtonMotionFcn',@ButtonMotion);
set(Fig,'WindowScrollWheelFcn',@ScrollWheel);
set(Fig,'WindowKeyPressFcn',@KeyDown);


% 面板
Pnl = uipanel(Fig,'Position',[0,0,1,1],'BackgroundColor',[0.1,0.1,0.1]);

% 绘图窗
Axes = axes(Pnl,'Position',[0,0,1,1]);
axis([-WindowWidth,WindowWidth,-WindowHeight,WindowHeight]/2), axis off
hold on


%% 成员
% 执行什么任务
state = 0;
del = 0; % 增还是删
% 记录鼠标位置
p1 = [];
p2 = [];
% 圆信息
pointColor = {[0.9,0.9,0.9],[0,0,0.9],[0.9,0,0],[0.9,0.9,0]};
pointWidth = {2,1};
pointR = 8;
controlR = 50;
pointInfo = []; % 存点信息 [x,y,]
pointNum = 0; % 数量
pointIdx = 0; % 当前操作对象
CurveIdx = 0; % 当前处理曲线的中点
Curve = [];
basicpoint = Drawpoint(); % 基本结构
% 线
level = 4;
gap = 0.01;
mod = 2;
CurveList = {};

%%
    function  ResizeWindow(~,~)
        WindowWidth = Fig.Position(3);
        WindowHeight = Fig.Position(4);
        axis([-WindowWidth,WindowWidth,-WindowHeight,WindowHeight]/2)
    end

    function RemoveCurve(~,~)
        if ~isempty(CurveList)
            if pointIdx==1
                delete(CurveList{pointIdx})
                if del
                    CurveList(pointIdx) = [];
                end
            elseif pointIdx==pointNum
                delete(CurveList{pointIdx-1})
                if del
                    CurveList(pointIdx-1) = [];
                end
            else
                delete(CurveList{pointIdx})
                delete(CurveList{pointIdx-1})
                if del
                    CurveList(pointIdx) = [];
                end
            end
        end
    end

    function DrawCurve(~,~)
        if CurveIdx>1
            Curve = cat(1,[CurveList{CurveIdx-1}.XData(end),CurveList{CurveIdx-1}.YData(end)],Curve);
        end
        CurveList{CurveIdx} = plot(Curve(:,1),Curve(:,2),'-','color',pointColor{4},'LineWidth',pointWidth{1},'Parent',Axes);
    end

    function Calculate(~,~)
        if pointNum>1
            if del
                if pointIdx~=pointNum
                    Curve = CalCurve(pointInfo,pointIdx,level,gap);
                    CurveIdx = pointIdx;
                    DrawCurve()
                end
            else
                % 曲线
                if pointIdx==1
                    Curve = CalCurve(pointInfo,1,level,gap);
                    CurveIdx = 1;
                    DrawCurve()
                elseif pointIdx==pointNum
                    Curve = CalCurve(pointInfo,pointNum-1,level,gap);
                    CurveIdx = pointNum-1;
                    DrawCurve()
                else
                    Curve = CalCurve(pointInfo,pointIdx-1,level,gap);
                    CurveIdx = pointIdx-1;
                    DrawCurve()
                    Curve = CalCurve(pointInfo,pointIdx,level,gap);
                    CurveIdx = pointIdx;
                    DrawCurve()
                end
                drawnow
            end
        end
    end

    function updataP(~,~)
        [cx,cy] = Updata(basicpoint,pointInfo(pointIdx).position);
        pointInfo(pointIdx).hd.XData = cx;
        pointInfo(pointIdx).hd.YData = cy;
    end
    function updataC1(~,~)
        [cx,cy] = Updata(basicpoint,pointInfo(pointIdx).control1);
        pointInfo(pointIdx).hc1.XData = cx;
        pointInfo(pointIdx).hc1.YData = cy;
        pointInfo(pointIdx).hl1.XData = [pointInfo(pointIdx).position(1),pointInfo(pointIdx).control1(1)];
        pointInfo(pointIdx).hl1.YData = [pointInfo(pointIdx).position(2),pointInfo(pointIdx).control1(2)];
    end
    function updataC2(~,~)
        [cx,cy] = Updata(basicpoint,pointInfo(pointIdx).control2);
        pointInfo(pointIdx).hc2.XData = cx;
        pointInfo(pointIdx).hc2.YData = cy;
        pointInfo(pointIdx).hl2.XData = [pointInfo(pointIdx).position(1),pointInfo(pointIdx).control2(1)];
        pointInfo(pointIdx).hl2.YData = [pointInfo(pointIdx).position(2),pointInfo(pointIdx).control2(2)];
    end

%% 鼠标组
    function ButtonDown(src,~)
        
        mouseType = get(src,'SelectionType');
        cp = get(gca,'currentpoint');
        p1 = [cp(1,1),cp(1,2)];
        switch mouseType
            case 'normal'
                del = 0;
                [pointIdx,flag] = ChoosePoint(pointInfo,p1);
                
                if pointIdx>0
                    state = flag;
                else
                    % 创建新点
                    [cx,cy] = Updata(basicpoint,p1);
                    hd = plot(cx,cy,'color',pointColor{1},'LineWidth',pointWidth{1},'Parent',Axes);
                    pointNum = pointNum+1;
                    pointIdx = pointNum;
                    pointInfo(pointNum).position = p1;
                    vn = rand(1,2)-0.5;
                    pointInfo(pointNum).control1 = p1+vn/norm(vn)*controlR;
                    pointInfo(pointNum).control2 = p1-vn/norm(vn)*controlR;
                    [cx,cy] = Updata(basicpoint,pointInfo(pointNum).control1);
                    hc1 = plot(cx,cy,'color',pointColor{1},...
                        'LineWidth',pointWidth{2},'Parent',Axes);
                    [cx,cy] = Updata(basicpoint,pointInfo(pointNum).control2);
                    hc2 = plot(cx,cy,'color',pointColor{1},...
                        'LineWidth',pointWidth{2},'Parent',Axes);
                    hl1 = plot([p1(1),pointInfo(pointNum).control1(1)],[p1(2),pointInfo(pointNum).control1(2)], ...
                        '--','color',pointColor{1},'LineWidth',pointWidth{2},'Parent',Axes);
                    hl2 = plot([p1(1),pointInfo(pointNum).control2(1)],[p1(2),pointInfo(pointNum).control2(2)], ...
                        '--','color',pointColor{1},'LineWidth',pointWidth{2},'Parent',Axes);
                    pointInfo(pointNum).hd = hd;
                    pointInfo(pointNum).hc1 = hc1;
                    pointInfo(pointNum).hc2 = hc2;
                    pointInfo(pointNum).hl1 = hl1;
                    pointInfo(pointNum).hl2 = hl2;
                    Calculate();
                end
                
            case 'alt'
                del = 1;
                if pointNum>0
                    [pointIdx,~] = ChoosePoint(pointInfo,p1);
                    if pointIdx>0
                        disp(['删',num2str(pointIdx)])
                        delete(pointInfo(pointIdx).hd)
                        delete(pointInfo(pointIdx).hc1)
                        delete(pointInfo(pointIdx).hc2)
                        delete(pointInfo(pointIdx).hl1)
                        delete(pointInfo(pointIdx).hl2)
                        pointInfo(pointIdx) = [];
                        RemoveCurve()
                        
                        pointIdx = max([pointIdx-1,1]);
                        pointNum = max([pointNum-1,0]);
                        
                        Calculate();
                    end
                end
        end
    end

    function ButtonUp(~,~)
        if state
            state = 0;
        end
    end

    function ButtonMotion(~,~)
        if state==1
            % 点击数据点
            cp = get(gca,'currentpoint');
            p2 = [cp(1,1),cp(1,2)];
            dp = p2-p1;
            if norm(dp)>1
                pointInfo(pointIdx).position = pointInfo(pointIdx).position+dp;
                pointInfo(pointIdx).control1 = pointInfo(pointIdx).control1+dp;
                pointInfo(pointIdx).control2 = pointInfo(pointIdx).control2+dp;
                updataP()
                updataC1()
                updataC2()
                p1 = p2;
                RemoveCurve()
                Calculate();
            end
            
        elseif state==2
            % 点击控制点1
            disp('点击控制点1')
            cp = get(gca,'currentpoint');
            p2 = [cp(1,1),cp(1,2)];
            dp = p2-p1;
            if norm(dp)>1
                if mod<2
                    pointInfo(pointIdx).control2 = pointInfo(pointIdx).control2+dp;
                    updataC2()
                    pointInfo(pointIdx+1).control1 = pointInfo(pointIdx).control2;
                    pointIdx = pointIdx+1;
                    updataC1()
                else
                    pointInfo(pointIdx).control1 = pointInfo(pointIdx).control1+dp;
                    pointInfo(pointIdx).control2 = CalAnotherControl(pointInfo(pointIdx).position,pointInfo(pointIdx).control1,pointInfo(pointIdx).control2);
                    updataC1()
                    updataC2()
                end
                p1 = p2;
                RemoveCurve()
                Calculate();
            end
        elseif state==3
            % 点击控制点2
            disp('点击控制点2')
            cp = get(gca,'currentpoint');
            p2 = [cp(1,1),cp(1,2)];
            dp = p2-p1;
            if norm(dp)>1
                if mod<2
                    pointInfo(pointIdx).control1 = pointInfo(pointIdx).control1+dp;
                    updataC1()
                    pointInfo(pointIdx-1).control2 = pointInfo(pointIdx).control1;
                    pointIdx = pointIdx-1;
                    updataC2()
                else
                    pointInfo(pointIdx).control2 = pointInfo(pointIdx).control2+dp;
                    pointInfo(pointIdx).control1 = CalAnotherControl(pointInfo(pointIdx).position,pointInfo(pointIdx).control2,pointInfo(pointIdx).control1);
                    updataC2()
                    updataC1()
                end
                p1 = p2;
                RemoveCurve()
                Calculate();
            end
        end
    end


%% 子函数
% 计算距离
    function [idx,type] = ChoosePoint(pointInfo,C)
        idx = 0;
        type = 0;
        if ~isempty(pointInfo)
            arr = cell2mat({pointInfo.position}');
            dis0 = sum((arr-C).^2,2);
            [~,idx0] = min(dis0);
            arr = cell2mat({pointInfo.control1}');
            dis1 = sum((arr-C).^2,2);
            [~,idx1] = min(dis1);
            arr = cell2mat({pointInfo.control2}');
            dis2 = sum((arr-C).^2,2);
            [~,idx2] = min(dis2);
            
            if dis0(idx0)<(2*pointR)^2 && dis0(idx0)<dis2(idx2) && dis0(idx0)<dis1(idx1)
                idx = idx0;
                type = 1;
            elseif dis1(idx1)<(2*pointR)^2 && dis1(idx1)<dis2(idx2) && dis1(idx1)<dis0(idx0)
                idx = idx1;
                type = 2;
            elseif dis2(idx2)<(2*pointR)^2 && dis2(idx2)<dis1(idx1) && dis2(idx2)<dis0(idx0)
                idx = idx2;
                type = 3;
            else
                idx = 0;
                type = 0;
            end
        end
    end
% 更新圆
    function [cx,cy] = Updata(basicpoint,w)
        cx = basicpoint(:,1)+w(1);
        cy = basicpoint(:,2)+w(2);
    end

% 生成圆形
    function out = Drawpoint()
        t = 0:pi/32:2*pi;
        cx = cos(t');
        cy = sin(t');
        out = pointR*[cx,cy];
    end
% 点联动
    function p = CalAnotherControl(p0,p1,p2)
        % p被动点新坐标：p0中心点，p1移动点，p2被动点
        v1 = p1-p0;
        d2 = norm(p2-p0);
        p = p0-v1*d2/norm(v1);
    end


% 贝塞尔
    function Curve = CalCurve(pointInfo,idx,level,gap)
        
        CurveCache = cell(level,1);
        if level>3
            CurveCache{1} = [pointInfo(idx).position;
                pointInfo(idx).control2;
                pointInfo(idx+1).control1;
                pointInfo(idx+1).position];
        else
            CurveCache{1} = [pointInfo(idx).position;
                pointInfo(idx+1).control2;
                pointInfo(idx+1).position];
        end
        
        CurveLen = level/gap;
        Curve = zeros(CurveLen,2);
        for i = 1:CurveLen
            for n = 2:level
                x1 = CurveCache{n-1}(1:end-1,:);
                x2 = CurveCache{n-1}(2:end,:);
                CurveCache{n} = x1+(x2-x1)*i/CurveLen;
            end
            
            Curve(i,:) = CurveCache{level};
        end
    end
end

