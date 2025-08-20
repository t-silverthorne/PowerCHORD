function [Tlin,TlinVECT] = getSymm4Mask_subtypesVect(n,n5,n6)
%GETSYMM4MASKCTRCT vectorised version of getSymm4Mask_subTypes
arguments
    n double;
end
[x1,x2,x3,x4]=ndgrid(1:n,1:n,1:n,1:n);

Tlin = false(n^4,15);
TlinVECT = false(n^4*n5*n6,15);

% construct T alphabet
Ta =   ( (x1==x2) + (x1==x3) + (x1==x4) + (x2==x3) + (x2==x4) + (x3==x4) ) == 0;
Tb =  ( (x1==x2) + (x1==x3) + (x1==x4) + (x2==x3) + (x2==x4) + (x3==x4) )  == 1;
Tc =  ( (x1==x2) + (x1==x3) + (x1==x4) + (x2==x3) + (x2==x4) + (x3==x4) ) == 2;
Td =  ( (x1==x2) + (x1==x3) + (x1==x4) + (x2==x3) + (x2==x4) + (x3==x4) ) == 3;
Te = ( (x1==x2) + (x1==x3) + (x1==x4) + (x2==x3) + (x2==x4) + (x3==x4) )  == 6;


% construct Tlin
Tlin(:,1)  = Ta(:);
Tlin(:,2)  = Tb(:) & (x1(:)==x2(:));
Tlin(:,3)  = Tb(:) & (x2(:)==x3(:));
Tlin(:,4)  = Tb(:) & (x3(:)==x4(:));
Tlin(:,5)  = Tb(:) & (x1(:)==x3(:));
Tlin(:,6)  = Tb(:) & (x1(:)==x4(:));
Tlin(:,7)  = Tb(:) & (x2(:)==x4(:));
Tlin(:,8)  = Tc(:) & (x1(:)==x2(:));
Tlin(:,9)  = Tc(:) & (x1(:)==x3(:));
Tlin(:,10) = Tc(:) & (x1(:)==x4(:));
Tlin(:,11) = Td(:) & (x1(:)==x2(:))&(x2(:)==x3(:));
Tlin(:,12) = Td(:) & (x1(:)==x2(:))&(x2(:)==x4(:));
Tlin(:,13) = Td(:) & (x1(:)==x3(:))&(x3(:)==x4(:));
Tlin(:,14) = Td(:) & (x2(:)==x3(:))&(x3(:)==x4(:));
Tlin(:,15) = Te(:);


% construct TlinVECT
Tav=repmat(Ta,[1,1,1,1,n5,n6]) 
Tbv=repmat(Tb,[1,1,1,1,n5,n6]) 
Tcv=repmat(Tc,[1,1,1,1,n5,n6]) 
Tdv=repmat(Td,[1,1,1,1,n5,n6]) 
Tev=repmat(Te,[1,1,1,1,n5,n6]) 

x1v=repmat(x1,[1,1,1,1,n5,n6]) 
x2v=repmat(x2,[1,1,1,1,n5,n6]) 
x3v=repmat(x3,[1,1,1,1,n5,n6]) 
x4v=repmat(x4,[1,1,1,1,n5,n6]) 

TlinVECT(:,1)  = Tav(:);
TlinVECT(:,2)  = Tbv(:) & (x1v(:)==x2v(:));
TlinVECT(:,3)  = Tbv(:) & (x2v(:)==x3v(:));
TlinVECT(:,4)  = Tbv(:) & (x3v(:)==x4v(:));
TlinVECT(:,5)  = Tbv(:) & (x1v(:)==x3v(:));
TlinVECT(:,6)  = Tbv(:) & (x1v(:)==x4v(:));
TlinVECT(:,7)  = Tbv(:) & (x2v(:)==x4v(:));
TlinVECT(:,8)  = Tcv(:) & (x1v(:)==x2v(:));
TlinVECT(:,9)  = Tcv(:) & (x1v(:)==x3v(:));
TlinVECT(:,10) = Tcv(:) & (x1v(:)==x4v(:));
TlinVECT(:,11) = Tdv(:) & (x1v(:)==x2v(:))&(x2v(:)==x3v(:));
TlinVECT(:,12) = Tdv(:) & (x1v(:)==x2v(:))&(x2v(:)==x4v(:));
TlinVECT(:,13) = Tdv(:) & (x1v(:)==x3v(:))&(x3v(:)==x4v(:));
TlinVECT(:,14) = Tdv(:) & (x2v(:)==x3v(:))&(x3v(:)==x4v(:));
TlinVECT(:,15) = Tev(:);



Tlin     = sparse(Tlin);
TlinVECT = sparse(Tlin);


end


