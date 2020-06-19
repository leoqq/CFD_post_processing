clc;clear;close all;

%temporal evolution of temperature


zmean = load('TKE_055_zmean_095ms.mat');
figure
hold on
[cs,hc]=contourf(zmean.Xq,zmean.Rq,zmean.zmeanq,[0:0.05:0.5]);
colormap('jet')
%colorbar;
caxis([0 0.5])
%txt = '0.70 ms';
%text(1,8,txt,'FontSize',14)
set(hc,'EdgeColor','none')
shading interp;
set(gca, 'Position',[0 0 1 1])
axis equal
axis([0 60 -10 10])
set(gca,'XTick',0:10:60); 
set(gca,'YTick',-10:5:10); 
axis off
set(gcf, 'Units','centimeters', 'Position',[0 0 12 4]) 
% print('TKE_055_mixture_095ms.png', '-dpng', '-r600')