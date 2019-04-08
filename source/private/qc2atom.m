function [altde,mach]=qc2atom(qc,param,type)
% 根据动压反查大气数据
% qc：动压
% param；高度或马赫
% type：1表示param是高度，默认
%       2表示param是马赫
%
switch nargin
    case 1
        param=0;
        type=1;
    case 2
        type=1;
end
switch type
    case 1
        altde=param;
        mach=fzero(@(x)getqc(altde,x)-qc,[0 10000]);
    case 2
        mach=param;
        if qc<=0 || mach<=0
            qc=0;
            mach=0;
        end
        altde=fzero(@(x)getqc(x,mach)-qc,5000);
end
% [vc,qc,qc2ps,va,ps,rho,snd]=atomdynamic(altde,mach);

function qc=getqc(altde,mach)
[tmp1,tmp2,qc]=atomdynamic(altde,mach);
