% check cheb inequality for symmetric Q

nrep = 1e3;
n    = 10;
cnt  = 0;
for ii=1:nrep
	if	~check_cheb(ii)
		cnt = cnt+1;
	%	fprintf('Fail\n')
	end
end
cnt/nrep
function cbool = check_cheb(n)
Q = rand(n,n);
Q = Q*Q';
x = rand(n,1);

Tobs = x'*Q*x;

w1 = 1/n;
w2 = 1/n/(n-1);
J  = ones(n,n)-eye(n);

Tmean =w1*trace(Q)*pagemtimes(pagetranspose(x),x) +...
    w2*trace(J*Q)*pagemtimes(pagetranspose(x),pagemtimes(J,x));
cbool = Tobs>Tmean;
end
