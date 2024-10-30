require(data.table)
require(here)
setwd(here::here())
test_that("correct number of solutions", {
  nsol = exhaustiveSearch(N=8,Nfine=23,wlen=1,wdensity = 1,db_fname=NULL,
                   returnType = 'all') %>% nrow()
  expect_equal(nsol,21318)

  nsol = exhaustiveSearch(N=6,Nfine=24,wlen=1,wdensity = 1,db_fname=NULL,
                   returnType = 'all') %>% nrow()
  expect_equal(nsol,5620)

  # uses existing solution database
  nsol = exhaustiveSearch(N=6,Nfine=24,wlen=1,wdensity = 1,
                   returnType = 'all',db_fname='temp/cNecks_24_6.txt') %>% nrow()
  expect_equal(nsol,5620)

  nsol_d1 = exhaustiveSearch(N=6,Nfine=24,wlen=8,wdensity = 1,
                   returnType = 'all',db_fname='temp/cNecks_24_6.txt') %>% nrow()
  nsol_d0 = exhaustiveSearch(N=6,Nfine=24,wlen=8,wdensity = 0,
                   returnType = 'all',db_fname='temp/cNecks_24_6.txt') %>% nrow()
  expect_lt(nsol_d1,5620)
  expect_lt(nsol_d0,5620)
  expect_lt(nsol_d0,nsol_d1)

  count = exhaustiveSearch(N=6,Nfine=24,wlen=18,wdensity = 0,
                   returnType = 'all',db_fname='temp/cNecks_24_6.txt') %>% nrow()
  expect_equal(count,1)

  count = exhaustiveSearch(N=6,Nfine=24,wlen=19,wdensity = 0,
                   returnType = 'all',db_fname='temp/cNecks_24_6.txt') %>% nrow()
  expect_equal(count,0)
})


test_that("globally optimal value", {
  N = sample(c(4:12),1)
  bv = exhaustiveSearch(N=N,Nfine=24,wlen=1,wdensity = 1,db_fname=NULL,
                   returnType = 'optimal')
  tau = c(1:24)/24-1/24
  expect_equal(evalMinEig(tau[bv>0],1),N/2)
})

test_that("constrained optimal value", {
  bv = exhaustiveSearch(N=8,Nfine=24,wlen=12,wdensity = 1,db_fname=NULL,
                   returnType = 'optimal')
  tau = c(1:24)/24-1/24
  val1=evalMinEig(tau[bv>0],1)

  bv = exhaustiveSearch(N=8,Nfine=24,wlen=13,wdensity = 1,db_fname=NULL,
                   returnType = 'optimal')
  tau = c(1:24)/24-1/24
  val2=evalMinEig(tau[bv>0],1)
  expect_lte(val2,val1)
})

test_that('parsing multiple solution files',{
   count = exhaustiveSearch(N=7,Nfine=48,wlen=1,wdensity = 1,db_fname=NULL,
                   returnType = 'all') %>% nrow()
   expect_equal(count,1533939)
})


