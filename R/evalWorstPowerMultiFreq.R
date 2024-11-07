#' Evaluate worst-case power across multiple frequencies
#'
#' @description
#' For a given amplitude, return the lowest value of the power across all
#' acrophases and range of frequencies.
#'
#' @param t vector of measurement times, same units as \code{param$fmin} and \code{param$fmax}
#' @param Amp amplitude of signal
#' @param fmin minimum frequency under consideration, same units as \code{t}
#' @param fmax maximum frequency under consideration, same units as \code{t}
#' @param Nfreq number of frequencies to use in discretization
#' @param alpha type I error rate, by default \code{alpha=0.05}
#' @param returnType either \code{'min'} which returns the worst-case power across frequency and acrophase
#TODO: explain design
#' or \code{'all'} which returns the worst case power of each frequency
#'
#' @return minimum power across acrophase and frequency range
#' @author Turner Silverthorne
#' @export
evalWorstPowerMultiFreq=function(mt,Amp,fmin,fmax,Nfreq,alpha=.05,
                                 returnType=c('min','all'),design=c('general','equispaced')){
  freqs = seq(from=fmin,to=fmax,length.out=Nfreq)
  returnType=match.arg(returnType)

  worst_pwrs=freqs |> sapply(function(freq){
    evalWorstPower(mt,Amp=Amp,freq=freq,alpha,'eig',design)
  })

  if (returnType=='min'){
    return(min(unlist(worst_pwrs)))
  }else if(returnType=='all'){
    return(unlist(worst_pwrs))
  }
}
