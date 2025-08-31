fastMCTinfpower = function(Q, x, Nperm, alpha=0.05) {
  # Q: n × n × n3_Q
  # x: n × n2 × n3 × n4
  # Nperm: number of permutations
  # alpha: significance level
  sz        = dim(x)
  n         = sz[1]
  nTrailing = prod(sz[-1])
  n3_Q      = dim(Q)[3]

  # flatten trailing dims for fast BLAS
  x_flat = matrix(x, nrow = n, ncol = nTrailing)

  # ---- observed test statistic ----
  Tobs_vec = rep(-Inf, nTrailing)
  for (k in seq_len(n3_Q)) {
    Qx = Q[,,k] %*% x_flat
    Tobs_vec = pmax(Tobs_vec, colSums(x_flat * Qx))
  }
  # reshape back to trailing dims
  Tobs = array(Tobs_vec, dim = sz[-1])

  count = array(0, dim = dim(Tobs))
  for (pp in seq_len(Nperm)) {
    # permute rows independently for each trailing column
    perms = replicate(nTrailing, sample.int(n), simplify = TRUE)
    idx   = perms + rep((0:(nTrailing-1))*n, each = n)
    xfp   = x_flat[idx]
    xfp   = matrix(xfp, nrow = n, ncol = nTrailing)

    Tperm_vec = rep(-Inf, nTrailing)
    for (k in seq_len(n3_Q)) {
      Qx = Q[,,k] %*% xfp
      Tperm_vec = pmax(Tperm_vec, colSums(xfp * Qx))
    }
    Tperm = array(Tperm_vec, dim = sz[-1])
    count = count + (Tperm > Tobs)
  }
  count   = count/Nperm
  count   = count < alpha
  pwr_est = apply(count,seq_along(dim(count))[-1],mean)
  pwr_vec = pwr_est |> as.vector()
  #pwr_vec = aperm(pwr_est,rev(seq_along(dim(pwr_est)))) |> as.vector()
  return(list(pwr_est=pwr_est,pwr_vec=pwr_vec))
}
c
