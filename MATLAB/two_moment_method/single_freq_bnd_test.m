n = 24;

tt    = rand(n,1);%linspace(0,1,n+1);
%tt    = tt(1:end-1)';

X     = [ones(n,1) cos(2*pi*tt) sin(2*pi*tt)];
H     = [0 1 0; 0 0 1];
L     = H*((X'*X)\(X'));
L     = L'*L;
Sigma = eye(n);

th    = rand*2*pi;
mu    = 10*X*[0 5*cos(th) 1.9*sin(th)]';
alpha = .15;

T = getSymm4Mask_subtypes(n);

thvals = linspace(0,2*pi,2^7+1);
thvals = thvals(1:end-1);

Amp   = 10;
freqs = [1 2 3];

clf
for freq=freqs
    bvals = arrayfun(@(th) get2mBound(L,Sigma,...
        X*[0 Amp*cos(freq*th) Amp*sin(freq*th)]',alpha,T),thvals);
    plot(thvals,bvals,'-k')
    hold on
    pause(1)
end
