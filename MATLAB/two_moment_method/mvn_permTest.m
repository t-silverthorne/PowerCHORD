n   = 10;
tt    = rand(n,1);
Sigma = eye(n);
mu    = 0*cos(2*pi*tt-pi/2);
nsamp = 1e3;
nperm = 1000;
nfreq = 20;
Y=mvnrnd(mu,Sigma,nsamp);

fmin =1; fmax=2;
Qforms = NaN(n,n,nfreq);
freqs  = linspace(fmin,fmax,nfreq);
for ff=1:nfreq
    Qforms(:,:,ff) = getSpecQform(tt,freqs(ff));
end
meanQ  = mean(Qforms,3);
T2     = @(x) x'*meanQ*x;
Tinfty = @(x) max(squeeze(pagemtimes(x',pagemtimes(Qforms,x))));

T2(rand(n,1))
Tinfty(rand(n,1))

pvals_2     = NaN(nsamp,1);
pvals_infty = NaN(nsamp,1);
for ii=1:nsamp
    y = Y(ii,:)';
    T2_obs     = T2(y);
    Tinfty_obs = Tinfty(y);
    T2p =NaN(nperm,1);
    Tip =NaN(nperm,1);
    for jj=1:nperm
        yp = y(randperm(n));
        T2p(jj) = T2(yp);
        Tip(jj) = Tinfty(yp);
    end
    pvals_2(ii) = mean(T2p>T2_obs);
    pvals_infty(ii) = mean(Tip>Tinfty_obs);
end

close all
tiledlayout(2,1)
nexttile
histogram(pvals_2,30)
xlim([0,1])
nexttile
histogram(pvals_infty,30)
xlim([0,1])
