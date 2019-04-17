setwd('C:/Users/david/SharedCode/StimulationResponseTimingPython')

library('here')
library('ggplot2')
library('FSA')
library('rcompanion')
library("dplyr")
library('nortest')


rootDir = here()
dataDir = here()

sidVec <- c('a1355e','3ada8b','822e26')
#sidVec <- c('822e26')

savePlot = 0
figWidth = 8 
figHeight = 6 

dataList = list()
kruskalList = list()
adList= list()
summaryList = list()
cldSubjs = list()
ptList = list()

index = 1
for (sid in sidVec){

   dataRT <- read.table(here(paste0(sid,'_priming.csv')),header=TRUE,sep = ",",stringsAsFactors=F, colClasses=c("Subject"="factor","Experiment"="factor"))
   dataRT <- na.omit(dataRT)
  
   summaryList[[index]] <- dataRT %>% 
     group_by(Experiment) %>% 
      select(Experiment,Response.Time..ms.) %>%
      summarise_all(funs(n = n(),
                         min = min, 
                          q25 = quantile(., 0.25), 
                          median = median, 
                          q75 = quantile(., 0.75), 
                          max = max,
                          mean = mean, 
                          sd = sd))
    
   dataRT <- dataRT %>%
     add_count(Experiment)
   
   adList <- dataRT %>% 
     group_by(Experiment) %>% 
     filter(n>7) %>%
     summarize(adTest = ad.test(Response.Time..ms.)[[2]])
   
   kruskalList[[index]] <- kruskal.test(Response.Time..ms. ~ Experiment,data=dataRT)
   summary
   
   if(sid != 'a1355e'){
   PT = dunnTest(Response.Time..ms. ~ Experiment,data=dataRT,
                 method="bh")    # Can adjust p-values; 
   PT = PT$res
   
   ptList[[index]] = PT

   cldSubjs[[index]] <-cldList(comparison = PT$Comparison,
                                   p.value    = PT$P.adj,
                                   threshold  = 0.05)
   }
   index = index + 1 
}
