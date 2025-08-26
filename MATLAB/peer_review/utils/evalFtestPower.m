function pwr = evalFtestPower(tt,freq,acro,Amp,alpha)
% EVALFTESTPOWER Exact power of one frequency f-test
arguments
    tt (:,1) double;
    freq ;
    acro ;
    Amp ;
    alpha = 0.05 ;
end
N    = length(tt);
Xr   = [cos(2*pi*freq*tt) sin(2*pi*freq*tt)];
D    = Xr'*Xr;
b    = [sum(cos(2*pi*freq*tt));sum(sin(2*pi*freq*tt))];
invB = D - b*b'/N;
beta = [Amp*cos(acro);Amp*sin(acro)];
lamb = beta'*invB*beta;

f0   = finv(1-alpha,2,N-3);
pwr  = ncfcdf(f0,2,N-3,lamb,'upper');
end

