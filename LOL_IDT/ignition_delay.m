clc;
clear;
close all;

%Ignition delay based on time of max temperature gradient
%See REF: Advanceement in Fuel Spray and Combustion Modeling for
%compression ignition engine applications, Som 2012 Page 14.


%Load data
datathermo = load('thermo_2.out');
%time array
time = datathermo(:,1); %sec
%max domain temperature
MaxTemperature = datathermo(:,6);%K 

%plot max temp vs time
figure(1)
plot(time, MaxTemperature);

%compute dT/dt 
dt = diff(time);
dI = diff(MaxTemperature);  
derivative = dI./dt; 

%plot dT/dt vs time
figure(2)
plot(time(1:end-1),derivative);

M=[time(1:end-1) derivative];

%Find time of max gradient
y=derivative;
xIndex = find(y == max(y), 1, 'first');
maxXValue = time(xIndex);

Ignition_delay = maxXValue