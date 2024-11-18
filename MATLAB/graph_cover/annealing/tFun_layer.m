function Pcell = tFun_layer(Pcell)
for ii=1:length(Pcell)
    Pcell{ii} = tFun_single(Pcell{ii});
end
end

