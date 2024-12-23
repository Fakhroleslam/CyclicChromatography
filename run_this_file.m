%==========================================================================
%   Copyright (c) 2023, PSE TMU
%   Process System Engineering (PSE) research group at Tarbiat Modares University (TMU)
%   All rights reserved.
%
%   This code is provided "as is" without any warranties, express or implied,
%   including but not limited to the warranties of merchantability and fitness
%   for a particular purpose.
%
%   Author: Saeid Asadi
%   Contact:
%   kiarashasadi@gmail.com (Saeid Asadi)
%   fakhroleslam@modares.ac.ir (Mohammad Fakhroleslam)
%
%   Description:
%   This code is written using MATLAB and Simulink, and is simulated for
%   water/5-HMF breackthrough curve validation.
%   This code, successfully worked on
%   - MATLAB version 9.14 (R2023a)
%   - Simulink version 10.7 (R2023a)
%
%   Usage:
%   Run this script in MATLAB to visualize Results
%
%   Last update: 2024-11-28
%%====================================================================================

clc
clear
close all

%% Constant and Initial Calculations
global Dax  kpa kpades A nx epsilon cA0 delz vdes v Daxdes
simulation_time=200; %[min]
Adsorption_time=145;%[min]
Desorption_time=55;%[min]
Rinsing_time=0;%[min]
QAdsorption=0.55; %[ml/ min]
QDesorption=0.55; % [ml/min]
HMF_Density=1.29; % [gr/cm^3]
R_P= 0.01925;% Resin or Adsorbent  seed diameter [cm]
r=0.23/2;%Bed Radius [cm]
A=pi*r^2;% Bed Area [cm^2]
Dia=r*2;% Bed diameter [cm]
Dax=138;% Adsorption Axial Dispersion coefficent [cm^2 / min]
kpa=0.4;% Adsorption Mass transfer coefficient [1/min]
L=10;% Length of column [cm]
v=QAdsorption/A
Daxdes=250;% Desorption Axial Dispersion coefficent [cm^2 / min] 1.994
kpades=0.20;% Desorption Mass transfer coefficient [1/min] 0.15
vdes=QDesorption/A
epsilon =0.317;%  Porosity [Dimensionless]
nx=55;% Node number
cA0=1.25/1000;% initial concentraion [gr  / cm^3]
z=10;% coulmn length [cm]
z=linspace(0,z,nx);%Length Dividing [cm]
delz=z(2)-z(1);%Delta Z [cm]
%%
expdata;%Experimental Data Validation
out=sim('ad_des_sim3');%Simulink Run
%% Adsorption BTC
subplot(2,2,1)
figure(1)
set(get(groot, 'Children'), 'WindowState', 'maximized');
plot(out.tout,out.Adsorption(:,nx)/cA0 ,'k','linew',2)
hold on
plot(sampletime,samplecon/cA0,'r*','linew',3)
axis([0,145,0,1.25*10^-3/cA0])
xlabel('Time (min)','fontsize',22)
ylabel('Dimensionless Concentration','fontsize',22)
legend('Adsorption brackthrough curve' , 'Adsorption experiment data' , 'location' , 'north east')
set(gca,'fontname','times new roman','fontsize',22)
%% Desorption BTC
subplot(2,2,2)
for i=1:length(out.tout)
    if out.tout(i)>145
        DES(i)=out.tout(i)
        DESH(i)=out.Adsorption(i)
    end
end
plot(DES(317:end),DESH(317:end)/(7*10^-3),'k','linew',2)
axis([148,200,0,7*10^-3/(7*10^-3)])
hold on
plot(sampletime1,samplecon1/(7*10^-3),'r*','linew',3)
xlabel('Time (min)','fontsize',22)
ylabel('Dimensionless Concentration' ,'fontsize',22)
legend( 'Desorption brackthrough Curve' , 'Desorption experiment data' , 'location' , 'north east')
set(gca,'fontname','times new roman','fontsize',22)

%% Adsorbent Adsorption Profile
subplot(2,2,3:4)
set(get(groot, 'Children'), 'WindowState', 'maximized');
surf(z(2:end),out.tout,out.Adsorption(:,nx+2:end))
axis([0,10,0,200,0,0.5])
view([90, 60])
ylabel('Time (min)','fontsize',22)
xlabel('length (cm)','fontsize',22)
zlabel('Loading Concentration  ($\displaystyle\frac{g}{cm^3}$)','interpreter','latex','fontsize',22)
set(gca,'fontname','times new roman','fontsize',22)