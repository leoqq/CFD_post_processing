clear; clc; close all;

%load 3d column dat
A = importdata('les000041_+4.00130e-04.col' );
%setup arrays
%space
X1=A.data(:,1)*1000;
Y1=A.data(:,2)*1000;
Z1=A.data(:,3)*1000;
u=A.data(:,5);
v=A.data(:,6);
T1=toc;
fprintf('Time for reading file: %s sec.\n',int2str(T1));
[Xq1,Yq1]=meshgrid(0:1:80,-15:1:15);

nx1=size(Xq1,1);
nr1=size(Xq1,2);

%Process OH
tic;

Fvari1=scatteredInterpolant(X1,Y1,Z1,u);

Fvari2=scatteredInterpolant(X1,Y1,Z1,v);


T2=toc;
fprintf('Time for creating interpolant class for OH: %s sec.\n',int2str(T2));
tic;

Zq1=zeros(nx1,nr1);

variq1=Fvari1(Xq1,Yq1,Zq1);
variq2=Fvari2(Xq1,Yq1,Zq1);




for i=1:31
    for j=1:81
        if sqrt(variq1(i,j).^2+variq2(i,j).^2)>10
            variq1(i,j)=0;
            variq2(i,j)=0;
        end
    end
end 
          
     
       
  


variq1=variq1./sqrt(variq1.^2+variq2.^2);
variq2=variq2./sqrt(variq1.^2+variq2.^2);

T3=toc;
fprintf('Time for interpolating 1 planes for OH: %s sec.\n',int2str(T3));


%variable of interest
% temperature contour 

temp = load('les_temp_041ms.mat');
zmean = load('les_zmean_041ms.mat');
%OH=29, temp=12; CH2O=31; H2O2=26; rifzmean=40; scad=48 ;




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

zst = [0.045 0.045];

figure
nMdls = 2;
Axes = zeros(nMdls);
Axes(1) = axes;
hold on
[cs,hc]=contourf(Axes(1),temp.Xq,temp.Rq,temp.tempq,[550:20:2400]);
quiver(Xq1,Yq1,variq1,variq2,0,'k');
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
print('les_temp_040ms_zt_v.png', '-dpng', '-r600')

% 
% figure
% hold on
% [cs,hc]=contourf(Xq,Rq,phiq,[550:20:2400]); %,[0:1e-4:5e-3]
% colormap('jet')
% %colorbar;
% caxis([550 2400])
% %txt = '0.70 ms';
% %text(1,8,txt,'FontSize',14)
% set(hc,'EdgeColor','none')
% shading interp;
% set(gca, 'Position',[0 0 1 1])
% axis equal
% axis([0 60 -10 10])
% set(gca,'XTick',0:10:60); 
% set(gca,'YTick',-10:5:10); 
% axis off
% set(gcf, 'Units','centimeters', 'Position',[0 0 12 4]) 
% print('les_temp_070ms_r4.png', '-dpng', '-r600')



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
