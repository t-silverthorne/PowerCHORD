function anew  = sFun_single(alpha,thresh)
anew=alpha;
if rand<thresh & length(alpha)>1
    ind = randsample(2:length(alpha),1);
    anew(ind) = anew(ind) + randsample([-1,1],1);
end

end