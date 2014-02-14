library(RMySQL)

drv <- dbDriver("MySQL")
co <- dbConnect(drv, user="2009Expo", password="R R0cks", port=3306, dbname="accidents", host="headnode.stat.iastate.edu")

dbListTables(co)
dbDisconnect(co)

drv <- dbDriver("MySQL")
co <- dbConnect(drv, user="2009Expo", password="R R0cks", port=3306, dbname="accidents", host="headnode.stat.iastate.edu")
dbListTables(co)
dbListFields(co, "accidents")
dbDisconnect(co)
drv <- dbDriver("MySQL")
co <- dbConnect(drv, user="2009Expo", password="R R0cks", port=3306, dbname="accidents", host="headnode.stat.iastate.edu")

# send an SQL Query
dbGetQuery(co, "select count(*) from accidents")
dbGetQuery(co, "select Year, count(*) from accidents group by Year")

dbDisconnect(co)
co <- dbConnect(dbDriver("MySQL"), user="2009Expo", password="R R0cks", port=3306, dbname="accidents", host="headnode.stat.iastate.edu")
res <- dbSendQuery(co, "SELECT * FROM accidents")
fetch (res, 10)
?dbSendQuery
##############################################333
#lab
co <- dbConnect(drv, user="2009Expo", password="R R0cks", port=3306, dbname="accidents", host="headnode.stat.iastate.edu")
co
dbGetQuery(co, "select count(*) from accidents")
dbGetQuery(co, "select Year, count(*) from accidents group by Year")

dbGetQuery(co, "select Year, count(DRUNK_DR) from accidents group by Year")
a<-dbGetQuery(co, "select Year,DAY_WEEK, count(*) from accidents where DRUNK_DR != 0 group by Year,DAY_WEEK")
b<-dbGetQuery(co, "select Year,DAY_WEEK, count(*) from accidents group by Year,DAY_WEEK")
newa<-a[-c(62:68),]
newa[62,]<-c(2008,9,0)
newa<-rbind(newa,a[c(62:68),])
dim(newa)
b[,4]<-newa[,3]/b[,3]
names(b)[4]<-"Percentage"
b[,2]<-as.numeric(b[,2])
str(b)
library(ggplot2)
qplot(DAY_WEEK,Percentage,facets=Year~.,data=b)
library(plyr)
newtable<-ddply(b,.(DAY_WEEK),summarise,mean=mean(Percentage),sd=sd(Percentage),n=length(Percentage))
qplot(DAY_WEEK,mean,data=newtable)

