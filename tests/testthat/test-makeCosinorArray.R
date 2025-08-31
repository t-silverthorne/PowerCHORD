test_that("evaluation", {
  n  = 12
  tt = runif(n)
  Nsamp = 1e2
  acros = seq(0,2*pi,length.out=8)
  freqs =  runif(8)
  expect_no_error(makeCosinorArray(tt,Nsamp,freqs,acros))
  uu=makeCosinorArray(tt,Nsamp,freqs,acros)
  expect_equal(dim(uu),c(12,Nsamp,length(freqs),length(acros)))
})

test_that("evaluation", {
  n     = 12
  tt    = seq(0,1,length.out=3)
  nsamp = 3
  acros = c(0,pi)
  freqs = c(1,0)
  uu=makeCosinorArray(tt,nsamp,freqs,acros,1,0)
  phase_inv = (uu[,,,1]+uu[,,,2]) |> sum()
  expect_equal(sum(phase_inv),0)
})

test_that('comparison with expand.grid',{
  acros  = seq(0,2*pi,length.out=8)
  freqs  = runif(8)
  gg     = expand.grid(freq=freqs,acro=acros)
  gg$val = cos(2*pi*gg$freq-gg$acro)

  cos(outer(2*pi*freqs,acros,'-')) |> sum()
  uu   = makeCosinorArray(1,1,freqs,acros,1,0)
  uu |> sum()
  val2 = uu |> as.vector()
  expect_equal(val2,gg$val)
})
