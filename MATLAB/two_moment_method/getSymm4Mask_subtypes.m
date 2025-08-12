function T = getSymm4Mask_subtypes(n)
%GETSYMM4MASKCTRCT compute mask tensor in format suitable for contracting
%against the Gaussian tensor (i.e. check not only permutation partition
%type but also which indices collide within the perm)
arguments
    n double;
end
[x1,x2,x3,x4]=ndgrid(1:n,1:n,1:n,1:n);

T = false(n,n,n,n,15);
% type A
Ta =   ( (x1==x2) + (x1==x3) + (x1==x4) + (x2==x3) + (x2==x4) + (x3==x4) ) == 0;
T(:,:,:,:,1) = Ta;

% type B
Tb =  ( (x1==x2) + (x1==x3) + (x1==x4) + (x2==x3) + (x2==x4) + (x3==x4) )  == 1;
T(:,:,:,:,2) = Tb & (x1==x2);
T(:,:,:,:,3) = Tb & (x2==x3);
T(:,:,:,:,4) = Tb & (x3==x4);
T(:,:,:,:,5) = Tb & (x1==x3);
T(:,:,:,:,6) = Tb & (x1==x4);
T(:,:,:,:,7) = Tb & (x2==x4);

% type C
Tc =  ( (x1==x2) + (x1==x3) + (x1==x4) + (x2==x3) + (x2==x4) + (x3==x4) ) == 2;
T(:,:,:,:,8)  = Tc & (x1==x2);
T(:,:,:,:,9)  = Tc & (x1==x3);
T(:,:,:,:,10) = Tc & (x1==x4);

% type D
Td =  ( (x1==x2) + (x1==x3) + (x1==x4) + (x2==x3) + (x2==x4) + (x3==x4) ) == 3;
T(:,:,:,:,11) = Td & (x1==x2)&(x2==x3);
T(:,:,:,:,12) = Td & (x1==x2)&(x2==x4);
T(:,:,:,:,13) = Td & (x1==x3)&(x3==x4);
T(:,:,:,:,14) = Td & (x2==x3)&(x3==x4);

% type E
Te = ( (x1==x2) + (x1==x3) + (x1==x4) + (x2==x3) + (x2==x4) + (x3==x4) )  == 6;
T(:,:,:,:,15)=Te;
end


