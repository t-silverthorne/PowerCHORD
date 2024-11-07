test_that("evaluation", {
  N = sample(c(3:20),1)
  tvec = c(1:N)/N - 1/N
  expect_equal(evalMinEig(tvec,N/2),0)
})

test_that("uses equispaced Nyquist formula", {
  N  = 24
  mt = c(1:N)/N
  f  = 12
  expect_gt(evalMinEig(mt,f,design='general'),0)
  expect_equal(evalMinEig(mt,f,design='equispaced'),0)
  expect_gt(evalMinEig(mt,f*.99,design='equispaced'),0)
})
