exhaustiveSearch = function(N,Nfine=48,wlen,wdensity=1,
                            freq=1,db_fname=NULL,returnType='optimal'){

  # call C function to generate database
  if (is.null(db_fname)){
    command = paste("c_src/necklaces_cmd 2", Nfine, "2", N, ">",
      paste0("temp/cNecks_", Nfine, "_", N, ".txt"))
    db_fname = paste0("temp/cNecks_", Nfine, "_", N, ".txt")
    system(command)
  }

  # filter database
  filt_cmd = paste('awk -f "c_src/necklace_filt.awk" ',wlen,wdensity,Nfine,db_fname)
  system(filt_cmd)

  # read database into memory
  files=list.files(pattern = "output_\\d+\\.txt")
  df=files %>% lapply(function(file){
    lines = readLines(file)
    md    = do.call(rbind, strsplit(lines, split = ""))
    md    = apply(md, 2, as.numeric)
    md    = md %>% matrix(ncol=Nfine) %>% as.data.frame()
  }) %>% rbindlist()
  file.remove(files) # clean up output of awk filtering

  # based on returnType find optimal design or return all designs
  tau = c(1:Nfine)/Nfine-1/Nfine
  if (returnType=='optimal'){
    best_idx = df %>% apply(1,function(x){
     bv = x %>% as.numeric()
      return(evalMinEig(tau[bv>0],freq=freq))
    }) %>% which.max()
    return(df[best_idx,])
  }else if(returnType=='all'){
    return(df)
  }else{
    stop('unknown returnType')
  }
}
