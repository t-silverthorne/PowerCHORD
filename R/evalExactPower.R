#' Evaluate exact power of cosinor model.
#'
#' @description
#' Returns exact power of one-frequency harmonic regression hypothesis test
#' using the cosinor model.
#'
#'
#' @param t vector of measurement times assumed to lie in interval [0,1]
#' @param param$Amp amplitude of signal
#' @param param$freq frequency of signal
#' @param param$acro phase of signal in radians
#' @param alpha type I error, by default \code{alpha=.05}
#' @param method method for computing non-centrality parameter, by default
#' \code{method='schur'} uses the Schur complement formula.
#' @param lambda_in allows user to specify the noncentrality parameter instead of
#' calculating it from parameters of the signal.
#'
#' @note
#' Assumes the noise has mean zero and a standard deviation of one.
#'
#' The default method of \code{method='schur'} should be sufficient for the vast
#' majority of use cases.   Alternative methods are as follows:
#' \code{'full'} which solves a linear system to obtain the noncentrality parameter,
#' \code{'ncp'} which lets user specify the noncentrality parameter, \code{'equispaced'} which uses
#' the power formula from \href{https://onlinelibrary.wiley.com/doi/full/10.1002/sim.9803}{Zong et al 2023},
#' which is only applicable for equispaced measurement times.
#'
#' @return Statistical power
#' @author Turner Silverthorne
#' @export
#'
#' @examples
#' # The power for a 24hr study sampled every hour, testing for p<0.05
#' evalExactPower(t=1:24,param=list(Amp=1,acro=0,freq=1/24))
#'
evalExactPower <- function(t,param,alpha=.05,method=c('schur','ncp','equispaced'),lambda_in=NULL){
# return power of one-frequency cosinor model

  # Input checks
  if(!all(sapply(param,length)==1)) stop("All param must be length 1 (one design/condition)")
  method=match.arg(method)

  Amp    = param[['Amp']]
  freq   = param[['freq']]
  acro   = param[['acro']]
  N      = length(t)

  if (!is.null(lambda_in)&method!='ncp'){
    stop("Change method to ncp if you want to manually specify noncentrality parameter")
  }
  if (method=='full'){
    A      = matrix(c(0,0,1,0,0,1),nrow=3,byrow=T)
    X      = matrix(c(rep(1,N),cos(2*pi*freq*t),sin(2*pi*freq*t)),ncol=3)
    B      = t(A)%*%solve(t(X)%*%X,A)
    beta   = matrix(c(Amp*cos(acro),Amp*sin(acro)),nrow=2)
    lambda = t(beta)%*%solve(B,beta)
  }else if (method=='schur'){
    A      = matrix(c(0,0,1,0,0,1),nrow=3,byrow=T)
    Xr     = matrix(c(cos(2*pi*freq*t),sin(2*pi*freq*t)),ncol=2)
    D      = t(Xr)%*%Xr
    b      = matrix(c(sum(cos(2*pi*freq*t)),sum(sin(2*pi*freq*t))),ncol=1)
    invB   = D - b%*%t(b)/N
    beta   = matrix(c(Amp*cos(acro),Amp*sin(acro)),nrow=2)
    lambda = t(beta)%*%invB%*%beta
  }else if (method=='ncp'){
    lambda = lambda_in
  }else if (method=='equispaced'){
    cvec   = Amp*cos(2*pi*freq*t-acro)
    lambda = as.numeric(t(cvec)%*%cvec)
  }

  f0     = qf(p=1-alpha,df1=2,df2=N-3)
  return(1 - pf(q=f0,df1=2,df2=N-3,ncp=lambda))
}

