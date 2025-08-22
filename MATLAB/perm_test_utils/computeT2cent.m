function T2=computeT2cent(tt,y,freqs)
L  = getSpecPaged(tt,freqs);
T2 = diag(y'*L*y);
end
