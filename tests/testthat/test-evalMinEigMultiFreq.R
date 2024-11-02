test_that("multiplication works", {
  N = sample(3:20,1)
  mt = c(1:N)/N - 1/N
  expect_equal(evalMinEigMultiFreq(mt,fmin=1,fmax=N/2,Nfreq=2^6),0)
  expect_equal(evalMinEigMultiFreq(mt,fmin=1,fmax=1,Nfreq=2^6),N/2)
})
