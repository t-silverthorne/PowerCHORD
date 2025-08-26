function TlinVECT = getSymm4Mask_subtypesVect(n,n5,n6)
%GETSYMM4MASKCTRCT vectorised version of getSymm4Mask_subTypes
arguments
    n  double;
    n5 double;
    n6 double;
end
[x1,x2,x3,x4]=ndgrid(1:n,1:n,1:n,1:n);

TlinVECT = false(n^4*n5*n6,15);

% construct T alphabet
fibre_comp = ( (x1==x2) + (x1==x3) + (x1==x4) + (x2==x3) + (x2==x4) + (x3==x4) );
Ta = (fibre_comp == 0);
Tb = (fibre_comp == 1);
Tc = (fibre_comp == 2);
Td = (fibre_comp == 3);
Te = (fibre_comp == 6);

% construct TlinVECT
Tav=repmat(Ta,[1,1,1,1,n5,n6]);
Tbv=repmat(Tb,[1,1,1,1,n5,n6]);
Tcv=repmat(Tc,[1,1,1,1,n5,n6]);
Tdv=repmat(Td,[1,1,1,1,n5,n6]);
Tev=repmat(Te,[1,1,1,1,n5,n6]);

x1v=repmat(x1,[1,1,1,1,n5,n6]);
x2v=repmat(x2,[1,1,1,1,n5,n6]);
x3v=repmat(x3,[1,1,1,1,n5,n6]); 
x4v=repmat(x4,[1,1,1,1,n5,n6]);

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

TlinVECT = sparse(TlinVECT);
end


