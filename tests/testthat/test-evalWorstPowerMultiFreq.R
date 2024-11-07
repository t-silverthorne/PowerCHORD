test_that("function evaluation", {
  mt = c(1:20)/20 - 1/20
  Amp=1
  fmin=1
  fmax  = 19
  Nfreq = 2^6
  expect_no_error(evalWorstPowerMultiFreq(mt=mt,
                                          Amp=Amp,
                                          fmin=fmin,
                                          fmax=fmax,
                                          Nfreq=Nfreq))
})

test_that("matches at single freq",{
  mt = c(1:20)/20 -1/20
  alpha = runif(1)
  pwr1=evalWorstPower(mt,freq=1,Amp=1,alpha=alpha,design='equispaced')
  pwr2=evalWorstPowerMultiFreq(mt,fmin=1,fmax=1,Nfreq=1,Amp=1,alpha=alpha,design='equispaced')
  expect_equal(pwr1,pwr2)
})

test_that("matches known example at multifreq",{
  mt = c(1:20)/20 -1/20
  alpha = runif(1)
  pwr1=evalWorstPower(mt,freq=10,Amp=1,alpha=alpha,design='equispaced')
  pwr2=evalWorstPowerMultiFreq(mt,fmin=1,fmax=10,Nfreq=10,Amp=1,alpha=alpha,design='equispaced')
  expect_equal(pwr1,pwr2)
  pwr3=evalWorstPowerMultiFreq(mt,fmin=1,fmax=10,Nfreq=10,Amp=1,alpha=alpha*runif(1),design='equispaced')
  expect_gt(abs(pwr2-pwr3),0)
})
