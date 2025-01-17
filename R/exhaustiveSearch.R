#'Search all possible (discrete-time) designs to find optimal power
#'
#' @description
#' There are only finitely many designs to consider if measurements are confined
#' to a discrete grid. Many designs will be equivalent up to temporal translation,
#' so only one representative of each equivalence class needs to be considered. This function
#' generates one representative from each equivalence class.
#'
#' @param N number of measurements to be collected, aka sample size
#' @param Nfine number of points in the discrete grid
#' @param wlen length of the low-measurement window
#' @param wdensity number of measurements allowed in low-measurement window
#' @param freq frequency of signal
#' @param returnType if \code{returnType='optimal'} only the optimal solution is returned,
#' if \code{returnType='all'} then a dataframe containing one representative of each equivalence class
#' consistent with the timing constraint will be returned
#' @param flines number of lines to include in each awk output file.
#'
#' @return  either the optimal solution consistent with the timing constraints, or a dataframe
#' containing all solutions consistent with timing constraints (see \code{returnType}).
#'
#' @note
#' This function generates the database of designs using the [C library](http://combos.org/index)
#' and then filters this library using the \code{awk} script \code{c_src/necklace_filt.awk}.
#'
#' @author Turner Silverthorne
#' @export

exhaustiveSearch = function(N,Nfine=48,wlen,wdensity=1,
                            freq=1,returnType=c('optimal','all'),
                            flines=1e6){
  returnType=match.arg(returnType)
  # Check for correct setup
  if(!file.exists("c_src/necklaces_cmd.c")) stop("The working directory must be set to the PowerCHORD root directory for exhaustiveSearch usage")
  if(!file.exists("c_src/necklaces_cmd")) stop("Exhaustive seach exe not found, see documentation for exhaustiveSearch usage")

  prev_output = Sys.glob("output_*.txt")
  if (length(prev_output)>0){
    system('rm output_*.txt')
  }

  command = paste("c_src/necklaces_cmd 2", Nfine, "2 NA", N,
                  " | awk",
                  "-v",paste0("width=",wlen),
                  "-v",paste0("density=",wdensity),
                  "-v",paste0("nfine=",Nfine),
                  "-v",paste0("flines=",flines),
                  "-f c_src/neckfilt.awk")
  system(command)

  # read database into memory
  files=list.files(pattern = "output_\\d+\\.txt")
  df=files |> lapply(function(file){
    lines = readLines(file)
    md    = do.call(rbind, strsplit(lines, split = ""))
    md    = apply(md, 2, as.numeric)
    md    = md |> matrix(ncol=Nfine) |> as.data.frame()
  }) |> (\(x){do.call("rbind", x)})() #replaces data.table::rbindlist()
  file.remove(files) # clean up output of awk filtering

  # based on returnType find optimal design or return all designs
  tau = c(1:Nfine)/Nfine-1/Nfine

  if (returnType=='optimal'){
    best_idx = df |> apply(1,function(x){
     bv = x |> as.numeric()
      return(evalMinEig(tau[bv>0],freq=freq))
    }) |> which.max()
    return(df[best_idx,])
  }else if(returnType=='all'){
    return(df)
  }
}
