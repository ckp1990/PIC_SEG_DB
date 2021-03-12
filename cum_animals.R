##running the seq images capture in the database. 
Tiger<-extract_data("leopard_db")##25041
##only CT images
Tiger<-Tiger[Tiger$CPMD=="CT",] ## 23186
##removing the duplicates
Tiger<-Tiger[!duplicated(Tiger),] ##11767
Tiger<-Tiger[is.na(Tiger$season)==F,] ##11766
season_levels<-unique(Tiger$season)

##new addition every season

cummelative_change<-function(data,site){
  required_dF<-data[data$site==site,]
  se<-unique(data$season)
  se<-ordered(se,levels=se)
  to_fill<-rep(NA,(length(se))+1)
  to_fill[1]=0
  ind_un<-"Chandan"
  t=2
  k=1
  for(n in se){
    season_df<-required_dF[required_dF$season==n,]
    if(nrow(season_df)!=0){
      ind_un<-c(ind_un,unique(season_df$id))
      ind_un<-unique(ind_un)
      uni_till_now=length(ind_un)-1
      to_fill[t]=uni_till_now-sum(to_fill[1:k])
      k=k+1
      t=t+1
    } else {
      to_fill[t]=0
      t=t+1
      k=k+1
    }
  }
  return(to_fill[-1])
}
se<-unique(Tiger$season)
site<-unique(Tiger$site)
site_check_data<-data.frame(season=se)
for(n in site){
  add_col<-cummelative_change(Tiger,n)
  site_check_data<-bind_cols(site_check_data,add_col)
  names(site_check_data)[ncol(site_check_data)]<-n
}
write.csv(site_check_data,"leopard_capture_details.csv",row.names = F)
