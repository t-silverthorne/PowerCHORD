#' Evaluate smallest eigenvalue of power matrix.
#'
#' @description
#' Returns the smallest eigenvalue of the power matrix B^{-1} = (H (X^TX)^{-1} H^T)^{-1}. This eigenvalue is
#' equal to worst-case value of the noncentrality parameter across all signals with amplitude A=1
#' and noise strength sigma=1.
#'
#' @param t vector of measurement times in same units as \code{freq}
#' @param freq frequency of signal in same units as \code{t}
#TODO: fill in this
#' @param design either \code{general} or \code{equispaced}
#' @return minimum eigenvalue of the power matrix
#'
#' @note To calculate worst eigenvalue across multiple frequencies and acrophases,
#' use the wrapper function [evalMinEigMultiFreq()]
#' @author Turner Silverthorne
#' @export
evalMinEig <- function(t,freq,design=c('general','equispaced')){
  design=match.arg(design)
  if (design=='equispaced' &(freq %% length(t)/2)==0){
    mineig = 0
  }else{
    Xr     = matrix(c(cos(2*pi*freq*t),sin(2*pi*freq*t)),ncol=2)
    D      = t(Xr)%*%Xr
    b      = matrix(c(sum(cos(2*pi*freq*t)),sum(sin(2*pi*freq*t))),ncol=1)
    invB   = D - b%*%t(b)/length(t)
    mineig = eigen(invB) |> (\(x) x$values)() |> min()
  }
  return(mineig)
}
