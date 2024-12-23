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
%   Last update: 2024-11-28
%%====================================================================================

function dudt=Rinsing(t,yin)
global nx epsilon kA  vrin  Daxdes delz kpades A DesorpQ cA0
dudt=zeros(2*nx,1);
dudt=dudt';
for i= 2:nx-1
    if i==2
        yin(1)=(-yin(1+2)   +   4*yin(1+1))/3;
    end
    if i==nx-1
        yin(nx)=0;
    end
    d2cA_dz2(i)=( yin(i+1)-2*yin(i)+yin(i-1))/(delz^2);
    dcA_dz(i)=((yin(i+1)-yin(i-1)))/(2*delz);
    a=1579;
    b=1543;
    n=0.7022;
    qstar(i)=a*yin(i)/(1+b*yin(i)^n);
    dudt(i+nx+1)=kpades*(qstar(i)-yin(i+nx+1));
    dudt(i)=(Daxdes*d2cA_dz2(i))-(-vrin)/epsilon*dcA_dz(i)-((1-epsilon)/epsilon)*dudt(i+nx+1);
end
end