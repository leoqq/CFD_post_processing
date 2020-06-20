tic;
clear all;
% filename='les3d/les000071_+7.00110e-04.col';
% M=dlmread(filename,'',2,0); %Filenames
M = importdata('800K_000121_+1.20026e-03.col');
X=M(:,1)*1000;
Y=M(:,2)*1000;
Z=M(:,3)*1000;
vari=M(:,8); %variables of interest

%OH=29, temp=12-13; CH2O=31; H2O2=26; rifzmean=39-40; scad=46-48 ;

clear M;
T1=toc;
fprintf('Time for reading file: %s sec.\n',int2str(T1));

%[Xq,Rq]=meshgrid(0:0.15:80,-15:0.15:15);
[Xq,Rq]=meshgrid(0:0.1:80,-15:0.1:15);
nx=size(Xq,1);
nr=size(Xq,2);

%Process OH
tic;
Fvari=scatteredInterpolant(X,Y,Z,vari);
clear vari;
T2=toc;
fprintf('Time for creating interpolant class for OH: %s sec.\n',int2str(T2));
tic;
Zq=zeros(nx,nr);
variq=Fvari(Xq,Rq,Zq);
clear Fvari;
T3=toc;
fprintf('Time for interpolating 1 planes for OH: %s sec.\n',int2str(T3));

%OHq = variq;
%CH2Oq= variq;
%tempq= variq;
%H2O2q = variq;
zmeanq= variq;
%scadq = variq;

% Save Mean quantities in .mat file 
filename1='800K_zmean_120ms.mat';
save(filename1,'Xq','Rq','zmeanq');

% Plot something to check
% figure
% [cs,hc]=contourf(Xq,Rq,variq); %,[0:0.001:0.25]
% set(hc,'EdgeColor','none')
% shading interp;
% axis equal;
% %axis([0 50e-3 -10e-3 10e-3]);
% colormap(jet)
% %colorbar
% hold on



