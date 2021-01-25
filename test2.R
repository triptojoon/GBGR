setwd("/Users/leeaero/Documents/R_test")
install.packages('dplyr')
install.packages('ggplot2')
library ('dplyr')
library('ggplot2')

kbo=read.csv("kbo.csv", fileEncoding="euc-kr")

kbo %>% 
  group_by(연도) %>% 
  summarise(총안타=sum(안타), 총타수=sum(타수)) %>% 
  mutate(연도별타율=총안타/총타수) %>% 
  ggplot(aes(연도,연도별타율)) + geom_line()
