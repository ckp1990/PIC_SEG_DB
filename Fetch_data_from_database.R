##connect to database and use R 32bit for this work.
require(odbc)
library(DBI)
##First you need to create a ODBC link to your database. 
## link how to do it. 
connectionName <- dbConnect(odbc(), "Tiger_db")
##next you need to send the query followed by coloumns name from table and then conditon. 
##this is just like SQL query. 
capture_TDB_OP <- dbSendQuery(connectionName," SELECT id, dt, time_seen, location, site, CPMD, side, season
           FROM Capture_Details
           where CPMD = 'CT'
          ")
##fetch the table from
capture_TDB_OP <- dbFetch(capture_TDB_OP)
dbDisconnect(connectionName)
