df <- read.csv('data/kbo.csv')

install.packages('dplyr')
install.packages('ggplot2')

library(dplyr)
library(ggplot2)

temp <- df %>% group_by(연도) %>% summarise(총안타=sum(안타), 총타수=sum(타수)) %>% mutate(타율=총안타/총타수)

ggplot(data=temp, aes(x=연도, y=타율)) + geom_line()
                                     