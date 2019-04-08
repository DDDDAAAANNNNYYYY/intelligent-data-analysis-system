function [altde,mach]=qcps2atom(qc2ps,param,type)
% 动压静压之比反查大气数据
switch nargin
    case 1
        param=0;
        type=1;
    case 2
        type=1;
end
if qc2ps<0
    error('动静压之比不能小于0');
end

switch type
    case 1 % 高度
        altde=param;
    case 2 % 马赫
        mach=param;
        if qc2ps<=0 || mach<=0
            qc2ps=0;
            mach=0;
        end
        altde=fzero(@(x)getqc2ps(x,mach)-qc2ps,5000);
end
% 计算静压
ps=atomstatic(altde);
% 计算动压
qc=qc2ps*ps;
% 反查大气
[altde,mach]=qc2atom(qc,altde);

function qc2ps=getqc2ps(altde,mach)
[tmp1,tmp2,tmp3,tmp4,qc2ps]=atomdynamic(altde,mach);

