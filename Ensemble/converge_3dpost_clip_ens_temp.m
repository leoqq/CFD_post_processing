clear; clc; close all;

%load 3d column dat
A = importdata('les000071_+7.00040e-04.col' );
%setup arrays
%space
X=A.data(:,1)*1000;
Y=A.data(:,2)*1000;
Z=A.data(:,3)*1000;
%variable of interest
% temperature contour 
temp=A.data(:,13);

%OH=29, temp=12; CH2O=31; H2O2=26; rifzmean=40; scad=48 ;

phi=temp;

%create interpolant class of variable of interest
Fphi=scatteredInterpolant(X,Y,Z,phi);


%create clip plane structured grid
%Xq= axial distance
%Rq= radial distance
[Xq,Rq]=meshgrid(0:0.1:80,-15:0.1:15);
nx=size(Xq,1);
nr=size(Xq,2);

%initialise
phiq=zeros(nx,nr);

%number of clip planes
nplanes = 1;

%create plane
for i=1:nplanes
    theta=1.0*0.1*pi/nplanes*(i-1);
    Yq=Rq*sin(theta);
    Zq=Rq*cos(theta);
    phiq=phiq+Fphi(Xq,Yq,Zq);
end
phiq=phiq/nplanes;

%save
filename1=strcat('les_temp_070ms_r4.mat');

save(filename1,'Xq','Rq','phiq');




% figure(1)
% hold on
% 
% [cs,hc]=contourf(Xq*1000,Rq*1000,phiq,[600:50:2400]); %,[0:1e-4:5e-3]
% plot([-20 20],[-16.5 -16.5], 'k--','linewidth',1);
% set(hc,'EdgeColor','none')
% shading interp;
% axis equal;
% colormap jet;
% set(gca,'XTick',-20:10:20); 
% set(gca,'YTick',-100:20:0); 
% % %axis([0 50e-3 -10e-3 10e-3]);
% colorbar
% caxis([600 2400])
% set(gcf, 'Units','centimeters', 'Position',[-0.5 0 6 9])
% set(gcf, 'PaperPositionMode','auto')
% print('Cai_1D_184','-dpng','-r600')


figure
hold on
[cs,hc]=contourf(Xq,Rq,phiq,[550:20:2400]); %,[0:1e-4:5e-3]
colormap('jet')
%colorbar;
caxis([550 2400])
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
print('les_temp_070ms_r4.png', '-dpng', '-r600')



%Original code for plotting
% [cs,hc]=contourf(Xq,Rq,phiq,[800:50:2300]); %,[0:1e-4:5e-3]
% set(hc,'EdgeColor','none')
% shading interp;
% axis equal;
% colormap jet;
% % %axis([0 50e-3 -10e-3 10e-3]);
% colorbar
% caxis([800 2300])
% %print('clipOH','-dpng','-r600')
