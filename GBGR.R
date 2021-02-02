setwd('D:/GBGR')

kbo <- read.csv("kbo.csv")

#install.packages('dplyr')
library(dplyr)

kbo %>% arrange(팀) %>% head(5)

kbo %>% filter(연도 == 2015) %>% 
  select(팀, 경기, 타수, 홈런, 타점)

avg <- kbo %>% group_by(연도) %>% 
  summarise(총안타= sum(안타), 총타수=sum(타수)) %>% 
  mutate(타율 = 총안타/총타수)


# 가장 타율이 좋았던 해는?

library(ggplot2)

ggplot(data= avg, aes(x = 연도, y = 타율)) +
  geom_line()


ggplot(data = avg, aes(y = 타율)) + geom_boxplot(fill="green", alpha=0.8) + xlab("타율율")


ggplot(mtcars, aes(x=as.factor(cyl), y=mpg)) + 
  geom_boxplot(fill="slateblue", alpha=0.2) + 
  xlab("cyl")


#Q1
kbo <- mutate(kbo, 타율=안타/타수,
              출루율 = (안타+볼넷+몸에.맞는.공)/(타수+볼넷+몸에.맞는.공+희생플라이),
              장타력=총루타/타수,
              ops=출루율+장타력)



#Q2
kbo %>% filter(ops >= 0.7 & 홈런 <70) %>% select(연도, 팀, ops, 홈런)

kbo %>%
  filter(ops >= 0.7 & 홈런 < 70) %>%
  summarise(n())



#Q3
kbo %>%
  filter(ops >= 0.7 & 홈런 < 70 & 연도 %in% 1982:1990)

kbo %>%
  filter(ops >= 0.7 & 홈런 < 70 & 연도 %in% 1982:1990) %>%
  select(연도, 팀, 경기, 득점, 도루, 도루실패) %>%
  mutate(평균득점 = 득점/경기, 도루성공률=도루/(도루+도루실패))



#Q4
kbo %>% mutate(그룹 = ifelse(연도<=1990, "A",
                             ifelse(연도<=2000, "B",
                                      ifelse(연도<=2010, "C", "D"))))

kbo %>% mutate(그룹 = ifelse(연도<=1990, "1982~1990",
                             ifelse(연도<=2000, "1991~2000",
                                      ifelse(연도<=2010, "2001~2010", "2011~2017")))) %>% 
  group_by(그룹) %>% summarise(평균희생번트=mean(희생번트))



kbo %>% 
  mutate(시기=ifelse(연도<=1990,"1980년대", 
                     ifelse(연도<=2000,"1990년대", 
                              ifelse(연도<=2010,"2000년대", 
                                       "2010년대")))) %>% 
  group_by(시기) %>% 
  summarise(평균희생번트=mean(희생번트))
