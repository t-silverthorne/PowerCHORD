function tt = randInitDesign(n,ceps)
%RANDINITDESIGN random initial design satisfying time ordering constraint
tt    = zeros(n,1);
tt(1) = 0;
if ceps > 1/n
    error('Spacing parameter must be < 1/n')
end
for ii=2:n
    tmin   = tt(ii-1)+ceps;
    tmax   = 1-ceps*(n+1-ii);
    tt(ii) = tmin + (tmax-tmin)*rand;
end

end

