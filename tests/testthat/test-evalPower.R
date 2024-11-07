test_that("compare with monte carlo", {
  freq=runif(1,0.5,3)
  Amp=.95+.1*runif(1)
  acro=2*pi*runif(1)
  mt = c(1:25)/25-1/25
  Nmc   = 1e5
  al_val = .05
  pwr_exact = evalPower(mt,freq,acro,Amp,al_val)
  pwr_MC1 = evalMonteCarloPower(mt,freq,acro,Amp,Nmc,al_val)
  expect_equal(pwr_exact,pwr_MC1,tolerance = 1e-2)
})
