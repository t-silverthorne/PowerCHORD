# check how equispaced vs random designs perform for signals that violate model assumptions
require(devtools)
require(ggplot2)
require(data.table)
load_all()

n    = 12
tt   = (0:n)/n
tt   = tt[1:n]

Nsamp = 1e4

Amin = 1
Amax = 3
racro = function(){runif(1,0,2*pi)}
rAmp  = function(){runif(1,Amin,Amax)}
sim_noise             = function(tt){rnorm(length(tt))}
sim_osc_noise         = function(tt){rnorm(length(tt))*(1+rAmp()*cos(2*pi*tt - racro()))}
sim_cosinor           = function(tt){rAmp()*cos(2*pi*tt - racro())+rnorm(length(tt))}
sim_cosinor_osc_amp   = function(tt){(  (1+runif(1,0,.95)*cos(2*pi*tt-racro()))*rAmp()  )*cos(2*pi*tt - racro())+rnorm(length(tt))}
sim_cosinor_osc_phase = function(tt){rAmp()*cos(2*pi*tt - racro()*(1+runif(1,0,pi)*(cos(2*pi*tt-racro()))))+rnorm(length(tt))}
sim_cosinor_osc_noise = function(tt){rAmp()*cos(2*pi*tt - racro())+rnorm(length(tt))*(1+rAmp()*cos(2*pi*tt - racro()))}
sim_square_wave       = function(tt){rAmp()*ifelse((tt-racro())%%1<.5,1,0)+rnorm(length(tt))}
sim_sqr_burst         = function(tt){rAmp()*ifelse((tt-racro())%%1<.25,1,0)+rnorm(length(tt))}

signal = sim_sqr_burst(tt_hd)
data.frame(time=tt_hd,signal=signal) |> ggplot(aes(x=time,y=signal))+geom_line()
methods = list(
  sim_cosinor           = sim_cosinor,
  sim_cosinor_osc_amp   = sim_cosinor_osc_amp,
  sim_cosinor_osc_phase = sim_cosinor_osc_phase,
  sim_cosinor_osc_noise = sim_cosinor_osc_noise,
  sim_square_wave       = sim_square_wave,
  sim_sqr_burst         = sim_sqr_burst
)

pars = expand.grid(
  method_name = names(methods),
  sampling    = c( rep("random",1e2),"equispaced"),
  stringsAsFactors = FALSE
)
df = lapply(seq_len(nrow(pars)), function(ii) {
  mname      = pars$method_name[ii]
  sampling   = pars$sampling[ii]
  sim_method = methods[[mname]]

  if (sampling=='equispaced'){
    tt   = (0:n)/n
    tt   = tt[1:n]
  }else{
    tt = runif(n)
  }
  if (mname=='sim_cosinor_osc_noise'){ # noise should also oscillate even in null
    Xnoise     = replicate(Nsamp/2,{sim_osc_noise(tt)}) |> t()
  }else{
    Xnoise     = replicate(Nsamp/2,{sim_noise(tt)}) |> t()
  }

  Xsig       = replicate(Nsamp/2,{sim_method(tt)}) |> t()
  X          = rbind(Xsig,Xnoise)
  resp       = c(rep(1,Nsamp/2),rep(0,Nsamp/2))
  pval       = matrixTests::row_cosinor(X,tt,period=1)$pvalue
  x          = data.frame(pval=pval,
                     resp=resp)
  rr         = pROC::roc(x,resp,pval)
  res        = data.frame(fpr=1-rr$specificities,tpr=rr$sensitivities,method=mname,sampling=sampling,idx=ii)
  return(res)
}) |> rbindlist() |> data.frame()
df |> head()
df$sampling <- factor(df$sampling, levels = c("random", "equispaced"))
df |> ggplot(aes(x=fpr,y=tpr,group=idx,color=sampling))+geom_line()+facet_wrap(~method)

#dfa =df
#saveRDS(dfa,'df_robustA.RDS')


