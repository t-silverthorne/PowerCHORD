% make sure power bounds evaluate
clear
addpath('../two_moment_method/')
n      = 10;
nd1    = 5;
nd2    = 4;
nd3    = 6;
x      = randn(n,1,1,1,nd1,nd2,nd3);
Q      = randn(n,n);
Q      = Q*Q';
[~,Tq] = getSymm4Mask_subtypes(n);
evalChebPbnd(Q,x,Tq);
% vectorized
out_vec = evalChebPowerbnd(Q,x,Tq,0.05);

% loop
out_loop = zeros(nd2,nd3);
for jj = 1:nd2
    for kk = 1:nd3
        xx = x(:,:,:,:,:,jj,kk);           % slice (n × 1 × 1 × 1 × nd1)
        out_loop(jj,kk) = evalChebPowerbnd(Q,xx,Tq,0.05);
    end
end
out_loop-squeeze(out_vec)