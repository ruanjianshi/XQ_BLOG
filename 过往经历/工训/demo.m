function demo()

close all;
clc

WindowWidth = 1000;
WindowHeight = 600;

%% ����
Fig = figure('Position',[100,100,WindowWidth,WindowHeight],'menu','none',...
    'Color',[0.9,0.9,0.9],'NumberTitle','off','Name','Curve Editor');
Fig.ResizeFcn = @ResizeWindow;

% �ص�
set(Fig,'WindowButtonDownFcn',@ButtonDown);
set(Fig,'WindowButtonUpFcn',@ButtonUp);
set(Fig,'WindowButtonMotionFcn',@ButtonMotion);
set(Fig,'WindowScrollWheelFcn',@ScrollWheel);
set(Fig,'WindowKeyPressFcn',@KeyDown);


% ���
Pnl = uipanel(Fig,'Position',[0,0,1,1],'BackgroundColor',[0.1,0.1,0.1]);

% ��ͼ��
Axes = axes(Pnl,'Position',[0,0,1,1]);
axis([-WindowWidth,WindowWidth,-WindowHeight,WindowHeight]/2), axis off
hold on

% ������
sliderWidth = 400;
sliderHeight = 30;
Lb = uicontrol(Pnl,'style','slider','String',[],'Fontsize',12,...
    'Unit','pixels','Position',[(WindowWidth-sliderWidth)/2,0,sliderWidth,sliderHeight],...
    'Value',0.5,'Max',1,'Min',0,'SliderStep',[0.02, 0.10],'Callback',@ChangeWight);

% �ı���
str = '2 ����ģʽ';
TxT = uicontrol(Pnl,'style','text','String',str,'Fontsize',16,...
    'Units','pixels','Position',[0,0,120,sliderHeight]);


%% ��Ա
% ִ��ʲô����
state = 0;
% ��¼���λ��
p1 = [];
p2 = [];
% Բ��Ϣ
pointColor = {[0.9,0.9,0.9],[0,0,0.9],[0.9,0,0],[0.9,0.9,0]};
pointWidth = {2,1};
pointR = 8;
pointInfo = []; % �����Ϣ [x,y,]
pointList = {}; % ����
pointNum = 0; % ����
pointIdx = 0; % ��ǰ��������
basicpoint = Drawpoint(); % �����ṹ
% ��
gap = 0.01;
wight = 0.5;
mod = 2;
lineList = {}; % 1. ɢ������ 2.
lineListp = {};
CurveList = [];

%%
    function  ResizeWindow(~,~)

        WindowWidth = Fig.Position(3);
        WindowHeight = Fig.Position(4);
        axis([-WindowWidth,WindowWidth,-WindowHeight,WindowHeight]/2)
        Lb.Position(1) = (WindowWidth-sliderWidth)/2;
    end

    function Calculate(~,~)
        if pointNum>0
            % ���ԭ��
            if ~isempty(CurveList)
                delete(CurveList)
            end
            if ~isempty(lineList)
                for n = 1:length(lineList)
                    delete(lineList{n})
                end
                lineList = [];
            end
            if ~isempty(lineListp)

                for n = 1:length(lineListp)
                    delete(lineListp{n})
                end
                lineListp = [];
            end
            %  ����n�׵�
            pointCache = cell(pointNum,1);
            for n = 1:pointNum
                if n==1
                    pointCache{n} = pointInfo;
                else
                    x1 = pointCache{n-1}(1:end-1,:);
                    x2 = pointCache{n-1}(2:end,:);
                    pointCache{n} = x1+(x2-x1)*wight;
                end
            end
            % ����
            if pointNum>2
                CurveCache = cell(pointNum,1);
                CurveCache{1} = pointInfo;
                CurveLen = pointNum/gap;
                Curve = zeros(CurveLen,2);
                for i = 1:CurveLen
                    for n = 2:pointNum
                        x1 = CurveCache{n-1}(1:end-1,:);
                        x2 = CurveCache{n-1}(2:end,:);
                        CurveCache{n} = x1+(x2-x1)*i/CurveLen;
                    end

                    Curve(i,:) = CurveCache{pointNum};
                end
            end
            % ������ͼ
            switch mod
                case 1

                case 2
                    lineList{n} = plot(pointCache{1}(:,1),pointCache{1}(:,2),'-','color',pointColor{1},'LineWidth',pointWidth{2},'Parent',Axes);
                case 3
                    for n = 1:pointNum-1
                        lineList{n} = plot(pointCache{n}(:,1),pointCache{n}(:,2),'-','color',pointColor{1},'LineWidth',pointWidth{2},'Parent',Axes);
                        if n<pointNum-1
                            lineListp{n} = plot(pointCache{n+1}(:,1),pointCache{n+1}(:,2),'o','color',pointColor{2},'LineWidth',pointWidth{1},'Parent',Axes);
                        else
                            lineListp{n} = plot(pointCache{n+1}(:,1),pointCache{n+1}(:,2),'o','color',pointColor{3},'LineWidth',pointWidth{1},'Parent',Axes);
                        end
                    end
                case 4
                    for n = 1:pointNum-1
                        lineList{n} = plot(pointCache{n}(:,1),pointCache{n}(:,2),'-','color',pointColor{1},'LineWidth',pointWidth{2},'Parent',Axes);
                        if n<pointNum-1
                            lineListp{n} = plot(pointCache{n+1}(:,1),pointCache{n+1}(:,2),'o','color',pointColor{2},'LineWidth',pointWidth{1},'Parent',Axes);
                        end
                    end
                    CurveList = plot(Curve(:,1),Curve(:,2),'-','color',pointColor{4},'LineWidth',pointWidth{1},'Parent',Axes);
                    n = pointNum-1;
                    lineListp{n} = plot(pointCache{n+1}(:,1),pointCache{n+1}(:,2),'o','color',pointColor{3},'LineWidth',pointWidth{1},'Parent',Axes);

                case 5
                    CurveList = plot(Curve(:,1),Curve(:,2),'-','color',pointColor{4},'LineWidth',pointWidth{1},'Parent',Axes);
                    n = pointNum-1;
                    lineListp{n} = plot(pointCache{n+1}(:,1),pointCache{n+1}(:,2),'o','color',pointColor{3},'LineWidth',pointWidth{1},'Parent',Axes);
                case 6
                    CurveLen = pointNum/gap;
                    for i = 1:CurveLen
                        wight = i/CurveLen;
                    Calculate();
                    end
            end
        end
    end

%% �����
    function ButtonDown(src,~)

        mouseType = get(src,'SelectionType');
        cp = get(gca,'currentpoint');
        p1 = [cp(1,1),cp(1,2)];
        switch mouseType
            case 'normal'

                pointIdx = ChoosePoint(pointInfo,p1);
                if ~isempty(pointIdx)
                    state = 1;
                else
                    [cx,cy] = Updata(basicpoint,p1);
                    h = plot(cx,cy,'color',pointColor{1},'LineWidth',pointWidth{1},'Parent',Axes);
                    pointNum = pointNum+1;
                    pointIdx = pointNum;
                    pointInfo(pointNum,:) = p1;
                    pointList{pointNum} = h;
                end
                set(pointList{pointIdx},'LineStyle','-')

            case 'alt'
                disp('ɾ��')
                if pointNum>0
                    pointIdx = ChoosePoint(pointInfo,p1);
                    if ~isempty(pointIdx)
                        disp(pointIdx)
                        delete(pointList{pointIdx})
                        pointList(pointIdx) = [];
                        pointInfo(pointIdx,:) = [];
                        pointNum = pointNum-1;
                    end

                end
        end
        Calculate();
    end

    function ButtonUp(~,~)
        if state
            state = 0;
        end
    end

    function ButtonMotion(~,~)
        if state
            cp = get(gca,'currentpoint');
            p2 = [cp(1,1),cp(1,2)];
            dp = p2-p1;
            if norm(dp)>pointR
                pointInfo(pointIdx,1:2) = pointInfo(pointIdx,1:2)+dp;
                [cx,cy] = Updata(basicpoint,pointInfo(pointIdx,:));
                pointList{pointIdx}.XData = cx;
                pointList{pointIdx}.YData = cy;
                p1 = p2;
            end
            Calculate();
        end
    end

    function ScrollWheel(~,event)
        value = event.VerticalScrollCount; % �ؼ���
        wight = min(max(wight+value*0.02,0),1);
        set(Lb,'Value',wight)
        Calculate();

    end

%% ���̲���
    function KeyDown(~,~)
        pt = get(gcf,'CurrentCharacter');
        switch pt
            case '1'
                mod = 1;
                str = '1 ɢ��ģʽ';
            case '2'
                mod = 2;
                str = '2 ����ģʽ';
            case '3'
                mod = 3;
                str = '3 ��ֵģʽ';
            case '4'
                mod = 4;
                str = '4 ����ģʽ';
            case '5'
                mod = 5;
                str = '5 ����ģʽ';
            case '6'
                mod = 6;
                str = '6 ����ģʽ';
        end
        set(TxT,'String',str)
        Calculate();
    end


    function ChangeWight(~,~)
        wight = get(Lb,'value');
        Calculate();
    end

%% �Ӻ���
% �������
    function idx = ChoosePoint(pointInfo,C)
        idx = [];
        if ~isempty(pointInfo)
            dis = sum((pointInfo(:,1:2)-C).^2,2);
            [~,idx] = min(dis);
            if dis(idx)>(2*pointR)^2
                idx = [];
            end
        end
    end

% ����Բ
    function [cx,cy] = Updata(basicpoint,w)
        cx = basicpoint(:,1)+w(1);
        cy = basicpoint(:,2)+w(2);
    end

% ����Բ��
    function out = Drawpoint()
        t = 0:pi/32:2*pi;
        cx = cos(t');
        cy = sin(t');
        out = pointR*[cx,cy];
    end

end

