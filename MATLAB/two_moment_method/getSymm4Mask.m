function [Ta,Tb,Tc,Td,Te] = getSymm4Mask(n,verify)
%GETPERMMASK masks for computing 4th moment matrix elements on Symmetric
%group on n symbols, assumes dim of representation >= 4
arguments
    n double;
    verify=false;
end
[x1,x2,x3,x4]=ndgrid(1:n,1:n,1:n,1:n);
% get type A
Ta = (x1~=x2)&(x1~=x3)&(x1~=x4)&(x2~=x3)&(x2~=x4)&(x3~=x4);
% get type B
Tb = ((x1==x2)&(x2~=x3)&(x2~=x4)&(x3~=x4))|... % need collision, distinct others, others distinct
     ((x1==x3)&(x3~=x2)&(x3~=x4)&(x2~=x4))|...
     ((x1==x4)&(x4~=x2)&(x4~=x3)&(x2~=x3))|...
     ((x2==x3)&(x3~=x1)&(x3~=x4)&(x1~=x4))|...
     ((x2==x4)&(x4~=x1)&(x4~=x3)&(x1~=x3))|...
     ((x3==x4)&(x4~=x1)&(x4~=x2)&(x1~=x2));
% get type C
Tc = ((x1==x2)&(x3==x4)&(x2~=x3))|...
     ((x1==x3)&(x2==x4)&(x2~=x3))|...
     ((x1==x4)&(x2==x3)&(x2~=x4));
% get type D
Td = ((x1==x2)&(x2==x3)&(x4~=x1))|...
     ((x1==x2)&(x2==x4)&(x3~=x1))|...
     ((x1==x3)&(x3==x4)&(x2~=x1))|...
     ((x2==x3)&(x3==x4)&(x1~=x2));
% get type E
Te = (x1==x2)&(x2==x3)&(x3==x4);

if verify
    va = (sum(Ta,'all') == nchoosek(n,4)*factorial(4));
    vb = (sum(Tb,'all') == nchoosek(n,3)*factorial(3)*6); % count ways to choose 3, need ordering, which of 6 labellings your source is
    vc = (sum(Tc,'all') == nchoosek(n,2)*factorial(2)*3); % count ways to choose 3, need ordering, which of 3 labellings your source is
    vd = (sum(Td,'all') == nchoosek(n,2)*factorial(2)*4);
    ve = (sum(Te,'all') == n);    
    va&vb&vc&vd&ve
end

end

