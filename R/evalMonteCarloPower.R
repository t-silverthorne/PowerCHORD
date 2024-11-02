#'Use Monte Carlo method to estimate power
#'
#' @description
#' Performs harmonic regression on a simulated dataset of independent samples
#' and returns the portion of samples that have statistically significant p-values.
#' Useful for comparison with the exact expression for statistical power,
#' see [evalExactPower()].
#'
#' @param tvec vector of measurement times in same units as \code{param$freq}
#' @param freq frequency fo signal in same units as \code{t}
#' @param acro phase of signal in radians
#' @param Amp amplitude of signal
#' @param Nmc number of Monte Carlo samples
#' @param alpha type I error, default value \code{alpha=.05}
#'
#' @return Monte Carlo estimate of power
#' @author Turner Silverthorne
#' @export
evalMonteCarloPower<-function(tvec,freq,acro,Amp,Nmc,alpha=.05){
  Ydat = t(replicate(Nmc,{Amp*cos(2*pi*freq*tvec -acro) + rnorm(length(tvec))}))
  pwr  = mean(matrixTests::row_cosinor(Ydat,tvec,1/freq)$pvalue < alpha)
  return(pwr)
}
