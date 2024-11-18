function alpha = sFun_layer(alpha,thresh)
for ii=1:length(alpha)
    alpha{ii} = sFun_single(alpha{ii},thresh);
end
end

