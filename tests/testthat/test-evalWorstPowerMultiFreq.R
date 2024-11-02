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
