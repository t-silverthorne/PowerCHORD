test_that("evaluation", {
  tvec = runif(10)
  freq = runif(1)
  acro = runif(1)*2*pi
  Amp  = 1.5
  Nmc  = 1e3
  expect_no_error(evalMonteCarloPower(tvec,freq,acro,Amp,Nmc))
})
