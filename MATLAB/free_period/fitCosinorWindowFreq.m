function [beta_est,freq_est,rss_est] = fitCosinorWindowFreq(tt,y,fmin,fmax,Nfreq,method)
%FITCOSINORWINDOWFREQ Summary of this function goes here
%   Detailed explanation goes here
arguments
    tt  (:,1) double;
    y   (:,1) double;
    fmin;
    fmax;
    Nfreq;
    method = 'grid';
end
freqs = linspace(fmin,fmax,Nfreq);
freqs = reshape(freqs,1,1,[]);

switch method
    case 'grid'
        X        = [ones(length(tt),1,Nfreq) cos(2*pi*freqs.*tt) sin(2*pi*freqs.*tt)];
        bhat     = pagemldivide(X,y);
        rss      = pagenorm(y-pagemtimes(X,bhat),2).^2;
        [rss_est,mm] = min(rss);
        freq_est = freqs(mm);
        beta_est = bhat(:,:,mm);
end
end

