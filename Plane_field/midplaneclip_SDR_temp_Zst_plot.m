clc;close all;clear;

chi=load('cseLES_SDR_103ms.mat');
zmean = load('cseLES_zmean_103ms.mat');
temp = load('cseLES_temp_103ms.mat');

chi.sdrq(chi.sdrq<0)=0;

%zstoic
zst = [0.045 0.045];
zmr = [0.072 0.072];

% figure
% hold on
% [cs,hc]=contourf(data.Rq,data.Xq,data.sdrq,[0.01:0.1:10]); %,[0:0.01:1]
% set(hc,'EdgeColor','none');
% set(gca,'colorscale','log')
% shading interp;
% colormap(colorcet('ERL'));
% axis equal;
% axis([-10 10 10 40]);
% colorbar


figure
nMdls = 2;
Axes = zeros(nMdls);
Axes(1) = axes;
hold on
[cs,hc]=contourf(Axes(1),-chi.Rq,chi.Xq,chi.sdrq,[0.01:0.1:100]);
colormap(flipud(cbrewer2('spectral')))
set(gca,'colorscale','log')
set(hc,'EdgeColor','none')
shading interp;
axis equal
% axis off
set(gca, 'Position',[0 0 1 1])
Axes(2) = axes;
hold on
contour(Axes(2),-zmean.Rq,zmean.Xq,zmean.zmeanq,zst,'k','linewidth',4);
%contour(Axes(2),zmean.Rq,zmean.Xq,zmean.zmeanq,zmr,'k--','linewidth',1);
linkaxes(Axes)
%%Hide the top axes
set(Axes(2), 'visible', 'off');
set(Axes(2), 'XTick', []);
set(Axes(2), 'YTick', []);
axis equal
axis([-10 10 15 35])
% axis off
set(gca, 'Position',[0 0 1 1])
% set(gcf, 'Units','centimeters', 'Position',[0 0 4 4]) 
% print('les_scad_102ms.png', '-dpng', '-r600')

figure
nMdls = 2;
Axes = zeros(nMdls);
Axes(1) = axes;
hold on
[cs,hc]=contourf(Axes(1),-temp.Rq,temp.Xq,temp.tempq,[550:20:2200]);
colormap(flipud(cbrewer2('spectral')))
set(hc,'EdgeColor','none')
shading interp;
axis equal
% axis off
set(gca, 'Position',[0 0 1 1])
Axes(2) = axes;
hold on
contour(Axes(2),-zmean.Rq,zmean.Xq,zmean.zmeanq,zst,'k','linewidth',4);
%contour(Axes(2),zmean.Rq,zmean.Xq,zmean.zmeanq,zmr,'k--','linewidth',1);
linkaxes(Axes)
%%Hide the top axes
set(Axes(2), 'visible', 'off');
set(Axes(2), 'XTick', []);
set(Axes(2), 'YTick', []);
axis equal
axis([-10 10 15 35])
% axis off
set(gca, 'Position',[0 0 1 1])
% set(gcf, 'Units','centimeters', 'Position',[0 0 4 4]) 
% print('les_temp_102ms.png', '-dpng', '-r600')


% figure
% hold on
% jj=1;
% plot(-temp.Rq(1:jj:end,1),temp.tempq(1:jj:end,238),'r.-')
% yyaxis right
% plot(-chi.Rq(1:jj:end,1),chi.sdrq(1:jj:end,238),'k.-')
% %plot(-zmean.Rq(1:jj:end,1),zmean.zmeanq(1:jj:end,252),'k.-')
% data = [-temp.Rq(1:jj:end,1) temp.tempq(1:jj:end,238)];
% data2 = [-chi.Rq(1:jj:end,1) chi.sdrq(1:jj:end,238)];