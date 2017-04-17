% makes view and model scripts visible
addpath(genpath('view'));
addpath(genpath('model'));

% run mainView of app ( call for function defined in mainView.m, 
% which runs GUIDE generated figure ( mainView.fig ). To edit the figure
% simply PPM on it, and "OPEN IN GUIDE"
mainView();

