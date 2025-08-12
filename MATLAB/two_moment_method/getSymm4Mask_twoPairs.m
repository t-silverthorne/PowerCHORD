function [Ta,Tb,Tc,Td,Te] = getSymm4Mask_twoPairs(n)
    [x1,x2,x3,x4] = ndgrid(1:n,1:n,1:n,1:n);
    
    % Type E: all equal
    Te = (x1==x2) & (x1==x3) & (x1==x4);
    
    % Type A: all distinct
    Ta = (x1~=x2) & (x1~=x3) & (x1~=x4) & (x2~=x3) & (x2~=x4) & (x3~=x4);
    
    % Type C: exactly two disjoint pairs equal, i.e. (i,i,j,j) with i!=j
    Tc = ((x1==x2) & (x3==x4) & (x1~=x3)) | ...
         ((x1==x3) & (x2==x4) & (x1~=x2)) | ...
         ((x1==x4) & (x2==x3) & (x1~=x2));
    
    % Type D: triple equal + one distinct
    % Check all triples: exactly three equal and one different
    % This can be done by checking if any triple equal and not all equal (exclude E)
    triple1 = (x1==x2) & (x1==x3) & (x1~=x4);
    triple2 = (x1==x2) & (x1==x4) & (x1~=x3);
    triple3 = (x1==x3) & (x1==x4) & (x1~=x2);
    triple4 = (x2==x3) & (x2==x4) & (x2~=x1);
    Td = (triple1 | triple2 | triple3 | triple4) & ~Te;
    
    % Type B: exactly one pair equal and the rest distinct
    % So not A, not C, not D, not E, but has exactly one pair equal
    Tb = ~(Ta | Tc | Td | Te);
end