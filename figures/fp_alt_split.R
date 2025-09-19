# version of power comparison figure where we split in the way Matt suggested
require(ggplot2)
df = read.csv('figures/data/mres_freePeriodSweep_light_n12.csv',F)
names(df) <- c('Amp','freq','acro','pwrFtest','pwrFree')

df |> ggplot(aes(x=pwrFtest,y=pwrFree,color=acro))+geom_point(size=.5)+
  facet_grid(freq~Amp)+scale_color_viridis_c()
