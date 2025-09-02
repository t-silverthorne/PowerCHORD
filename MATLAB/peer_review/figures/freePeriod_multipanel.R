# for creating a multi-panel figure summarizing our analysis of the free period model

# --------
# Panel A
# --------
require(ggplot2)
df = read.csv('MATLAB/peer_review/figures/data/results_F2_equispaced.csv',header=F)
names(df) = c('Nmeas','fmin','fmax','Amp','acro','freq','pfree','pfixed')


df |> head()
df$fmax_harm = df$fmax/df$Nmeas
df |> ggplot(aes(x=pfixed,y=pfree,color=Amp))+geom_point(size=.5)+
  facet_grid(Nmeas~fmax_harm)



# --------
# Panel C
# --------
