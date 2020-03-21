urlDataSource="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

######  grabing the dataset  ######
# this file is called [using source('getSourceDataSet.R')] 
#        by all the plotting scripts to read the data
# The 1st time it's called, it will download the zip, 
#       extract the txt file,
#       load the data in a data.frame named 'epcDataset', 
#       filter it on the 2 asked dates,
#       and replace the 2 Date & Time columns by a single POSIXct column named 'instant'
# the next times it's called, it just checks that the 'epcDataset' data.frame exists
#       if yes, comes back here without doing anything else and continues
#       if no, proceeds again as above before !
# The code checking the existence of the data set is a the bottom of the file 
#       after the downloading function

library(data.table)
library(dplyr)
#library(lubridate)

######   datadwnld(theurl, datadir=".")   ######
# Function that download the file located at the
#   specified URL to the specified directory, 
#   only if it doesn't exists yet
# if it's a zip file, unzip it
#   only if the content doesn't exists yet
#
# It returns the relative path to the (extracted) file(s)
#
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

# check the existence of the data set. If not, proceed !
if (!exists("epcDataset"))
epcDataset=fread(datadwnld(urlDataSource, "data"), na.strings = "?", 
                 colClasses = c("factor", "factor", "numeric", 
                                "numeric", "numeric", "numeric", 
                                "numeric", "numeric", "numeric")) %>% 
    filter(Date=="1/2/2007" | Date=="2/2/2007") %>%
        mutate(instant=as.POSIXct(strptime(paste(Date, Time), 
                                           "%d/%m/%Y %H:%M:%S"))) %>% 
        select(10, 3:9)



#as.POSIXct(dmy(Date) +hms(Time)) # removed the need for lubridate
