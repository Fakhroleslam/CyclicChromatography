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

function [sys,x0,str,ts]=ads_sfcn(t,x,u,flag,cinit,qinit)
global nx q cA0
switch flag
    case 0
        str=[];
        ts=[0, 0];
        s=simsizes;
        s.NumContStates=2*nx;
        s.NumDiscStates=0;
        s.NumOutputs=2*nx;
        s.NumInputs=1;
        s.DirFeedthrough=0;
        s.NumSampleTimes=1;
        sys=simsizes(s);
        Cint=zeros(1,nx);
        qint=zeros(1,nx);
        x0=[Cint , qint];
    case 1
        q = u;
        if q==1
            sys=myfun(t,x);
        end
        if q==2
            sys=myfundesorp(t,x);
        end
        if q==3
            sys=Rinsing(t,x)
        end
    case 3
        if q==1
            x(1)=cA0;
            x(nx)=(4/3)*(x(nx-1))-(1/3)*(x(nx-2));
        end
        if q==2
            x(1)=(-x(3)   +   4*x(2))/3;
            x(nx)=0;
        end
        if q==3
            x(1)=(-x(3)   +   4*x(2))/3;
            x(nx)=0;
        end
        sys=x;
    case {2 4 9}
        sys=[];
    otherwise
        error(['unhalded flag = ' ,num2str(flag)])
end