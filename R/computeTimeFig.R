source('clean_theme.R')
require(ggplot2)
require(patchwork)
require(scales)
require(latex2exp)
df = read.csv('figures/data/compTimes_methodtimeit_Ns1000,Np1000.csv',header=F)
names(df)=c('Nmeas','time','q1','q3','idx')

legend_labels <- c(
  TeX("fixed period F-test"),
  TeX("$T_2$ bound"),
  TeX("$T_2$ perm direct"),
  TeX("$T_\\infty$ perm direct")
)
df$idx <- factor(df$idx,
                 levels = c(1,4,3,2))
#                 labels = c(
#                   "fixed period F-test",                          # plain text
#                   TeX("$\\alpha$ bound"),  # average perm bound T_2 bound
#                   expression("average perm"),            # average perm T_2
#                   expression("max perm")          # max perm T_\infty
#                 ))
Fig = df |>
  ggplot(aes(x = Nmeas, y = time, group = idx, color = idx)) +
  geom_line() +
  geom_point() +
  geom_errorbar(aes(ymin = q1, ymax = q3)) +
  scale_y_continuous(
    trans = 'log10',
    breaks = 10^(-3:2),
    labels = label_log())+
  labs(x = 'sample size', y = 'time (seconds)', color = 'power method') +
  scale_color_viridis_d(option = 'H',labels=legend_labels)+
  clean_theme()
ggsave('figures/prCompTime.png',
       Fig,
       width=6,height=2.5,
       device='png',
       dpi=600)
