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
clear all
close all
warning off

global Dax  kpa kpades A nx epsilon cA0 delz vdes v Daxdes z vrin

Adsorption_time=70;%[min]
assignin('base','Adsorption_time',Adsorption_time)
Desorption_time=20; %[min]
assignin('base','Desorption_time',Desorption_time)
Rinsing_time=10;%[min]
assignin('base','Rinsing_time',Rinsing_time)
standby_time=abs(Adsorption_time-(Desorption_time+Rinsing_time));
assignin('base','standby_time',standby_time)
SumTimes=Adsorption_time+Desorption_time+Rinsing_time+standby_time;
simulation_time=SumTimes*7; %[min]
assignin('base','simulation_time',simulation_time)

%% REQUIRE PARAMETERS
QAdsorption=0.39;       % [ml/ min]
assignin('base','QAdsorption',QAdsorption)
QDesorption=0.64 ;% [ml/min]
 assignin('base','QDesorption',QDesorption)
Qrinsing=QDesorption;
assignin('base','Qrinsing',Qrinsing)
HMF_Density=1.29; % [gr/cm^3]
assignin('base','HMF_Density',HMF_Density)
R_P= 0.01925;% Resin or Adsorbent  seed diameter [cm]
assignin('base','R_P',R_P)
r=0.23/2; % Bed Radius [cm]
assignin('base','r',r)
A=pi*r^2;  % Bed Area [cm^2]
Dia=r*2;% Bed diameter [cm]
assignin('base','Dia',Dia)
Dax=138;% Adsorption Axial Dispersion coefficent [cm^2 / min]
kpa=0.4;% Adsorption Mass transfer coefficient [1/min]
L=10; % Length of column [cm]
assignin('base','L',L)
v=QAdsorption/A;
Daxdes=250;% Desorption Axial Dispersion coefficent [cm^2 / min] 
kpades=0.20;% Desorption Mass transfer coefficient [1/min] 
vdes=QDesorption/A;
vrin=Qrinsing/A;
epsilon =0.317;% Porosity [Dimensionless]
nx=55;% Node number
cA0=1.25/1000; % initial concentraion [gr  / cm^3]
assignin('base','cA0',cA0)
z=10; % coulmn length [cm]
z=linspace(0,z,nx); %Length Dividing [cm]
delz=z(2)-z(1); 
%% SIMULATION RUNNING
out=sim('ad_des_sim6');
P=out.simout5
tt=P.Time
sampurity=P.Data
dd=[tt(1),sampurity(55)];
emad=1;
for i=2:length(tt)
    if dd(end,2)~=sampurity(i)
        emad=emad+1;
        dd(emad,:)=[tt(i),sampurity(i)];
    end
end
set(gca,'fontname','times new roman','fontsize',23)
plot((dd(2:end,2)),'linewidth',2)
hold on
plot((dd(2:end,2)),'*','linewidth',3)
ylabel('Water purity %')
xlabel('Cycle number')
hold on

%%
figure(4)
subplot(2,1,1)
mesh(z(3:end),out.tout( 1:end),out.Adsorption.Data( 1:end,58:110))
set(gca,'fontname','times new roman','fontsize',23)
view([75, 30])
ylabel('time[min]')
xlabel('length[cm]')
zlabel('Concentration  ($\displaystyle\frac{g}{cm^3}$)','interpreter','latex')
subplot(2,1,2)
mesh(z(3:end),out.tout( 1:end),out.Adsorption.Data( 1:end,3:55))
set(gca,'fontname','times new roman','fontsize',23)
view([75, 30])
ylabel('time[min]')
xlabel('length[cm]')
zlabel('Concentration  ($\displaystyle\frac{g}{cm^3}$)','interpreter','latex')