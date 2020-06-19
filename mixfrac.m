clc; clear; close all;

%load experimental mixture fraction profiles:
 xv = load('900K22.8kg150MPa_mean/xv.csv');
 yv = load('900K22.8kg150MPa_mean/yv.csv');
 mf_mean = load('900K22.8kg150MPa_mean/900K22.8kg150MPa_mean.csv');
 mf_meanuc = load('900K22.8kg150MPa_meanunc/900K22.8kg150MPa_meanunc.csv');
 
 
 %load simulation data
 sim25 = load('Mixture_fraction_25mm');
 sim45 = load('Mixture_fraction_45mm');
 
 
 
 %Radial plots
 figure(1)
 %Axial distance = 25mm 
 hold on
 ii=10; %frequency of points
 %Experimental Data
    errorbar(yv(1:ii:end),mf_mean(1:ii:end,102),mf_meanuc(1:ii:end,102), 'ks','linewidth',1.25,'MarkerFaceColor','k');
 %Simulation Data
    plot(sim25(:,1), sim25(:,2), 'r','linewidth',1.5);
    
%Axial distance = 45mm
%Experimental Data
    errorbar(yv(1:ii:end),mf_mean(1:ii:end,383),mf_meanuc(1:ii:end,383),'ks--','linewidth',1.25,'MarkerFaceColor','k');
%Simulation Data
    plot(sim45(:,1), sim45(:,2), 'r--','linewidth',1.5);   
x = [0.4 0.3];
y = [0.65 0.65];
annotation('textarrow',x,y,'String','25mm')

x = [0.7 0.6];
y = [0.25 0.25];
annotation('textarrow',x,y,'String','45mm')
%grid on
axis([0 10 0 0.175]);
set(gca,'XTick',0:2:10); 
set(gca,'YTick',0:0.025:0.175); 
xlabel('Radial distance [mm]')
ylabel('Mixture fraction [-]')
legend({'Experiment', 'Simulation'})
%# set size of figure's "drawing" area on screen
set(gcf, 'Units','centimeters', 'Position',[0 0 10 10])
set(gcf, 'PaperPositionMode','auto')
print('mixfrac_radial.png', '-dpng', '-r600')

% figure(2)
% hold on
% %Axial distance = 45mm
% %Experimental Data
%     errorbar(yv(1:ii:end),mf_mean(1:ii:end,383),mf_meanuc(1:ii:end,383),'k','linewidth',1.5);
% %Simulation Data
%     plot(sim45(:,1)*1e3 , sim45(:,2), 'r','linewidth',2);
% %grid on
% axis([0 10 0 0.15]);
% set(gca,'XTick',0:2:10); 
% set(gca,'YTick',0:0.025:0.15); 
% xlabel('Radial distance [mm]')
% ylabel('Mixture fraction [-]')
% legend({'Experiment', 'Simulation'})
% %# set size of figure's "drawing" area on screen
% set(gcf, 'Units','centimeters', 'Position',[0 0 12 12])
% set(gcf, 'PaperPositionMode','auto')
%print('mixfrac_45mm.png', '-dpng', '-r600')