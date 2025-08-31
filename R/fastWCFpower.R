fastWCFpower=function(tt,freqs,Amp,alpha){
  # worst-case F-test power across a range of frequencies
  N    = length(tt)
  pwr  = Inf
  for (freq in freqs){
    Xr     = cbind(cos(2*pi*freq*tt), sin(2*pi*freq*tt))
    D      = crossprod(Xr,Xr)
    b      = matrix(c(sum(cos(2*pi*freq*tt)), sum(sin(2*pi*freq*tt))),nrow=2)
    invB   = D - b%*%t(b) / N
    beta   = c(Amp*cos(acro), Amp*sin(acro))
    lamb   = t(beta) %*% invB %*% beta
    f0     = qf(1 - alpha, df1 = 2, df2 = N - 3)
    pwrloc = pf(f0, df1 = 2, df2 = N - 3, ncp = lamb, lower.tail = FALSE)
    pwr    = min(pwr,pwrloc)
  }
  return(pwr)
}
