######  grabing the dataset  ######
# the code for reading the data is in the 'getSourceDataSet.R' file,
#        shared by all the plotting scripts
# The 1st time it's called, it will download the zip, 
#       extract the txt file,
#       load the data in a data.frame named 'epcDataset', 
#       filter it on the 2 asked dates,
#       and replace the 2 Date & Time columns by a single POSIXct column named 'instant'
# the next times it's called, it just checks that the 'epcDataset' data.frame exists
#       if yes, comes back here without doing anything else and continues
#       if no, proceeds again as above before !
# So this line just call the shared script. 
#       Be sure that it is in the working directory !
source('getSourceDataSet.R') 



# Not living in an English speaking country, 
# But I still want to have the days on the X axis in English !
# So I record here my country's TIME locale
my_locale=Sys.getlocale(category = "LC_TIME")



######  making the plot and writing the PNG file  ######
## Open PNG device; create 'plot1.png' in my working directory
## use the default settings: width of 480 pixels and height of 480 pixels
png(file = "plot3.png") 

# Change TIME locale to something displaying days in English.
Sys.setlocale(category = "LC_TIME", locale = "C")

## Create plot and send to the file (no plot appears on screen)
with(epcDataset, plot(instant, Sub_metering_1, type="l",
                      xlab = "",
                      ylab = "Energy sub metering"))
with(epcDataset, lines(instant, Sub_metering_2, col="red"))
with(epcDataset, lines(instant, Sub_metering_3, col="blue"))
legend("topright", lty = 1, col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

# Reverse back to my country's TIME locale.
Sys.setlocale(category = "LC_TIME", locale = my_locale)

## Close the PNG file device
dev.off() 

