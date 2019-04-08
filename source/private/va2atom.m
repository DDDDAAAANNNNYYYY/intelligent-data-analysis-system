function [altde,mach]=va2atom(va,param,type)
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
        [ps,rho,snd]=atomstatic(altde);
        mach=va/snd/3.6;
    case 2
        mach=param;
        if va<=0 || mach<=0
            va=0;
            mach=0;         
        end
        snd=va/mach/3.6;
        altde=snd2atom(snd);
end
