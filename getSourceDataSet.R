urlDataSource="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

library(data.table)
library(dplyr)
library(lubridate)

######   datadwnld(theurl, datadir=".")   ######
# download the file located at the specified URL
#   to the specified directory, 
#   only if it doesn't exists yet
# if it's a zip file, unzip it
#   only if the content doesn't exists yet
# return the relative path to the (extracted) file(s)
datadwnld<-function(theurl, datadir="."){
    if (!file.exists(datadir)) dir.create(datadir)
    thefile=file.path(datadir, last(strsplit(URLdecode(theurl),"/")[[1]]))
    if (!file.exists(thefile)) download.file(theurl, destfile = thefile)
    if (grepl(pattern = "\\.zip$", thefile)) {
        filelist=file.path(datadir, unzip(thefile, list = TRUE)$Name)
        if (!file.exists(filelist)) unzip(thefile, exdir = datadir)
        filelist
    } else {
        thefile
    }
}

if (!exists("epcDataset"))
epcDataset=fread(datadwnld(urlDataSource, "data"), na.strings = "?", 
                 colClasses = c("factor", "factor", "numeric", 
                                "numeric", "numeric", "numeric", 
                                "numeric", "numeric", "numeric")) %>% 
    filter(Date=="1/2/2007" | Date=="2/2/2007") %>%
        mutate(instant=as.POSIXct(dmy(Date) +hms(Time))) %>% 
        select(10, 3:9)

