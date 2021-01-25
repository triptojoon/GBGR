df <- read.csv('data/kbo.csv')

install.packages('dplyr')

library(dplyr)

# ctrl + shift + M -> pipe (%>%) 입력 
# KBO 데이터를 활용해서 경기당 평균득점(득점/경기)를 mutate를 활요해서 만들고, 평균득점을 기준으로 상위 10개 팀을 추려주세요. 데이터를 추릴 때 연도, 팀, 경기, 득점, 평균득점, 홈런 만 포함시켜주세요.하다가 모르는거 있으면 물어봐 다 뚫어드립니다.

temp <- df %>% mutate(평균득점 = 득점/경기) %>% arrange(desc(평균득점)) %>% select(연도, 팀, 경기, 득점, 평균득점, 홈런) %>% head(10)

temp
