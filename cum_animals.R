##running the seq images capture in the database. 
Tiger<-extract_data("Tiger_db")##25041
##only CT images
Tiger<-Tiger[Tiger$CPMD=="CT",] ## 23186
##removing the duplicates
Tiger<-Tiger[!duplicated(Tiger),] ##11767
Tiger<-Tiger[is.na(Tiger$season)==F,] ##11766
season_levels<-unique(Tiger$season)

library(dplyr)
Seasonal<-group_by(Tiger,season)%>%summarise(count=n(),sites=n_distinct(site))%>%data.frame()
Seasonal$season<-ordered(Seasonal$season,levels=season_levels)

Seasonal<-Seasonal[order(Seasonal$season),]
Seasonal$cum_sum<-cumsum(Seasonal$count)

##new addition every season

new_add<-data.frame(season=rep(NA,length(Seasonal$season)),animal_unique=rep(NA,length(Seasonal$season)))
unique_tillnow<-"Chandan"
tr<-1
for(n in Seasonal$season){
  new_add[tr,1]<-as.character(n) ## filling the season
  season_tiger<-Tiger[Tiger$season==n,]
  start_With<-length(unique_tillnow)
  ind_uniq<-unique(season_tiger$id)
  unique_tillnow<-c(unique_tillnow,ind_uniq)
  unique_tillnow<-unique(unique_tillnow)
  end_with<-length(unique_tillnow)
  new_add[tr,2]<-end_with-start_With
  tr<-tr+1
}
