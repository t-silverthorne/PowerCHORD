%% evaluation on simple example
A = 2;
phi = pi/7
freq = 1.23;
tt = 0:.01:1;
tt =tt'
y = A*cos(2*pi*freq*tt - phi);
fitCosinorSingleFreq(tt,y,1);
[~,ff]=fitCosinorWindowFreq(tt,y,1,2,800)

%% more involved
A      = 1;
phi    = pi/7;
freq   = 10.23;
tt     = 0:.05:1;
tt     = tt';
y      = A*cos(2*pi*freq*tt - phi);
y      = y + randn(size(y));
[~,ff] = fitCosinorWindowFreq(tt,y,1,20,1e3)

%% test Lehmer code
n =5
Lmat = idxToLehmer(0:(factorial(n)-1),n);
lehmerToPerm(Lmat)

%% freq window matches singles
n  = 10;
y  = randn(n,1);
tt = linspace(0,1,n+1);
tt = tt(1:n);
[b1,rss1] = fitCosinorSingleFreq(tt,y,1);
[b2,rss2] = fitCosinorSingleFreq(tt,y,2);
[bw,rw]   = fitCosinorWindowFreq(tt,y,1,2,2);
if rss1<rss2
    1
    b1==bw
else
    2
    b2==bw
end
%% paged freq window
n =10; 
n4=30;
n5=20;
Y = randn(n,1,1,n4,n5);

[bp,fp,rp]=fitCosinorWindowFreqPaged(tt,Y,1,2,100);

aa = true;
for ii=1:n4
    for jj=1:n5
        [bw,fw,rw]=fitCosinorWindowFreqPaged(tt,Y(:,:,:,ii,jj),1,2,100);
        aa=aa&(bw==bp(:,:,:,ii,jj));
        aa=aa&(fw==fp(:,:,:,ii,jj));
        aa=aa&(rw==rp(:,:,:,ii,jj));
    end
end
aa

%% compute probability that rss_perm < rss_obs for single freq
fmin  = 1;
fmax  = 1;
Nfreq = 1;
Nperm = 1e3;
Nmeas = 10;

tt = rand(Nmeas,1);
nrep = 1e3;
pval = NaN(nrep,1);
fmin = 1;
fmax = 10;
Nfreq =1e2;
% not vectorised
% tic
% for ii=1:nrep
%     y = randn(Nmeas,1,1,1,1);
%     Yperm = perm5d(y,Nperm);
%     [~,~,rss_obs]=fitCosinorWindowFreq(tt,y,fmin,fmax,Nfreq);
%     [~,~,rss_perm]=fitCosinorWindowFreqPaged(tt,Yperm,fmin,fmax,Nfreq);
%     rss_perm =squeeze(rss_perm);
%     pval(ii) = mean(rss_perm<rss_obs);
% end
% mean(pval<.05)
% toc

%% vectorised
Nmeas = 20;
tt    = rand(Nmeas,1);
nrep  = 1e2;
pval  = NaN(nrep,1);
fmin  = 1;
fmax  = 10;
Nfreq = 1e1;
Nperm = 5e3;

tic
y              = randn(Nmeas,1,1,nrep,1);
Yperm          = perm5d(y,Nperm);
[~,~,rss_obs]  = fitCosinorWindowFreqPaged(tt,y,fmin,fmax,Nfreq);
[~,~,rss_perm] = fitCosinorWindowFreqPaged(tt,Yperm,fmin,fmax,Nfreq);
rss_perm       = squeeze(rss_perm);
rss_obs        = squeeze(rss_obs);
pval           = mean(rss_perm<rss_obs,2);
mean(pval<.05)
toc
%% alt test statistic
Nmeas = 10;
rng('default')
tt    = rand(Nmeas,1);
nrep  = 1e2;
pval  = NaN(nrep,1);
fmin  = 1;
fmax  = 10;
Nfreq = 10;
Nperm = 1e2;

Amp = 5
tic
y              = Amp*cos(2*pi*tt)+randn(Nmeas,1,1,nrep,1);
Yperm          = perm5d(y,Nperm);
[~,~,rss_obs]  = fitCosinorWindowFreqPaged(tt,y,fmin,fmax,Nfreq,'Amp-L2');
[~,~,rss_perm] = fitCosinorWindowFreqPaged(tt,Yperm,fmin,fmax,Nfreq,'Amp-L2');
rss_perm       = squeeze(rss_perm);
rss_obs        = squeeze(rss_obs);
pval           = mean(rss_perm>rss_obs,2);
mean(pval<.05)
toc

clf
histogram(pval)
xlim([0,1])