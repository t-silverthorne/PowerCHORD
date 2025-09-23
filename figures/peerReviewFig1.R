# figure showing equispaced versus permutation bound designs
require(ggplot2)
source('clean_theme.R')
df1        = read.csv('figures/data/prF1c_n48_moderealhd.csv',F)
names(df1) = c('Amp','fmax','freq','power')
df1        = cbind(df1,data.frame(type='equispaced'))
df2        = read.csv('figures/data/prF1c_cheb_n48_moderealhd.csv',F)
names(df2) = c('Amp','fmax','freq','power')
df2        = cbind(df2,data.frame(type='irregular'))
df3        = read.csv('figures/data/prF1c_diffEv_n48_moderealhd.csv',F)
names(df3) = c('Amp','fmax','freq','power')
df3        = cbind(df3,data.frame(type='diffEv'))
df         = rbind(df1,df2,df3)
df$fmax = factor(df$fmax, levels = c(12,16,24),
            labels = c(expression(f[max]==N/4),
                       expression(f[max]==N/3),
                      expression(f[max]==N/2)))
df  = df |> filter(Amp>1)
df$Amp  = factor(df$Amp, levels = c(1, 1.5),
            labels = c(expression(Amp==1),
                       expression(Amp==1.5)))

Fig = df |> ggplot(aes(x=freq,y=power,color=type,group=type))+
  facet_wrap(~fmax, scales='free_x',labeller=label_parsed)+
  geom_line()+geom_point()+labs(x='frequency')+
  coord_cartesian(xlim = c(1, NA))+clean_theme()+
  labs(color = NULL)+
  scale_x_continuous(
    breaks = function(x) {
      # x is the range of the current panel
      c(1,seq(0, ceiling(max(x)), by = 4))
    })& theme(legend.position='bottom')
Fig
#ggsave('figures/pr_fig1.png',
#       Fig,
#       width=6,height=3,
#       device='png',
#       dpi=600)
