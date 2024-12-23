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

%% ADSORPTION PURITY CALCULATION
P=out.simout4;
tt=P.Time;
sampurity=P.Data;
dd=[tt(1),sampurity(55)];
emad=1;
for i=2:length(tt)
    if dd(end,2)~=sampurity(i)
        emad=emad+1;
        dd(emad,:)=[tt(i),sampurity(i)];
    end
end
%%
PP=out.simout3;
tt=PP.Time;
sampurity_pro=PP.Data;
dddd=[tt(1),sampurity_pro(55)];
emad=1;
for i=2:length(tt)
    if dddd(end,2)~=sampurity_pro(i)
        emad=emad+1;
        dddd(emad,:)=[tt(i),sampurity_pro(i)];
    end
end
