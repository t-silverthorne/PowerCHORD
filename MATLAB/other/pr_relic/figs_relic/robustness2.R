# check how equispaced vs random designs perform for signals that violate model assumptions
require(devtools)
require(ggplot2)
require(data.table)
load_all()

n    = 12
tt   = (0:n)/n
tt   = tt[1:n]

Nsamp = 1e3

Amin = 1
Amax = 2
racro = function(){runif(1,0,2*pi)}
rAmp  = function(){runif(1,Amin,Amax)}
sim_noise             = function(tt){rnorm(length(tt))}
sim_cosinor           = function(tt){rAmp()*cos(2*pi*tt - racro())+rnorm(length(tt))}
sim_cosinor_osc_amp   = function(tt){(  (1+runif(1,0,.95)*cos(2*pi*tt-racro()))*rAmp()  )*cos(2*pi*tt - racro())+rnorm(length(tt))}
sim_cosinor_osc_phase = function(tt){rAmp()*cos(2*pi*tt - racro()*(1+runif(1,0,pi)*(cos(2*pi*tt-racro()))))+rnorm(length(tt))}
sim_cosinor_osc_noise = function(tt){rAmp()*cos(2*pi*tt - racro())+rnorm(length(tt))*(1+rAmp()*cos(2*pi*tt - racro()))}

methods = list(
  sim_cosinor         = sim_cosinor,
  sim_cosinor_osc_amp = sim_cosinor_osc_amp,
  sim_cosinor_osc_phase = sim_cosinor_osc_phase,
  sim_cosinor_osc_noise = sim_cosinor_osc_noise
)

pars = expand.grid(
  method_name = names(methods),
  sampling    = c( rep("random",1e1),"equispaced"),
  kharm       = c(1,2),
  stringsAsFactors = FALSE
)
df = lapply(seq_len(nrow(pars)), function(ii) {
  mname      = pars$method_name[ii]
  sampling   = pars$sampling[ii]
  kharm      = pars$kharm[ii]
  sim_method = methods[[mname]]

  if (sampling=='equispaced'){
    tt   = (0:n)/n
    tt   = tt[1:n]
  }else{
    tt = runif(n)
  }
  Xsig       = replicate(Nsamp/2,{sim_method(tt)}) |> t()
  Xnoise     = replicate(Nsamp/2,{sim_noise(tt)}) |> t()
  X          = rbind(Xsig,Xnoise)
  resp       = c(rep(1,Nsamp/2),rep(0,Nsamp/2))
  if (kharm==1){
    pval       = matrixTests::row_cosinor(X,tt,period=1)$pvalue
  }else{
    Xdesign    = matrix(1,nrow=length(tt),ncol=1)
    for (kk in 1:kharm){
     Xdesign = cbind(Xdesign,cos(2*pi*kk*tt),sin(2*pi*kk*tt))
    }
    pval = apply(X, 1, function(xrow) {
      fit  = lm(xrow ~ X_design - 1)       # '-1' because X_design already includes intercept
      anova(fit)[1,5]
    })
  }
  x          = data.frame(pval=pval,
                     resp=resp)
  rr         = pROC::roc(x,resp,pval)
  res        = data.frame(fpr=1-rr$specificities,tpr=rr$sensitivities,method=mname,sampling=sampling,idx=ii,kharm=kharm)
  return(res)
}) |> rbindlist() |> data.frame()
df |> head()
df$sampling <- factor(df$sampling, levels = c("random", "equispaced"))

df |> ggplot(aes(x=fpr,y=tpr,group=idx,color=sampling))+geom_line()+facet_grid(kharm~method)
