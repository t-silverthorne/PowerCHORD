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
              
        A2 = reshape(C,[n,1,n,1]); % second term
        A2 = repmat(A2,[1,n,1,n]); 
        B2 = reshape(C,[1,n,1,n]);
        B2 = repmat(B2,[n,1,n,1]);
        
        A3 = reshape(C,[n,1,1,n]); % third term
        A3 = repmat(A3,[1,n,n,1]);
        B3 = reshape(C,[1,n,n,1]);
        B3 = repmat(B3,[n,1,1,n]);
        
        mu1 = reshape(mu,[n,1,1,1]);
        mu2 = reshape(mu,[1,n,1,1]);
        mu3 = reshape(mu,[1,1,n,1]);
        mu4 = reshape(mu,[1,1,1,n]);
        
        mu1 = repmat(mu1,[1,n,n,n]);
        mu2 = repmat(mu2,[n,1,n,n]);
        mu3 = repmat(mu3,[n,n,1,n]);
        mu4 = repmat(mu4,[1,n,n,1]);

        M = A1.*B1 + A2.*B2 + A3.*B3 + ...
            mu1.*mu2.*B1 + mu1.*mu3.*B2 + mu1.*mu4.*B3+ ...
            A1.*mu3.*mu4 + A2.*mu2.*mu4 + A3.*mu2.*mu3+ ...
               mu1.*mu2.*mu3.*mu4;
    case 'slow'
        error('Need to fix formula, use fast method for now')
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

