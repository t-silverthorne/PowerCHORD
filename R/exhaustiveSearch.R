exhaustiveSearch = function(N,Nfine=48,wlen,wdensity=1,
                            freq=1,db_fname=NULL,returnType=c('optimal','all'),
                            cleanTempDir=F){
  returnType=match.arg(returnType)
  # Check for correct setup
  if(!file.exists("c_src/necklaces_cmd.c")) stop("The working directory must be set to the PowerCHORD root directory for exhaustiveSearch usage")
  if(!file.exists("c_src/necklaces_cmd")) stop("Exhaustive seach exe not found, see documentation for exhaustiveSearch usage")

  prev_output = Sys.glob("output_*.txt")
  if (length(prev_output)>0){
    system('rm output_*.txt')
  }

  # call C function to generate database in R temp directory
  # TODO: should cleanup tmpdir after?
  if (is.null(db_fname)){
    dbdir=tempdir()
    command = paste("c_src/necklaces_cmd 2", Nfine, "2", N, ">",
      paste0(dbdir,"/cNecks_", Nfine, "_", N, ".txt"))
    db_fname = paste0(dbdir,"/cNecks_", Nfine, "_", N, ".txt")
    system(command)
  }

  # filter database
  filt_cmd = paste('awk -f "c_src/necklace_filt.awk" ',wlen,wdensity,Nfine,db_fname)
  system(filt_cmd)

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

  if (cleanTempDir){
    system(paste('rm',db_fname))
  }

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
