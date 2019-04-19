setwd('C:/Users/david/SharedCode/StimulationResponseTimingPython')

library('here')
library('ggplot2')
library('FSA')
library('rcompanion')
library("dplyr")
library('nortest')
library('onewaytests')

rootDir = here()
dataDir = here()

sidVec <- c('a1355e','3ada8b','822e26')
#sidVec <- c('a1355e')

savePlot = 0
figWidth = 8 
figHeight = 6 

dataList = list()
kruskalList = list()
adList= list()
summaryList = list()
cldSubjs = list()
ptList = list()
forsytheList = list()

index = 1
for (sid in sidVec){
  
  if(sid == 'a1355e'){
  dataRT <- read.table(here(paste0(sid,'_TOJ.csv')),header=TRUE,sep = ",",stringsAsFactors=F, 
                       colClasses=c("firstFelt"="factor","firstFeltSame"="factor","firstFeelNameSame"="factor"))
  dataRT <- na.omit(dataRT)
  
  summaryList[[index]] <- dataRT %>% 
    group_by(firstFeelNameSame) %>% 
    select(firstFeelNameSame,responseTimes..ms.) %>%
    summarise_all(funs(n = n(),
                       min = min, 
                       q25 = quantile(., 0.25), 
                       median = median, 
                       q75 = quantile(., 0.75), 
                       max = max,
                       mean = mean, 
                       sd = sd))
  
  dataRT <- dataRT %>%
    add_count(firstFeelNameSame)
  
  adList[[index]] <- dataRT %>% 
    group_by(firstFeelNameSame) %>% 
    filter(n>7) %>%
    summarize(adTest = ad.test(responseTimes..ms.)[[2]])
  
  dataForsythe <- dataRT %>% 
    filter(n>5) 
  
  
  kruskalList[[index]] <- kruskal.test(responseTimes..ms. ~ firstFeelNameSame,data=dataForsythe)
  summary
  

  forsytheList[[index]] <- bf.test(responseTimes..ms. ~ firstFeelNameSame, data=dataForsythe, alpha = 0.05, na.rm = TRUE, verbose = TRUE)

    PT = dunnTest(responseTimes..ms. ~ firstFeelNameSame,data=dataRT,
                  method="sidak")    # Can adjust p-values; 
    PT = PT$res
    
    ptList[[index]] = PT
    
    cldSubjs[[index]] <-cldList(comparison = PT$Comparison,
                                p.value    = PT$P.adj,
                                threshold  = 0.05)
  
  }else{
    dataRT <- read.table(here(paste0(sid,'_TOJ.csv')),header=TRUE,sep = ",",stringsAsFactors=F, 
                         colClasses=c("firstFeelName"="factor","firstFelt"="factor"))
    dataRT <- na.omit(dataRT)
    
    summaryList[[index]] <- dataRT %>% 
      group_by(firstFeelName) %>% 
      select(firstFeelName,responseTimes..ms.) %>%
      summarise_all(funs(n = n(),
                         min = min, 
                         q25 = quantile(., 0.25), 
                         median = median, 
                         q75 = quantile(., 0.75), 
                         max = max,
                         mean = mean, 
                         sd = sd))
    
    dataRT <- dataRT %>%
      add_count(firstFeelName)
    
    adList[[index]] <- dataRT %>% 
      group_by(firstFeelName) %>% 
      filter(n>7) %>%
      summarize(adTest = ad.test(responseTimes..ms.)[[2]])
    
    kruskalList[[index]] <- kruskal.test(responseTimes..ms. ~ firstFeelName,data=dataRT)
    summary
    
    dataForsythe <- dataRT %>% 
      filter(n>5) 
    
    forsytheList[[index]] <- bf.test(responseTimes..ms. ~ firstFeelName, data=dataForsythe, alpha = 0.05, na.rm = TRUE, verbose = TRUE)
    
    PT = dunnTest(responseTimes..ms. ~ firstFeelName,data=dataRT,
                  method="sidak")    # Can adjust p-values; 
    PT = PT$res
    
    ptList[[index]] = PT
    
    cldSubjs[[index]] <-cldList(comparison = PT$Comparison,
                                p.value    = PT$P.adj,
                                threshold  = 0.05)
    
  }
  index = index + 1 
}
