test_that("reshaping works as expected", {
  n1  = sample(1:10,1)
  n2  = sample(1:10,1)
  n3  = sample(1:10,1)
  x   = array(rnorm(n1*n2*n3),c(n1,n2,n3))
  xfl = matrix(x,n1,n2*n3)
  xss = colSums(xfl,1)
  x2  = array(xss,dim(x)[-1])
  expect_equal(colSums(x),x2)
})

test_that('eval matches expand.grid',{
  set.seed(1)
  n     = 12
  tt    = runif(n)
  freqs = c(1,2,3)
  acros = c(0,pi/2,pi,3*pi/2)
  x     = makeCosinorArray(tt,10,freqs,acros)
  resQ  = getQuadForm(tt,freqs)
  Qf    = resQ$Qf
  Nperm = 1e2
  alpha=0.05
  set.seed(1)
  pwr1=fastMCTinfpower(Qf,x,Nperm,alpha)
  expect_equal(pwr1$pwr_est[,1],pwr1$pwr_vec[1:length(acros)])
})
