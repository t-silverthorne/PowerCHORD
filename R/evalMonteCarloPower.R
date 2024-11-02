#'Use Monte Carlo method to estimate power
#'
#' @description
#' Performs harmonic regression on a simulated dataset of independent samples
#' and returns the portion of samples that have statistically significant p-values.
#' Useful for comparison with the exact expression for statistical power,
#' see [evalExactPower()].
#'
#' @param tvec vector of measurement times in same units as \code{param$freq}
#' @param param$freq frequency fo signal in same units as \code{t}
#' @param param$Amp amplitude of signal
#' @param param$acro phase of signal in radians
#' @param Nmc number of Monte Carlo samples
#' @param alpha type I error, default value \code{alpha=.05}
#'
#' @return Monte Carlo estimate of power
#' @author Turner Silverthorne
#' @export
evalMonteCarloPower<-function(tvec,param,Nmc,alpha=.05){
  method = match.arg(method)

  Amp  = param$Amp
  freq = param$freq
  acro = param$acro
  Ydat = t(replicate(Nmc,{Amp*cos(2*pi*freq*tvec -acro) + rnorm(length(tvec))}))
  if (method=='Ftest'){
    pwr  = mean(matrixTests::row_cosinor(Ydat,tvec,1/freq)$pvalue < alpha)
  }
  return(pwr)
}
