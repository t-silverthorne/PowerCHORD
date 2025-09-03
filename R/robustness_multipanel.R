require(ggplot2)
require(glue)
require(patchwork)
dfA=readRDS('df_robustA.RDS')
dfB=readRDS('df_robustB.RDS')

pa = dfA |> ggplot(aes(x=fpr,y=tpr,group=idx,color=sampling))+geom_line()+facet_wrap(~method,nrow=1)+clean_theme()
# want facets to have nice names, only want 0,.25, .5, .75, 1 ticks on x and y, x label
# should be FPR and y should be TPR
pa = pa + facet_wrap(~method, nrow=1,
             labeller = labeller(method = c(
               sim_cosinor           = "true cosinor",
               sim_cosinor_osc_amp   = "rhythmic amplitude",
               sim_cosinor_osc_phase = "rhythmic acrophase",
               sim_cosinor_osc_noise = 'rhythmic noise'# replace with your nicer names
             ))) +
  scale_x_continuous(breaks = c(0, 0.25, 0.5, 0.75, 1),
                     labels = c(0,.25,.5,.75,1)) +
  scale_y_continuous(breaks = c(0, 0.25, 0.5, 0.75, 1)) +
  labs(x = "FPR", y = "TPR") +labs(color=NULL)
  clean_theme()
pb = dfB |>
  ggplot(aes(x=fpr,y=tpr_mean,group=sampling,color=sampling))+geom_line()+
  geom_ribbon(aes(ymin = tpr_lower, ymax = tpr_upper), alpha = 0.2, color = NA)+
  facet_grid(
    glue("xi*' '[max]*' = {eig_max}'")~glue("'Amp = {Amp}'"),
    labeller = label_parsed
  )  +
  scale_x_continuous(breaks = c(0, 0.25, 0.5, 0.75, 1),
                     labels = c(0,.25,.5,.75,1)) +
  scale_y_continuous(breaks = c(0, 0.25, 0.5, 0.75, 1)) +
  labs(x = "FPR", y = "mean TPR") +labs(color=NULL)+
  clean_theme()
# legend should appear at bottom
Fig = pa/pb + plot_layout(guides='collect',
                    heights=c(1,3))+plot_annotation(tag_levels='A')&
  theme(legend.position = "bottom")
ggsave('MATLAB/peer_review/figures/output/pr_fig_robustness.png',
       Fig,
       width=6,height=6,
       device='png',
       dpi=600)
