clc; clear; close all;

%load data
filename = 'Cai000131_+1.30016e-03.col';
data = dlmread(filename,'',2,0); 
%define arrays 
mixfrac = data(:,13); 
temp = data(:,11);  
OH = data(:,16); 
Cmean = data(:,24); 
%save some memory
clear data;

%compute conditionl average
tol=0.01; %tolerance for getting unique values increase for smoother average
[mixfrac_filtered, ~, idx3]=uniquetol(mixfrac, tol); % find unique combinations
TconZ = accumarray(idx3, temp,[],@mean); % compute conditional temperature T|Z
CconZ = accumarray(idx3, Cmean,[],@mean); % conditional Cmean C|Z.


cdivs = 20; %colormap divisions
[~, edges] = hist(OH,cdivs-1); %color by 
edges = [-Inf edges Inf]; % to include all points
[Nk, bink] = histc(OH,edges);

%Plot scatter plot with Line Plot of point size.
figure;
hold on;
xlabel('Mixture fraction [-]') 
ylabel('Temperature [K]') 
cmap = jet(cdivs);
for ii=1:cdivs
    idx = bink==ii;
    plot(mixfrac(idx),temp(idx),'.','MarkerSize',1,'Color',cmap(ii,:));
end
%plot(mixfrac_filtered, TconZ, 'k-', 'linewidth',  2);
colormap(cmap)
caxis([min(OH) max(OH)])
caxis([0 1e-3])
h = colorbar;
ylabel(h, 'OH')

figure;
hold on;
xlabel('Mixture fraction [-]') 
ylabel('Cmean [-]') 
for ii=1:cdivs
    idx = bink==ii;
    plot(mixfrac(idx),Cmean(idx),'r.','MarkerSize',1);
end
%plot(mixfrac_filtered, CconZ, 'k-', 'linewidth', 2, 'DisplayName','C|Z');
print('Cai13ms.png', '-dpng', '-r600')

