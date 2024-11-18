function x = annealFun_layer(x,thresh)
nLayer=length(x.Dmats);
update_all=false;
if update_all
    x.Pcell = tFun_layer(x.Pcell);
    x.alpha = sFun_layer(x.alpha,thresh);
    for ii=1:nLayer
        x.Dmats{ii} = get_chain_dist(x.nvec(ii),x.Tvec(ii),x.mvec(ii), ...
                                     x.alpha{ii},false);
    end
else
    ii = randsample(1:(nLayer-1),1); % nothing to do on last layer
    x.Pcell{ii} = tFun_single(x.Pcell{ii});
    x.alpha{ii} = sFun_single(x.alpha{ii},thresh);
    x.Dmats{ii} = get_chain_dist(x.nvec(ii),x.Tvec(ii),x.mvec(ii), ...
                                 x.alpha{ii},false);
end
end

