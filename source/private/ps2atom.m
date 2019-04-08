function altde=ps2atom(ps)
% 根据静压反查大气数据
if ps<0
    ps=0;
end
altde=fzero(@(x)getps(x)-ps,5000);

function ps=getps(altde)
ps=atomstatic(altde);

