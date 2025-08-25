function A = orderConstraintMat(n)
%ORDERCONSTRAINTMATS matrices that force time points to be in correct order
A = eye(n);
A = A(1:(n-1),:);
for ii=1:n-1
    A(ii,ii+1)=-1;
end
end

