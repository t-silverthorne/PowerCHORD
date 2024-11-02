test_that("phase discretization matches eigenvalue method", {
  Amp=runif(1)*2
  freq=runif(1,0.5,12)
  Nmeas = sample(6:12,1)
  mt    = c(1:Nmeas)/Nmeas-1/Nmeas
  mp1=evalWorstPower(mt,freq,Amp,method='test')
  mp2=evalWorstPower(mt,freq,Amp,method='eig')
  expect_equal(mp1,mp2,tolerance =1e-6)
})
