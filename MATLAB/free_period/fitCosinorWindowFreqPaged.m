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
        rss          = pagenorm(y-pagemtimes(X,bhat),2).^2;
        [rss_est,mm] = min(rss,[],3); % take min on freq dim
        FREQS        = freqs.*ones(size(rss));
        freq_est     = FREQS(mm);
        [~,~,~,n4,n5] = size(y);
        m2d = squeeze(mm);
        m2d = reshape(m2d,[n4,n5]);
        beta_est = NaN(3,1,1,n4,n5);
        for ii=1:n4
            for jj=1:n5
                beta_est(:,:,:,ii,jj)=bhat(:,:,m2d(ii,jj),ii,jj);
            end
        end
    case 'mean-rss'
        X       = [ones(length(tt),1,Nfreq) cos(2*pi*freqs.*tt) sin(2*pi*freqs.*tt)];
        bhat    = pagemldivide(X,y);
        rss     = pagenorm(y-pagemtimes(X,bhat),2).^2;
        rss_est = mean(rss,3); % take min on freq dim
        beta_est =NaN;
        freq_est =NaN;
    case 'Amp-L2'
        X       = [ones(length(tt),1,Nfreq) cos(2*pi*freqs.*tt) sin(2*pi*freqs.*tt)];
        bhat    = pagemldivide(X,y);
        rss_est = mean(bhat(2:3,:,:,:,:).^2,3); % take min on freq dim
        beta_est =NaN;
        freq_est =NaN;
end
end