#' Get worst eigenvalue across multiple frequencies
#'
#' @description
#' Wrapper for the function [evalMinEig()], computes worst eigenvalue of the power
#' matrix across multiple frequencies.
#'
#' @param t vector of measurement times, same units as \code{freq}
#' @param fmin minium frequency, same units as \code{t}
#' @param fmax maximum frequency, same units as \code{t}
#' @param Nfreq number of points to use for discretising \code{[fmin,fmax]} interval
#' @param alpha type I error rate, by default \code{alpha=0.05}
#'
#' @return minimum eigenvalue of the power matrix across the interval \code{[fmin,fmax]}
#'
#' @author Turner Silverthorne
#' @export
evalMinEigMultiFreq=function(mt,fmin,fmax,Nfreq,alpha=.05){
  freqs = seq(from=fmin,to=fmax,length.out=Nfreq)

  min_eigs=freqs |> sapply(function(freq){
    evalMinEig(mt,freq)
  })
  min(unlist(min_eigs))
}
