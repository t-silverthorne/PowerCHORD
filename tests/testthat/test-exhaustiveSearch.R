require(data.table)
setwd(test_path('../../'))
test_that("correct number of solutions", {
  nsol = exhaustiveSearch(N=8,Nfine=23,wlen=1,wdensity = 1,
                   returnType = 'all') %>% nrow()
  expect_equal(nsol,21318)

  nsol = exhaustiveSearch(N=6,Nfine=24,wlen=1,wdensity = 1,
                   returnType = 'all') %>% nrow()
  expect_equal(nsol,5620)

  nsol_d1 = exhaustiveSearch(N=6,Nfine=24,wlen=8,wdensity = 1,
                   returnType = 'all') %>% nrow()
  nsol_d0 = exhaustiveSearch(N=6,Nfine=24,wlen=8,wdensity = 0,
                   returnType = 'all') %>% nrow()
  expect_lt(nsol_d1,5620)
  expect_lt(nsol_d0,5620)
  expect_lt(nsol_d0,nsol_d1)

  count = exhaustiveSearch(N=6,Nfine=24,wlen=18,wdensity = 0,
                   returnType = 'all') %>% nrow()
  expect_equal(count,1)

  count = exhaustiveSearch(N=6,Nfine=24,wlen=19,wdensity = 0,
                   returnType = 'all') %>% nrow()
  expect_equal(count,NULL)
})

test_that("globally optimal value", {
  N = sample(c(4,6,8,10),1)
  Nfine = 2*N
  bv = exhaustiveSearch(N=N,Nfine=Nfine,wlen=1,wdensity = 1,
                   returnType = 'optimal')
  tau = c(1:Nfine)/Nfine-1/Nfine
  expect_equal(evalMinEig(tau[bv>0],1),N/2)
})

test_that("constrained optimal value", {
  bv = exhaustiveSearch(N=8,Nfine=24,wlen=12,wdensity = 1,
                   returnType = 'optimal')
  tau = c(1:24)/24-1/24
  val1=evalMinEig(tau[bv>0],1)

  bv = exhaustiveSearch(N=8,Nfine=24,wlen=13,wdensity = 1,
                   returnType = 'optimal')
  tau = c(1:24)/24-1/24
  val2=evalMinEig(tau[bv>0],1)
  expect_lte(val2,val1)
})

test_that('parsing multiple solution files',{
   count = exhaustiveSearch(N=7,Nfine=28,wlen=1,wdensity = 1,
                   returnType = 'all',flines = 1e3) %>% nrow()
   expect_equal(count,42288)
   count = exhaustiveSearch(N=7,Nfine=10,wlen=4,wdensity = 1,
                   returnType = 'all',flines=1) %>% nrow()
   expect_equal(count,3)
})

test_that('increase wdensity increase count',{
  N = sample(c(6:12),1)
  bv1 = exhaustiveSearch(N=N,Nfine=20,wlen=6,wdensity = 1,
                   returnType = 'all') |> nrow()
  bv2 = exhaustiveSearch(N=N,Nfine=20,wlen=6,wdensity = 2,
                   returnType = 'all') |> nrow()
  expect_lte(bv1,bv2)
})
