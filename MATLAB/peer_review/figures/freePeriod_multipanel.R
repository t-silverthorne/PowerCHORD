# for creating a multi-panel figure summarizing our analysis of the free period model

# --------
# Panel A
# --------
require(ggplot2)
require(dplyr)
df1 = read.csv('MATLAB/peer_review/figures/data/results_prF1a_equi_1.csv',header=F)
df2 = read.csv('MATLAB/peer_review/figures/data/results_prF1a_equi_2.csv',header=F)
#df3 = read.csv('MATLAB/peer_review/figures/data/results_prF1a_equi_3.csv',header=F)
df3=NULL
df = rbind(df1,df2,df3)
names(df) = c('Nmeas','fmin','fmax','Amp','acro','freq','pfree','pfixed')


df |> head()
df$fmax_harm = df$fmax/df$Nmeas
p_a= df |> ggplot(aes(x=pfixed,y=pfree,color=Amp))+geom_point(size=.5)+
  facet_grid(Nmeas~fmax_harm)+scale_color_viridis_c()

# --------
# Panel B
# --------
dfb = read.csv('MATLAB/peer_review/figures/data/results_prF1b_equi.csv',header=F)
names(dfb) = c('Nmeas','fmin','fmax','Amp','acro','freq','pfree','pfixed')
dfb$fmax_harm = dfb$fmax/dfb$Nmeas


dfb_summary <- dfb |>
  group_by(freq, Amp, fmax_harm,fmax) |>
  summarise(
    mean_val = mean(pfixed - pfree, na.rm = TRUE),
    lower    = quantile(pfixed - pfree, 0.25, na.rm = TRUE),
    upper    = quantile(pfixed - pfree, 0.75, na.rm = TRUE),
    .groups = "drop"
  )

p_b = dfb_summary |>filter(freq<fmax) |>
  ggplot(aes(x = Amp, y = mean_val, group = freq, color = freq)) +
  geom_line() +
  geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.1) +
  facet_wrap(~fmax_harm) +
  scale_color_viridis_c()+clean_theme()
# --------
# Panel C
# --------
source('figures/clean_theme.R')
require(patchwork)
p_a/p_b + plot_annotation(tag_levels='A')
