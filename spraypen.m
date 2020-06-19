clc; clear; close all;

%%Experimental data
%liquid penetration
lip_exp = load('sprayA_677_15ms_T900rho22_liq.dat'); 
%vapour penetration
vap_exp = load('sprayA_677_15ms_T900rho22_vap.dat'); 

%load simulation data
spray_sim = load('spray_ecn.out');



%liquid length
 figure(1)
 hold on
 ii=10; %frequency of points
 %liquid
  errorbar(lip_exp(1:ii:end,1),lip_exp(1:ii:end,2),lip_exp(1:ii:end,4) ,'k','linewidth',1.5);
  plot(spray_sim(:,1)*1e3, spray_sim(:,6)*1e3, 'r','linewidth',2); 
x = [0.7 0.7];
y = [0.35 0.25];
annotation('textarrow',x,y,'String','Liquid')
 %vapour
  errorbar(vap_exp(1:ii:end,1),vap_exp(1:ii:end,2),vap_exp(1:ii:end,4) ,'k','linewidth',1.5);
  plot(spray_sim(:,1)*1e3, spray_sim(:,8)*1e3, 'r','linewidth',2); 
x = [0.7 0.6];
y = [0.7 0.7];
annotation('textarrow',x,y,'String','Vapour')
%grid on
axis([0 1.5 0 60]);
set(gca,'XTick',0:0.25:1.5); 
set(gca,'YTick',0:5:60); 
xlabel('Time ASOI [ms]')
ylabel('Length [mm]')
legend({'Experiment','Simulation'},'location','northwest')
%# set size of figure's "drawing" area on screen
set(gcf, 'Units','centimeters', 'Position',[0 0 13 10])
set(gcf, 'PaperPositionMode','auto')
print('spraypen.png', '-dpng', '-r600')