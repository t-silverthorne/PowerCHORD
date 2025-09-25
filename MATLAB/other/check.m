n = 8;
A = rand(n,n);
B = rand(n,n);
A = A*A';
B = B*B';
t = rand;

Asq = sqrtm(A);
iAsq = inv(Asq)
lhs = inv(t*A + (1-t)*B)
rhs = iAsq*inv(t*eye(n) + (1-t)*iAsq*B*iAsq)*iAsq
norm(lhs-rhs)