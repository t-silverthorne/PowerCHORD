test_that("evaluation", {
  N = sample(c(3:20),1)
  tvec = c(1:N)/N - 1/N
  expect_equal(evalMinEig(tvec,N/2),0)
})
