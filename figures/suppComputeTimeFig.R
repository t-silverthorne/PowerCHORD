source('clean_theme.R')
require(ggplot2)
require(patchwork)
require(scales)
require(latex2exp)

# Panel A: Compute Times
df1 = read.csv('figures/data/compTimes_varyPermmethodtictoc.csv',header=F)
names(df1)=c('Nmeas','time','q1','q3','idx')

legend_labels <- c(
  TeX("fixed period F-test"),
  TeX("$T_2$ bound"),
  TeX("$T_2$ perm direct"),
  TeX("$T_\\infty$ perm direct")
)
df1$idx <- factor(df1$idx,
                 levels = c(1,4,3,2))

pA = df1 |>
  ggplot(aes(x = Nmeas, y = time, group = idx, color = idx)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = pretty_breaks(n = 6)) +
  scale_y_continuous(
    trans = 'log10',
    breaks = 10^(-3:2),
    labels = label_log())+
  labs(x = 'permutations', y = 'time (seconds)', color = 'power method') +
  scale_color_viridis_d(option = 'H',labels=legend_labels)+
  clean_theme()
pA


# Panel B: Secondary data (placeholder)
df2 = read.csv("figures/data/compTimes_methodtimeit_Ns1000,Np1000.csv",header=F)
names(df2)=c('Nmeas','time','q1','q3','idx')
df2$idx <- factor(df2$idx,
                 levels = c(1,4,3,2),
                 labels = legend_labels)
# Assuming the placeholder CSV has columns: x, y, group
pB = df2 |>
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
  clean_theme() +
  guides(color = 'none')

# Combine panels
Fig = (pA | pB) +
  plot_annotation(tag_levels = 'A') +
  plot_layout(ncol = 2, guides = "collect") &
  theme(legend.position = "bottom")
ggsave('figures/suppComputeTimeFig.png',
       Fig,
       width=6,height=4,
       device='png',
       dpi=600)
