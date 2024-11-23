addpath('../../utils')

cfun_vec = @(t,f) sum(abs(sum(exp(2*pi*1j*t.*f),2)),3)
cfun     = @(t,f) abs(sum(exp(2*pi*1j*t.*f)))
t        = rand(10,3)
f        = [1,2]
f=reshape(f,1,1,[]);
cfun_vec(t,f)
sum(cfun(t(4,:),reshape(f,[],1)))



%cfun([1,2,3],[4,5,6,7])


N  = 60;
t0 = (1:N)/N - 1/N;
fvec = [1,52,52*7];
fvec=reshape(f,1,1,[]);
method='swarm';
options=optimoptions('particleswarm','SwarmSize',1e3,'UseVectorized',true,'ObjectiveLimit',0)
switch method
    case 'sa'
        [t,f]=simulannealbnd(@(t) cfun(t,fvec),rand(1,N),zeros(1,N),ones(1,N))
    case 'swarm'
        [t,f]=particleswarm(@(t) cfun_vec(t,fvec),N,zeros(1,N),ones(1,N),options)
end
plot(t,1,'.k')
xlim([0,1])

