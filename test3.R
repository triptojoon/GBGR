setwd("/Users/leeaero/Documents/R_test")
#install.packages('dplyr')
#install.packages('ggplot2')
library ('dplyr')
library('ggplot2')

kbo=read.csv("kbo.csv", fileEncoding="euc-kr")

'''
Q1. 타격 기록 중 가장 기본이 되는 타율/출루율/장타력과 OPS( 출루율+장타력) 변수(열)을 만드시오.
*출류율 = (안타+볼넷+몸에 맞는 공) / (타수+볼넷+몸에맞는공 +희생플라이)
*장타력 = (단타+2*2루타+3*3루타+4*홈런)/타수
'''

kbo_rev= kbo %>% mutate(타율=안타/타수) %>% 
  mutate(출루율=(안타+볼넷+몸에.맞는.공) / (타수+볼넷+몸에.맞는.공 +희생플라이)) %>% 
  mutate(단타=안타-X2루타-X3루타-홈런) %>% mutate(장타력=(단타+2*X2루타+3*X3루타+4*홈런)/타수) %>% mutate(OPS=출루율+장타력)

### mutate를 하나로 묶어서 사용하셔도 좋을 것 같아요 mutate( F1 = x/y, F2 = x*y...)

# Q2. OPS가 0.7이상이면서 팀 홈런이 70개 미만인 팀+연도는 몇개인지 구하시오

kbo_rev %>% 
  count(OPS>=0.7 & 홈런<70, sort=TRUE)

### count를 쓰변 조건 식에 대해 True/False 값에 대한 테이블을 만들어줍니다. 단순한게 조건에 대한 갯수는 filter(XXX) %>% summarize(n()) 으로 해보세요

#Q3. 문2에서 뽑은 팀 중 1982~1990년 사이 팀을 골라 각가 경기당 평균 득정과 도루 성공률을 구하시오
#* 평균득점 = 득점 / 경기
#* 도루성공률 = 도루/(도루+도루실패)

kbo_rev %>% 
  mutate(평균득점=득점/경기, 도루성공률=도루/(도루+도루실패)) %>% 
  filter(OPS>=0.7 & 홈런<70 & 연도<=1990) %>% 
  select(연도, 팀, OPS, 홈런, 평균득점, 도루성공률)

#Q4. 1982~1900년, 1991~2000년, 2001~2010년, 2011~2017년 평균 희생번트 숫자를 구하시오
#* hint : ifelse로 그룹을 만들어서 평균을 구해보시오

kbo_rev %>% 
  mutate(시기=(ifelse(연도<=1990,"1980년대", ifelse(연도<=2000,"1990년대", ifelse(연도<=2010,"2000년대", "2010년대"))))) %>% 
  group_by(시기) %>% 
  summarise(평균희생번트=mean(희생번트))


### 나머지 아주 굿 고생하셨습니다.
