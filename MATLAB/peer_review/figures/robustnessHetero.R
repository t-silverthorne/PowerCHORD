# check how equispaced vs random designs perform for signals that violate model assumptions
require(devtools)
require(ggplot2)
require(data.table)
library(dplyr)

load_all()

n     = 12
tt    = (0:n)/n
tt    = tt[1:n]
Nsamp = 1e3
Amin  = 2
Amax  = 2
racro = function(){runif(1,0,2*pi)}
rAmp  = function(Amin,Amax){runif(1,Amin,Amax)}
sim_noise        = function(tt)    { as.numeric(rnorm(length(tt)))}
sim_noise2       = function(tt,L)  { as.numeric(L%*%matrix(rnorm(length(tt))))}
sim_model        = function(tt,L,Amin,Amax)  { as.numeric(matrix(rAmp(Amin,Amax)*cos(2*pi*tt - racro()),nrow=length(tt))+
                                           L%*%matrix(rnorm(length(tt)),nrow=length(tt))) }
get_noise_matrix = function(n,eig_min,eig_max){
  qr   = matrix(rnorm(n*n),n) |> qr()
  Q    = qr.Q(qr)
  R    = qr.R(qr)
  Q    = Q%*%diag(sign(diag(R)))
  eigs = runif(n,eig_min,eig_max)
  M    = t(Q)%*%diag(eigs)%*%Q
  L    = chol(M)
  return(L)
}

nrep = 5e2
pars = expand.grid(
  sampling    = c( rep("random",nrep),rep("equispaced",nrep)),
  Amps        = c(1,2,3),
  eigs        = c(1,2,3),
  stringsAsFactors = FALSE
)

df = lapply(seq_len(nrow(pars)), function(ii) {
  sampling = pars$sampling[ii]
  eig_max  = pars$eigs[ii]
  Amp      = pars$Amps[ii]
  if (sampling=='equispaced'){
    tt   = (0:n)/n
    tt   = tt[1:n]
  }else{
    tt = runif(n)
  }
  L      = get_noise_matrix(n,1,eig_max)
  Xsig   = replicate(Nsamp/2,{sim_model(tt,L,Amp,Amp)}) |> t()
  Xnoise = replicate(Nsamp/2,{sim_noise2(tt,L)}) |> t()
  X      = rbind(Xsig,Xnoise)
  resp   = c(rep(1,Nsamp/2),rep(0,Nsamp/2))
  pval   = matrixTests::row_cosinor(X,tt,period=1)$pvalue
  x      = data.frame(pval=pval,
                          resp=resp)
  rr         = pROC::roc(x,resp,pval)
  fpr=1-rr$specificities
  tpr=rr$sensitivities
  fpr_approx  = seq(0,1,length.out=1e3)
  tpr_approx  = approx(fpr,tpr,fpr_approx)$y
  res        = data.frame(fpr=fpr_approx,tpr=tpr_approx,Amp=Amp,eig_max=eig_max,
                          sampling=sampling,idx=ii)
  return(res)
}) |> rbindlist() |> data.frame()
df |> head()
df$sampling <- factor(df$sampling, levels = c("random", "equispaced"))
# Compute mean
df_mean <- df |>
  group_by(sampling, fpr,Amp,eig_max) |>
  summarise(
    tpr_mean = mean(tpr),
    tpr_lower = quantile(tpr, 0.25),
    tpr_upper = quantile(tpr, 0.75),
    .groups = "drop"
  )

dfb =df_mean
saveRDS(dfb,'df_robustB.RDS')
#pb = df_mean |>
#  ggplot(aes(x=fpr,y=tpr_mean,group=sampling,color=sampling))+geom_line()+
#  geom_ribbon(aes(ymin = tpr_lower, ymax = tpr_upper), alpha = 0.2, color = NA)+
#  facet_grid(Amp~eig_max)



