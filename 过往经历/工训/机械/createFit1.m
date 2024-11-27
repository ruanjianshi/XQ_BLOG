function [fitresult, gof] = createFit1(X, Y)
%CREATEFIT1(X,Y)
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

%  由 MATLAB 于 26-Oct-2022 15:59:58 自动生成


%% Fit: 'untitled fit 1'.

[xData, yData] = prepareCurveData( X, Y );

% Set up fittype and options.
ft = 'splineinterp';

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, 'Normalize', 'on' );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'Y vs. X', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel X
ylabel Y
grid on


