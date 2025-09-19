# for creating a multi-panel figure summarizing our analysis of the free period model
# --------
# Panel A
# --------
require(ggplot2)
require(dplyr)
source('clean_theme.R')
require(patchwork)
df1  = read.csv('MATLAB/pr_relic/figs_relic/data/results_prF1a_equi_1.csv',header=F)
df2  = read.csv('MATLAB/pr_relic/figs_relic/data/results_prF1a_equi_2.csv',header=F)
df3  = read.csv('MATLAB/pr_relic/figs_relic/data/results_prF1a_equi_3.csv',header=F)
#df1b = read.csv('MATLAB/peer_review/figures/data/results_prF1a_equi48_1.csv',header=F)
#df2b = read.csv('MATLAB/peer_review/figures/data/results_prF1a_equi48_2.csv',header=F)
#df3b = read.csv('MATLAB/peer_review/figures/data/results_prF1a_equi48_3.csv',header=F)
df = rbind(df1,df2,df3)
names(df) = c('Nmeas','fmin','fmax','Amp','acro','freq','pfree','pfixed')


df$fmax = factor(df$fmax, levels = c(3,4,6),
                 labels = c(expression(f[max]==N/4),
                            expression(f[max]==N/3),
                            expression(f[max]==N/2)))
p_a= df |> ggplot(aes(x=pfixed,y=pfree,color=freq))+geom_point(size=.3)+
  facet_wrap(~fmax,labeller=label_parsed)+  scale_color_viridis_c(limits=c(1,6),
                        name   = "frequency",  # legend title
                        )+clean_theme()+labs(x='fixed period power',y='free period power')
p_a

# --------
# Panel B
# --------
dfb = read.csv('MATLAB/pr_relic/figs_relic/data/results_prF1b_equi.csv',header=F)
names(dfb) = c('Nmeas','fmin','fmax','Amp','acro','freq','pfree','pfixed')
dfb$fmax_harm = dfb$fmax/dfb$Nmeas

dfb = dfb |> filter(freq<fmax)
dfb_summary <- dfb |>
  group_by( Amp, fmax_harm,fmax) |>
  summarise(
    mean_val = mean(abs(pfixed - pfree), na.rm = TRUE),
    lower    = quantile(pfixed - pfree, 0.25, na.rm = TRUE),
    upper    = quantile(pfixed - pfree, 0.75, na.rm = TRUE),
    .groups = "drop"
  )
dfb_summary$fmax = factor(dfb_summary$fmax, levels = c(3,4,6),
                 labels = c(expression(f[max]==N/4),
                            expression(f[max]==N/3),
                            expression(f[max]==N/2)))
p_b = dfb_summary |>
  ggplot(aes(x = Amp, y = mean_val )) +
  geom_line() +
  geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.1) +
  facet_wrap(~fmax,labeller=label_parsed) +
  scale_color_viridis_c(limits=c(1,6),
                        name   = "frequency",  # legend title
                        )+clean_theme()+labs(x='amplitude',y='power difference')
p_b

# --------
# Panel C
# --------
df  = read.csv('figures/data/prF1c_n48_Amp1_modereal.csv',
               header=F)
freqs = seq(1,24,length.out=32)
df1 = data.frame(power  = df[,1],
                 freq   = freqs,
                 design = 'equispaced')
df2 = data.frame(power  = df[,2],
                 freq   = freqs,
                 design = 'WCP')

df = rbind(df1,df2)
p_c = df |> ggplot(aes(x=freq,y=power,group=design,color=design))+geom_point()+geom_line()+
  clean_theme()+labs(color=NULL,x='frequency')
p_c

Fig = ((p_a/p_b)|p_c) + plot_annotation(tag_levels='A')+
  plot_layout(widths=c(2,1),guides='collect')&theme(legend.position='bottom')
Fig
ggsave('figures/pr_fig_approx.png',
       Fig,
       width=6,height=4,
       device='png',
       dpi=600)
