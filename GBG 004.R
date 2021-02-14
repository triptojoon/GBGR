setwd("d:/GBG/GBG")
df <- read.csv('data/secret.csv')

install.packages('dplyr')
install.packages('ggplot2')
install.packages('tidyverse')

library(dplyr)
library(ggplot2)
library(tidyverse)

#데이터 프레임

df1 <- df %>% 
  separate(col=생년월일, sep="/", into=c("년","월","일"), convert = TRUE) %>%
    mutate(세대 = ifelse(년<=64, "BB세대",
                      ifelse(년<=80, "X세대",
                              ifelse(년<=95, "Y세대","Z세대")))) %>%
      select(세대, 직위명, 본부명)

#세대별 직위 분포

ggplot(df1, aes(x=직위명, fill=세대)) + geom_bar(stat='count', position='dodge')

#본부별 세대 분포

ggplot(df1, aes(x=세대, fill=본부명)) + geom_bar(stat='count', position='dodge')
