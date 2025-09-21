classdef test_weinSumFastVect < matlab.unittest.TestCase
    methods (Test)
        % Test methods

        function compareToWeinSumFast(testCase)
            n    = 5;
            nrep = 10;
            Q    = rand(n,n);
            Q    = Q*Q';
            x = rand(n,1,1,1,nrep);
            
            results = zeros(1,1,1,1, nrep);
            for i = 1:nrep
                results(1,1,1,1, i) = weinSumFast(Q, x(:,1,1,1, i));
            end
            res2 = weinSumFastVect(Q,x);

            testCase.verifyEqual(results, res2,'AbsTol',1e-10)
        end
        
    end

end