function [beta_est,freq_est,rss_est] = fitCosinorWindowFreqPaged(tt,y,fmin,fmax,Nfreq,method)
%FITCOSINORWINDOWFREQPAGED assumes third index is used for frequency
%paging, gives freq_est of size [1,1,1,size(X)[4:end]] and 
% beta_est of size [3,1,1,size(X)[4:end]] 
arguments
    tt  (:,1) double;
    y;
    fmin;
    fmax;
    Nfreq;
    method = 'grid';
end
freqs = linspace(fmin,fmax,Nfreq);
freqs = reshape(freqs,1,1,[]);

switch method
    case 'grid'
        X            = [ones(length(tt),1,Nfreq) cos(2*pi*freqs.*tt) sin(2*pi*freqs.*tt)];
        bhat         = pagemldivide(X,y);
        rss          = pagenorm(y-pagemtimes(X,bhat),2);
        [rss_est,mm] = min(rss,3); % take min on freq dim
        FREQS        = freqs.*ones(size(rss));
        freq_est     = FREQS(mm);
        beta_est     = bhat(mm);
end
end