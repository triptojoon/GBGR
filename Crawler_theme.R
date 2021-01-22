library(httr)
library(rvest)
library(stringr)

data <- data.frame(matrix(nrow=0, ncol=11))

for(i in 1:500){
  print(i)
  URL = paste0('https://finance.naver.com/sise/sise_group_detail.nhn?type=theme&no=',i)
  down_table = GET(URL)
  
  Sys.setlocale("LC_ALL", "English")
  
  table = read_html(down_table, encoding = "EUC-KR") %>% 
    html_table(fill = TRUE)
  
  Sys.setlocale("LC_ALL", "Korean")
  
  if(length(table) == 3){
    theme = table[[1]]
    table = table[[3]]
    
    Sys.setlocale("LC_ALL", "Korean")
    
    theme <- theme[3,1]
    theme <- sub("\\\n.*","\\\n", theme)
    table[,c(ncol(table)-1,ncol(table))] = NULL
    table = table[-c(1,nrow(table)-1,nrow(table)),]
    table = na.omit(table)
    names(table) <- c("종목명","편입사유","현재가","전일비","등락률","매수호가","매도호가","거래량","거래대금","전일거래량")
    table$테마 <- theme
    data <- rbind(data,table)
    print(theme)
  }
}

write.csv(data, file = "naver_theme.csv", row.names = FALSE)
