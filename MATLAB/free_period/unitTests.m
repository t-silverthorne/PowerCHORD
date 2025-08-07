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
