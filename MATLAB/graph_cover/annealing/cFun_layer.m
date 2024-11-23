function J = cFun_layer(Pcell,Dmats,Tvec)
J=0;
for ii=1:length(Pcell)
    J = J + cFun_single(Pcell{ii},Dmats{ii},Dmats{ii+1},Tvec(ii));
end
end

