# clean version of the free period multi-panel figure
require(ggplot2)
df = read.csv('figures/mres_freePeriodSweep_light_n12.csv',F)
names(df) <- c('Amp','freq','acro','pwrFtest','pwrFree')

df |> ggplot(aes(x=pwrFtest,y=pwrFree,color=acro))+geom_point(size=.5)+
  facet_grid(freq~Amp,scales='free')+scale_color_viridis_c()
