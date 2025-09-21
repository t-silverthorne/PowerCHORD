classdef test_orderConstraintMat < matlab.unittest.TestCase
    methods(Test)
        function testOrderConstraintMatValidInput(testCase)
            % test with valid input
            expectedOutput = [1 -1 0; 0 1 -1];
            actualOutput = orderConstraintMat(3);
            testCase.verifyEqual(actualOutput, expectedOutput);
        end
    end
end
