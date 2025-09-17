# figure showing equispaced versus permutation bound designs
require(ggplot2)
df1 = read.csv('figures/data/prF1c_n48_modetest.csv',F)
names(df1) = c('Amp','fmax','freq','power')
df1=cbind(df1,data.frame(type='equispaced'))
df2 = read.csv('figures/data/prF1c_cheb_n48_modetest.csv',F)
names(df2) = c('Amp','fmax','freq','power')
df2=cbind(df2,data.frame(type='cheb'))
df = rbind(df1,df2)
df |> ggplot(aes(x=freq,y=power,color=type,group=type))+
  facet_grid(Amp~fmax, scales='free_x')+geom_line()+geom_point()
