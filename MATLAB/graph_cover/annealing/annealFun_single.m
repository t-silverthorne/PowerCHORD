function xnew = annealFun_single(x,thresh)
    x.Pvec   = tFun_single(x.Pvec);
    x.alpha1 = sFun_single(x.alpha1,thresh);
    x.alpha2 = sFun_single(x.alpha2,thresh);
    x.D1     = get_chain_dist(x.n1,x.T1, ...
                    x.m1,x.alpha1,false);
    x.D2     = get_chain_dist(x.n2,x.T2, ...
                    x.m2,x.alpha2,false);
    xnew     = x;
end