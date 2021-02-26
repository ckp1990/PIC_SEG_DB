##connect to database and use 
R version 4.0.1 (2020-06-06) -- "See Things Now"
Copyright (C) 2020 The R Foundation for Statistical Computing
Platform: i386-w64-mingw32/i386 (32-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> ##connect to database and use R 32bit for this work.
> require(odbc)
Loading required package: odbc
Warning message:
package ‘odbc’ was built under R version 4.0.2 
> library(DBI)
Warning message:
package ‘DBI’ was built under R version 4.0.2 
> ##First you need to create a ODBC link to your database. 
> ## link how to do it. 
> connectionName <- dbConnect(odbc(), "Tiger_db")
> ##next you need to send the query followed by coloumns name from table and then conditon. 
> ##this is just like SQL query. 
> capture_TDB_OP <- dbSendQuery(connectionName," SELECT id, dt, image, time_seen, location, site, CPMD, side, season
+            FROM Capture_Details
+           ")
> ##fetch the table from
> capture_TDB_OP <- dbFetch(capture_TDB_OP)
> dbDisconnect(connectionName)
Warning message:
In connection_release(conn@ptr) : There is a result object still in use.
ThR 32bit for this work.
require(odbc)
library(DBI)
##First you need to create a ODBC link to your database. 
## link how to do it. 
connectionName <- dbConnect(odbc(), "Tiger_db")
##next you need to send the query followed by columns name from table and then condition. 
##this is just like SQL query. 
capture_TDB_OP <- dbSendQuery(connectionName," SELECT id, dt, image, time_seen, location, site, CPMD, side, season
           FROM Capture_Details
          ")
##fetch the table from
capture_TDB_OP <- dbFetch(capture_TDB_OP)
dbDisconnect(connectionName)
write.csv(capture_TDB_OP,"Animal_cature_details.csv",row.names = F)
