function altde=snd2atom(snd)
% 根据声速反查大气数据
if snd<=295.1891
    snd=295.1891;
end

altde=fzero(@(x)getsnd(x)-snd,5000);

function snd=getsnd(altde)
[tmp,tmp,snd]=atomstatic(altde);