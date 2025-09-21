classdef test_weinSumFast < matlab.unittest.TestCase
    methods (Test)
        function compareToWeinSumSlow(testCase)
            n      = randsample(4:7,1);
            Q      = rand(n,n);
            Q      = Q*Q';
            x      = rand(n,1);
            aa     = weinSumFast(Q,x);
            [~,Tq] = getSymm4Mask_subtypes(n);
            bb     = weinSumSlow(Q,x,Tq);
            tol    = 1e-6; % Define a tolerance level for comparison
            testCase.verifyEqual(aa, bb, 'AbsTol', tol);
        end

        function compareToNestedLoop(testCase)
            n =4;
            T = getSymm4Mask_subtypes(n);
            w = getSymm4Weights_subtypes(n);
            Q = randn(n,n);
            Q = Q*Q';
            x = rand(n,1);
            
            ss = 0;
            tic
            for mm=1:15
                for i=1:n
                    for k=1:n
                        for alpha=1:n
                            for gamma=1:n
                                for j=1:n
                                    for l=1:n
                                        for beta=1:n
                                            for rho=1:n
                                                ss = ss + w(mm)*T(i,k,alpha,gamma,mm)*T(j,l,beta,rho,mm)*...
                                                    Q(i,k)*Q(alpha,gamma)*x(j)*x(l)*x(beta)*x(rho);
            
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            tt=weinSumFast(Q,x);
            tol    = 1e-6; 
            testCase.verifyEqual(ss,tt, 'AbsTol', tol);
        end
    end

end