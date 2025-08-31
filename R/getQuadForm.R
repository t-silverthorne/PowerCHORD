getQuadForm = function(tt, freqs) {
  H = matrix(c(0,1,0, 0,0,1), nrow = 2, byrow = TRUE)
  n = length(tt)
  m = length(freqs)

  Qlist = lapply(freqs, function(f) {
    X = cbind(1, cos(2*pi*f*tt), sin(2*pi*f*tt))  # n x 3
    # MATLAB  (X'X)\X' -> solve(crossprod(X), t(X))
    Q = solve(crossprod(X), t(X))  # 3 x n
    Q = H %*% Q                    # 2 x n
    return(Q)
  })

  Qf_list = lapply(Qlist, function(Q) t(Q) %*% Q)  # n x n each
  Qf = unlist(Qf_list) |> array(c(n,n,m))          # keep all
  Q  = Reduce("+", Qf_list) / m                    # mean over freqs

  return(list(Q = Q, Qf = Qf))
}
