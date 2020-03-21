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
# I still want to have the days on the X axis in English.
my_locale=Sys.getlocale(category = "LC_TIME")

######  making the plot and writing the PNG file  ######
## Open PNG device; create 'plot1.png' in my working directory
## use the default settings: width of 480 pixels and height of 480 pixels
png(file = "plot2.png") 

# Change locale to something displaying days in english.
Sys.setlocale(category = "LC_TIME", locale = "C")

## Create plot and send to the file (no plot appears on screen)
with(epcDataset, plot(instant, Global_active_power, type="l",
                      xlab = "",
                      ylab = "Global Active Power (kilowatts)"))

# Reverse back to my country's locale.
Sys.setlocale(category = "LC_TIME", locale = my_locale)

## Close the PNG file device
dev.off() 

