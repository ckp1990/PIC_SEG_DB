extract_data<-function(connection_name){
  require(odbc)
  library(DBI)
  ##First you need to create a ODBC link to your database. 
  ## link how to do it. 
  connectionName <- dbConnect(odbc(), connection_name)
  ##next you need to send the query followed by columns name from table and then condition. 
  ##this is just like SQL query. 
  capture_TDB_OP <- dbSendQuery(connectionName," SELECT id, dt, image, time_seen, location, site, CPMD, side, season
           FROM Capture_Details
          ")
  ##fetch the table from
  capture_TDB_OP <- dbFetch(capture_TDB_OP)
  dbDisconnect(connectionName)
  return(capture_TDB_OP)
}
leopard_capture_details<-extract_data("leopard_db")
write.csv(leopard_capture_details,"leopard_capture_details.csv",row.names = F)
