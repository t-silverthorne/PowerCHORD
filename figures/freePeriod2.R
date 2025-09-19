
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
  clean_theme()+labs(color=NULL,x='frequency')+ylim(c(0,1))
p_c
