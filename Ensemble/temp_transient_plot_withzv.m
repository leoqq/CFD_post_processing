clc;clear;close all;

%temporal evolution of temperature


temp = load('les_temp_070ms_ens.mat');
zmean = load('les_zmean_070ms_ens.mat');

%zstoic
zst = [0.045 0.045];

figure
nMdls = 2;
Axes = zeros(nMdls);
Axes(1) = axes;
hold on
[cs,hc]=contourf(Axes(1),temp.Xq,temp.Rq,temp.tempq,[550:20:2400]);
colormap('jet')
caxis([550 2400])
%txt = '30 ms';
%text(0,8,txt,'FontSize',14)
set(hc,'EdgeColor','none')
shading interp;
axis equal
axis off
set(gca, 'Position',[0 0 1 1])
Axes(2) = axes;
contour(Axes(2),zmean.Xq,zmean.Rq,zmean.zmeanq,zst,'k','linewidth',1);
linkaxes(Axes)
%%Hide the top axes
set(Axes(2), 'visible', 'off');
set(Axes(2), 'XTick', []);
set(Axes(2), 'YTick', []);
axis equal
axis([0 60 -10 10])
axis off
set(gca, 'Position',[0 0 1 1])
set(gcf, 'Units','centimeters', 'Position',[0 0 12 4]) 
print('les_temp_070ms_zt_ens.png', '-dpng', '-r600')