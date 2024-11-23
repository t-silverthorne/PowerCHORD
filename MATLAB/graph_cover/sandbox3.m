nvec = [4 4 8*7*4*12];
mvec = [8 8 1];
Tvec = [8 8*7*4 8*7*4*12];

m1=mvec(1);n1=nvec(1);T1=Tvec(1);
alpha1  = intvar(m1-1,1);
al_vec1 = [0;alpha1];
D1      = get_chain_dist(n1,T1,m1,al_vec1,true);

m2=mvec(2);n2=nvec(2);T2=Tvec(2);
alpha2  = intvar(m2-1,1);
al_vec2 = [0;alpha2];
D2      = get_chain_dist(n2,T2,m2,al_vec2,true);

m3=mvec(3);n3=nvec(3);T3=Tvec(3);
alpha3  = intvar(m3-1,1);
al_vec3 = [0;alpha3];
D3      = get_chain_dist(n3,T3,m3,al_vec3,true);

P1 = binvar(nvec(2)*mvec(2),nvec(1)*mvec(1));
P2 = binvar(nvec(3)*mvec(3),nvec(2)*mvec(2));

P1
P2

ops=sdpsettings('solver','gurobi');
ops.gurobi.Presolve=0; 

optimize([D2*P1 - P1*D1 == 0, ...
          P2'*D3*P2 - D2==0,...
      sum(P1,1)==1, ...
      sum(P1,2)==1, ...
      sum(P2,1)==1, ...
      sum(P2,2)<=1],-sum(sum(P1+P2)),ops)