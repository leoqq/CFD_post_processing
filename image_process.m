clc;
clear all;
close all;

I=imread('test.jpg'); %read file 
Jblue=I(:,:,3); % blue based grey scale 
figure,imshow(I); %show image 
J=I(:,:,1);%red based grey scale 
figure,imshow(J);
[f1,f2]=find(Jblue'==255,1,'first'); %find the blue rectangle image boundary 
[l1,l2]=find(Jblue'==255,1,'last'); %find the blue rectangle image last side 
K=J(f1+1:l1,f2+1:l2); %redefine the image boundary in red grey scale 
figure,imshow(K);
[g1,g2]=find(K'==255,1,'first'); %find the first instance the OH mass fraction reaches the desired level 
[k1,k2]=find(K'==0,1,'last'); %find the last boundary of the cropped image 
g2/k2*108-3.22208  %calculate the lift off length  