clear; clc; close all;

%load 3d column data
A = load('Testing2.col');

%setup arrays
%space
Z=A(:,1);
X=A(:,2);
Y=A(:,3);
%variable of interest
yOH=A(:,6);

%create interpolant class of variable of interest
FyOH=scatteredInterpolant(X,Y,Z,yOH);


%create clip plane structured grid
%Xq= axial distance
%Rq= radial distance
[Xq,Rq]=meshgrid(-20e-3:0.25e-3:20e-3, -108e-3:0.25e-3:-0);
nx=size(Xq,1);
nr=size(Xq,2);

%initialise
yOHq=zeros(nx,nr);

%number of clip planes
nplanes = 1;

%create plane
for i=1:nplanes
    theta=1.0*pi/nplanes*(i-1);
    Yq=Rq*cos(theta);
    Zq=Rq*sin(theta);
    yOHq=yOHq+FyOH(Xq,Yq,Zq);
end
yOHq=yOHq/nplanes;
figure;
imagesc(yOHq);
set(gca, 'YDir', 'normal');
% set(gcf, 'Color', 'k');
axis equal;
axis off;
caxis([0 1e-3]);
colormap(jet(256));
saveas(gcf,'lift_off', 'png');

K=imread('lift_off.png'); %read file 
% figure,imshow(K); %show image 
Jred=K(:,:,1);%red based grey scale 
% figure,imshow(Jred);
[f1,f2]=find(Jred'==0,1,'first'); %find the blue rectangle image boundary 
[l1,l2]=find(Jred'==0,1,'last'); %find the blue rectangle image last side 
C=Jred(f2:l2,f1:l1); %redefine the image boundary in red grey scale 
figure,imshow(C);
[g1,g2]=find(C'==255,1,'first'); %find the first instance the OH mass fraction reaches the desired level 
[k1,k2]=find(C'==0,1,'last'); %find the last boundary of the cropped image 
g2/k2*108-3.22208  %calculate the lift off length  

