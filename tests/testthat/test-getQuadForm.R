test_that("vectorization works", {
  n = 6
  tt = runif(n)
  res=getQuadForm(tt,c(1,1.5,2.5))
  res2=getQuadForm(tt,c(1.5))
  res3=getQuadForm(tt,c(2.5))
  expect_equal(apply(res$Qf,c(1,2),mean),res$Q)
  expect_equal(res2$Q,res$Qf[,,2])
  expect_equal(res2$Qf[,,1],res$Qf[,,2])
  expect_equal(res3$Q,res$Qf[,,3])
  expect_equal(res3$Qf[,,1],res$Qf[,,3])
})

test_that('agreement with matlab',{
  n        = 4
  tt       = c(0,0.1,0.3,0.5)
  res      = getQuadForm(tt,c(1.12,2.2))
  res_test = res$Q |> eigen()
  res_test = res_test$values |> as.numeric()
  expect_equal(sort(res_test),  sort(
                          c(-0.000000000000000,
                             0.184218012967888,
                             0.380300572287286,
                             0.993309043824075)))
  res_test2=res$Qf[,,2] |> eigen()
  res_test2=res_test2$values |> as.numeric()
  expect_equal(sort(res_test2),c(-0.000000000000000,
                                 -0.000000000000000,
                                  0.393136009689626,
                                  1.263651446537557))
})
