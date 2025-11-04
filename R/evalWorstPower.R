#' Evaluate worst-case power
#'
#' @description
#' For a given frequency and amplitude, returns the lowest value of the power across all acrophases.
#'
#' @param t vector of measurement times in same units as \code{param$freq}
#' @param freq frequency of signal in same units as \code{t}
#' @param Amp amplitude of signal
#' @param alpha type I error rate, by default \code{alpha=0.05}
#' @param method by default \code{method='eig'} uses eigenvalue method for computing the worstcase noncentrality parameter
#' @param design by default \code{design='general'} uses the general power formula. If you are interested in seeing
#' the discrepancy between the general formula and equispaced formula, use \code{design='equispaced'}.
#' @return minimum power
#'
#' @note User can change method to \code{method='test'} to instead compute minimum power by discretising
#' the acrophase and searching for minimum. This will be slower and less accurate than the default so we
#' do not recommend using this unless the user is writing their own unit tests and wants to compare
#' \code{method='eig'} to an alternative method.
#' @author Turner Silverthorne
#' @export
#'
#' @examples
#' # Worst-case power for a study with equispaced 24 timepoints
#' evalWorstPower(mt=1:24,param=list(Amp=1,freq=1/24))
evalWorstPower=function(mt,freq,Amp,alpha=.05,method=c('eig','test'),
                        design=c('general','equispaced')){
  N      = length(t)
  method = match.arg(method)
  design = match.arg(design)
  if (length(freq)>1){
    stop('Use evalWorstPowerMutliFreq for handling multiple frequencies')
  }
  if (method=='eig'){
    mineig  = evalMinEig(mt,freq,design)
    ncp     = mineig |> (\(x){x*Amp^2})()
    min_pwr = evalPower(mt,freq,Amp,acro=NaN,method='ncp',lambda_in=ncp,alpha=alpha)
    min_pwr
  }else if(method=='test'){
    Nacro = 2^15
    acro = seq(0,2*pi,length.out=Nacro+1)
    acro = acro[1:Nacro]
    min_pwr= acro |> sapply(function(phi){
      return(evalPower(mt,Amp=Amp,freq=freq,acro=phi,alpha=alpha))
    }) |> min()
    min_pwr
  }
  return(min_pwr)
}
