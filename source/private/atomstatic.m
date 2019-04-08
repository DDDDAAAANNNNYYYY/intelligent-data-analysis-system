function [ps,rho,snd]=atomstatic(altde)
% 根据高度计算标准大气参数

% 标准大气
if altde>11000
    eta=0.751874;
    zeta=exp(0.5208-1.576883e-4*altde);
    snd=295.1891;
else
    eta=1.-2.25569e-5*altde;
    zeta=eta^4.2561;
    snd=340.43*sqrt(eta);
end
% kg/m^3
rho=0.124872579*zeta;
% kg/m^2
ps=10332.27*eta*zeta;

