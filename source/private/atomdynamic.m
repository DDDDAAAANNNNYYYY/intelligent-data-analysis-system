function [vc,va,qc,ps,qc2ps,snd,rho]=atomdynamic(altde,mach)
% 根据高度和马赫，计算表速和动压
switch nargin
    case 0
        altde=0;
        mach=0;
    case 1
        mach=0;
end
if mach<0
    mach=0;
end

% 海平面大气
p0=10332.27;
a0=340.43;

% 标准大气
[ps,rho,snd]=atomstatic(altde);
va=snd*mach*3.6;

% 计算动压
pp0=ps/p0;
if(mach>1)
    atom=(166.921*mach^7/(7*mach^2-1.0)^2.5-1.0)*pp0;
else
    atom=((1.0+0.2*mach^2)^3.5-1.0)*pp0;
end
qc=atom*p0;
qc2ps=qc/ps;

% 计算表速
if(atom>0.892929)	 % 超音速
    gg=(atom+1.)/166.921;
    vc0=mach*snd/a0;
    while true
        em2=7.*vc0^2-1.;
        vc1=vc0-em2*((vc0^7-gg*em2^2.5)/(7.*vc0^6*(2.*vc0^2-1.)));
        if(abs(vc1-vc0)<1.e-5)
            vc=vc1*a0;
            break;
        end
        vc0=vc1;
    end
else
    vc=a0*sqrt(5.*((atom+1.)^(2./7)-1.));
end
vc=vc*3.6;

