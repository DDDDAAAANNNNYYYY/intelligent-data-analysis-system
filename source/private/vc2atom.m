function [altde,mach]=vc2atom(vc,param,type)
% 根据表速反查大气数据
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
        mach=fzero(@(x)getvc(altde,x)-vc,[0 10000]);
    case 2
        mach=param;
        if vc<=0 || mach<=0
            vc=0;
            mach=0;
        end
        altde=fzero(@(x)getvc(x,mach)-vc,5000);
end

function vc=getvc(altde,mach)
vc=atomdynamic(altde,mach);
