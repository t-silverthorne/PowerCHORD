function M = getIsserlisTensor(C,mu,method)
%GETISSERLISTENSOR compute rank 4 tensor corresponding to 4th moments of
%multivariate normal distribution
arguments
    C (:,:) double;
    mu (:,1) double;
    method ='fast';
end

if size(C,1)~=size(C,2)
    error('Covariance matrix must be square')
end

n = size(C,1);
switch method
    case 'fast'
        A1 = repmat(C, [1,1,n,n]); % first term
        B1 = reshape(C,[1,1,n,n]);
        B1 = repmat(B1,[n,n,1,1]);
        
        a1  = reshape(mu,[n,1,1,1]);
        a1  = repmat(a1, [1,n,n,n]);
        aa1 = reshape(mu,[1,n,1,1]);
        aa1 = repmat(aa1,[n,1,n,n]);

        b1  = reshape(mu,[1,1,n,1]);
        b1  = repmat(b1, [n,n,1,n]);
        bb1 = reshape(mu,[1,1,1,n]);
        bb1 = repmat(bb1,[n,n,n,1]);
        
        A2 = reshape(C,[n,1,n,1]); % second term
        A2 = repmat(A2,[1,n,1,n]); 
        B2 = reshape(C,[1,n,1,n]);
        B2 = repmat(B2,[n,1,n,1]);

        a2  = reshape(mu,[n,1,1,1]);
        a2  = repmat(a2, [1,n,n,n]);
        aa2 = reshape(mu,[1,1,n,1]);
        aa2 = repmat(aa2,[n,n,1,n]);

        b2  = reshape(mu,[1,n,1,1]);
        b2  = repmat(b2, [n,1,n,n]);
        bb2 = reshape(mu,[1,1,1,n]);
        bb2 = repmat(bb2,[n,n,n,1]);
        
        A3 = reshape(C,[n,1,1,n]); % third term
        A3 = repmat(A3,[1,n,n,1]);
        B3 = reshape(C,[1,n,n,1]);
        B3 = repmat(B3,[n,1,1,n]);
        
        a3  = reshape(mu,[n,1,1,1]);
        a3  = repmat(a3, [1,n,n,n]);
        aa3 = reshape(mu,[1,1,1,n]);
        aa3 = repmat(aa3,[n,n,n,1]);

        b3  = reshape(mu,[1,n,1,1]);
        b3  = repmat(b3, [n,1,n,n]);
        bb3 = reshape(mu,[1,1,n,1]);
        bb3 = repmat(bb3,[n,n,1,n]);

        M = (a1.*aa1 + A1).*(B1 + b1.*bb1) + ...
                (a2.*aa2 + A2).*(B2 + b2.*bb2) + ...
                (a3.*aa3 + A3).*(B3 + b3.*bb3);
    case 'slow'
        M = NaN(n,n,n,n);
        for ii=1:n
            for jj=1:n
                for kk=1:n
                    for ll=1:n
                        M(ii,jj,kk,ll) = (mu(ii)*mu(jj) + C(ii,jj))*(mu(kk)*mu(ll) + C(kk,ll))+ ...
                            (mu(ii)*mu(kk)+C(ii,kk)*(C(jj,ll) + mu(jj)*mu(ll))) + ...
                            (mu(ii)*mu(ll)+C(ii,ll))*(C(jj,kk)+mu(jj)*mu(kk));
                    end
                end
            end
        end
end

end

