%% trivial example, get identity map
yalmip('clear')
% construct distance matrix
n      = 4;
m      = 2;
T1     = 8;
alpha  = intvar(m-1,1);
al_vec = [0;alpha];
D1     = get_chain_dist(n,T1,m,al_vec,true);

% other sdpvars
P      = binvar(n*m,n*m);
K      = intvar(n*m,n*m);

% solve
ops=sdpsettings('solver','gurobi');
optimize([D1*P - P*D1 == P*K*T1, ...
    sum(P,1)==1, ...
    sum(P,2)==1, ...
    K'==-K],-sum(sum(P)),ops)


%% nontrivial example ~20secs compute time
yalmip('clear')
n1      = 4;
m1      = 4;
T1      = 8;
alpha1  = intvar(m1-1,1);
al_vec1 = [0;alpha1];
D1      = get_chain_dist(n1,T1,m1,al_vec1,true);

n2      = 4;
m2      = 4;
T2      = 24;
alpha2  = intvar(m2-1,1);
al_vec2 = [0;alpha2];
D2      = get_chain_dist(n2,T2,m2,al_vec2,true);

% other sdpvars
P      = binvar(n2*m2,n1*m1);

% solve
ops=sdpsettings('solver','gurobi');
ops.gurobi.Presolve=0; % necessary otherwise constraint violation

% K      = intvar(n1*m1,n2*m2);
% optimize([D2*P - P*D1 == P*K*T1, ...
%       sum(P,1)<=1, ...
%       sum(P,2)<=1, ...
%       K'==-K],-sum(sum(P)),ops)
optimize([D2*P - P*D1 == 0, ...
      sum(P,1)<=1, ...
      sum(P,2)<=1],-sum(sum(P)),ops)



value(D2*P - P*D1 )
value(P)

%% nontrivial example 2
yalmip('clear')
n1      = 6;
m1      = 2;
T1      = 6;
alpha1  = intvar(m1-1,1);
al_vec1 = [0;alpha1];
D1      = get_chain_dist(n1,T1,m1,al_vec1,true);

n2      = 12;
m2      = 1;
T2      = 12;
alpha2  = intvar(m2-1,1);
al_vec2 = [0;alpha2];
D2      = get_chain_dist(n2,T2,m2,al_vec2,true);

% other sdpvars
P      = binvar(n2*m2,n1*m1);

% solve
ops=sdpsettings('solver','gurobi');
ops.gurobi.Presolve=0; % necessary otherwise constraint violation

optimize([D2*P - P*D1 == 0, ...
      sum(P,1)==1, ...
      sum(P,2)==1],-sum(sum(P)),ops)

sum(value(P),[1,2])

%% nontrivial example 3
yalmip('clear')
n1      = 6;
m1      = 2;
T1      = 6;
alpha1  = intvar(m1-1,1);
al_vec1 = [0;alpha1];
D1      = get_chain_dist(n1,T1,m1,al_vec1,true);

n2      = 12;
m2      = 1;
T2      = 12;
alpha2  = intvar(m2-1,1);
al_vec2 = [0;alpha2];
D2      = get_chain_dist(n2,T2,m2,al_vec2,true);

% other sdpvars
P      = binvar(n2*m2,n1*m1);

% solve
ops=sdpsettings('solver','gurobi');
ops.gurobi.Presolve=0; % necessary otherwise constraint violation

optimize([D2*P - P*D1 == 0, ...
      sum(P,1)==1, ...
      sum(P,2)==1],-sum(sum(P)),ops)

sum(value(P),[1,2])

%% projection layer
yalmip('clear')
n1      = 4;
m1      = 1;
T1      = 24;
alpha1  = intvar(m1-1,1);
al_vec1 = [0;alpha1];
D1      = get_chain_dist(n1,T1,m1,al_vec1,true);

n2      = 24*2;
m2      = 1;
T2      = 24;
D2      = get_chain_dist(n2,T2,m2,zeros(m2,1),false);

P      = binvar(n2*m2,n1*m1);

ops=sdpsettings('solver','gurobi');
ops.gurobi.Presolve=0; % necessary otherwise constraint violation

optimize([P'*D2*P - D1 == 0, ...
      sum(P,1)==1, ...
      sum(P,2)<=1],-sum(sum(P)),ops)

sum(value(P),[1,2])


