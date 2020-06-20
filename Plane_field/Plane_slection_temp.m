clear; clc; close all;

%load 3d column dat
A = importdata('TKE05_000081_+8.00097e-04_2.col');
%setup arrays
%space
X=A(:,1)*1000;
Y=A(:,2)*1000;
Z=A(:,3)*1000;
%variable of interest
% temperature contour 
temp=A(:,13);

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

nplanes=20;
for i=1:nplanes

theta=1/nplanes*i*pi;
Yq=Rq*sin(theta);
Zq=Rq*cos(theta);
phiq=Fphi(Xq,Yq,Zq);
    

%save
filename1 = sprintf('LESYao_temp_08ms_plane%d.mat', i) ;

save(filename1,'Xq','Rq','phiq');




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
% colorbar
% caxis([600 2400])
axis equal
axis([0 60 -10 10])
set(gca,'XTick',0:10:60); 
set(gca,'YTick',-10:5:10); 
axis off
set(gcf, 'Units','centimeters', 'Position',[0 0 12 4]) 

filename2 = sprintf('LESYao_temp_08ms_plane%d', i) ;
print( filename2, '-dpng','-r600') ;

end

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
