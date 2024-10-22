#' Get worst eigenvalue across multiple frequencies
#'
#' @description
#' Wrapper for the function [evalMinEig()], computes worst eigenvalue of the power
#' matrix across multiple frequencies.
#'
#' @param t vector of measurement times assumed to lie in interval [0,1]
#' @param param$fmin minium frequency
#' @param param$fmax maximum frequency
#' @param param$Nfreq number of points to use for discretising \code{[fmin,fmax]} interval
#' @param alpha type I error rate, by default \code{alpha=0.05}
#'
#' @return minimum eigenvalue of the power matrix across the interval \code{[fmin,fmax]}
#'
#' @author Turner Silverthorne
#' @export
evalMinEigMultiFreq=function(mt,param,alpha=.05){
  fmin  = param[['fmin']]
  fmax  = param[['fmax']]
  Nfreq = param[['Nfreq']]

  freqs = seq(from=fmin,to=fmax,length.out=Nfreq)

  min_eigs=freqs %>% sapply(function(freq){
    evalMinEig(mt,freq)
  })
  min(unlist(min_eigs))
}
