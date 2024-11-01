#'Use Monte Carlo method to estimate power
#'
#' @description
#' Performs harmonic regression on a simulated dataset of independent samples
#' and returns the portion of samples that have statistically significant p-values.
#' Useful for comparison with the exact expression for statistical power,
#' see [evalExactPower()].
#'
#' @param tvec vector of measurement times
#' @param param$Amp amplitude of signal
#' @param param$freq frequency fo signal
#' @param param$acro phase of signal in radians
#' @param Nmc number of Monte Carlo samples
#' @param alpha type I error, default value \code{alpha=.05}
#' @param method set to \code{method='Ftest'} for F-test or \code{method='perm'} for
#' permutation based hypothesis test
#' @param Nperm number of permutations to use for permutation based test
#'
#' @return Monte Carlo estimate of power
#' @author Turner Silverthorne
#' @export
evalMonteCarloPower<-function(tvec,param,Nmc,alpha=.05,method=c('Ftest','perm'),Nperm=1e2){
  method = match.arg(method)

  Amp  = param$Amp
  freq = param$freq
  acro = param$acro
  Ydat = t(replicate(Nmc,{Amp*cos(2*pi*freq*tvec -acro) + rnorm(length(tvec))}))
  if (method=='Ftest'){
    pwr  = mean(matrixTests::row_cosinor(Ydat,tvec,1/freq)$pvalue < alpha)
  }else if(method=='perm'){
    #stop('perm not implemented')
    pvec_true = matrixTests::row_cosinor(Ydat,tvec,1/freq)$pvalue
    perm_mat  = matrix(rep(NaN,Nmc*Nperm),nrow=Nmc,ncol = Nperm)
    for (perm in c(1:Nperm)){
      Pdat = matrix(rep(NaN,Nmc*length(tvec)),nrow=Nmc,ncol = length(tvec))
      for (ii in c(1:Nmc)){
        Pdat[ii,] = Ydat[ii,sample(1:length(tvec))]
      }
      perm_mat[,perm]=matrixTests::row_cosinor(Pdat,tvec,1/freq)$pvalue
    }
    pmat_true = replicate(Nperm,pvec_true)
    perm_mat < pmat_true
    R = rowSums(perm_mat<pmat_true)
    pwr =mean((R+1)/(Nperm+1) < alpha)
  }
  return(pwr)
}
