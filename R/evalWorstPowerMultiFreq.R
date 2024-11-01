#' Evaluate worst-case power across multiple frequencies
#'
#' @description
#' For a given amplitude, return the lowest value of the power across all
#' acrophases and range of frequencies.
#'
#' @param t vector of measurement times assumed to lie in interval [0,1]
#' @param param$Amp amplitude of signal
#' @param param$fmin minimum frequency under consideration
#' @param param$fmax maximum frequency under consideration
#' @param alpha type I error rate, by default \code{alpha=0.05}
#' @param returnType either \code{'min'} which returns the worst-case power across frequency and acrophase
#' or \code{'all'} which returns the worst case power of each frequency
#'
#' @return minimum power across acrophase and frequency range
#' @author Turner Silverthorne
#' @export
evalWorstPowerMultiFreq=function(mt,param,alpha=.05,returnType=c('min','all')){
  Amp   = param[['Amp']]
  fmin  = param[['fmin']]
  fmax  = param[['fmax']]
  Nfreq = param[['Nfreq']]

  freqs = seq(from=fmin,to=fmax,length.out=Nfreq)

  returnType=match.arg(returnType)

  worst_pwrs=freqs %>% sapply(function(freq){
    ploc=list(Amp=Amp,freq=freq)
    evalWorstPower(mt,ploc,alpha,'eig')
  })

  if (returnType=='min'){
    return(min(unlist(worst_pwrs)))
  }else if(returnType=='all'){
    return(unlist(worst_pwrs))
  }
}
