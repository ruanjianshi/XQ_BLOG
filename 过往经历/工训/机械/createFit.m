function [fitresult, gof] = createFit(X, Y)
%CREATEFIT(X,Y)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : X
%      Y Output: Y
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 25-Oct-2022 23:07:59 自动生成

X= [3750,2700,1750,1250,400,300,400,550,1000,2100];
Y = [200,100,150,950,600,1600,2050,2600,3500,3800];
%Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( X, Y );

% Set up fittype and options.
ft = 'splineinterp';

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, 'Normalize', 'on' );

% Plot fit with data.
figure( 'Name', 'createFit fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'Y vs. X', 'createFit fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel X
ylabel Y
grid on


