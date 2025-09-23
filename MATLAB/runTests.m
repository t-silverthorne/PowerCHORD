clear;
addpath('tests/helpers')
suite = matlab.unittest.TestSuite.fromFolder('tests');
results = run(suite);
disp(results)