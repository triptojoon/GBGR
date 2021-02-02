df <- read.csv('data/kbo.csv')

install.packages('dplyr')
install.packages('ggplot2')

library(dplyr)
library(ggplot2)

df

#Q1

df %>% mutate(타율 = 안타/타수, 출루율 = (안타+볼넷+몸에.맞는.공)/(타수+볼넷+몸에.맞는.공+희생플라이), 장타력=(안타+2*X2루타+3*X3루타+4*홈런)/타수, OPS=출루율+장타력) 

#Q2

Q2 <- df %>% mutate(타율 = 안타/타수, 출루율 = (안타+볼넷+몸에.맞는.공)/(타수+볼넷+몸에.맞는.공+희생플라이), 장타력=(안타+2*X2루타+3*X3루타+4*홈런)/타수, OPS=출루율+장타력) %>% group_by(팀, 연도) %>% summarise(팀홈런=sum(홈런), OPS) %>% filter(OPS>=0.7, 팀홈런<70)

#Q2 = 54개

#Q3

df %>% mutate(타율 = 안타/타수, 출루율 = (안타+볼넷+몸에.맞는.공)/(타수+볼넷+몸에.맞는.공+희생플라이), 장타력=(안타+2*X2루타+3*X3루타+4*홈런)/타수, OPS=출루율+장타력) %>% group_by(팀, 연도) %>% summarise(팀홈런=sum(홈런), OPS, 평균득점=득점/경기, 도루성공률=도루/(도루+도루실패)) %>% filter(OPS>=0.7, 팀홈런<70, 연도>=1982, 연도<=1990)

#Q4

df %>% mutate(연도그룹=ifelse(연도<=1990, "1982~1990", ifelse(연도<=2000, "1991~2000", ifelse(연도<=2010, "2000~2010", ifelse(연도<=2017, "2011~2017"))))) %>% group_by(연도그룹) %>% summarise(mean(희생번트))
                                                                                                                                                                                                                                                           