#######################
## plot1.R is a program designed to read in from the working directory the text
## file "household_power_consumption.txt" as a datatable and it the converts some
## of the columns to a more friendly class. Then it subsets the data for the
## dates  2007-02-01 and 2007-02-02 and uses that information to produce a 
## graph in a file the same working directory with the name plot1.png. The 
## reason for writihg it may be found in the README.md file found in the same
## repository where you found this R code file plot1.R
##
## NOTE: The original data for this program was downloaded 8/17/2016 19:00 PDT 
## and placed in the same repository where you found this R code file plot1.R
## with the name household_power_consumption.zip. It is assumed that the file 
## has been downloaded and extracted into the working and is named 
## "household_power_consumption.txt"
#######################

library(data.table)   ## just because of fread()
library(dplyr)        ## makes it easier to play with data and readable
                      ## look at filter() just like the SQL 'where' clause
library(lubridate)    ## it is just so much faster to convert dates using dmy() 
                      ## than as.Date() and workind with dates in general. 
                      ## dmy_hms() is way faster than strptime() and doesn't 
                      ## complain plus calculations are a snap. Although finally
                      ## not used.
## Get the data
data<-fread("household_power_consumption.txt", sep=";", header=TRUE,  
              na.strings="?")

## Convert the column Time to class 'POSIXct'/'POSIXt'
## not used in rest of code waste of time to run it
#data$Time <- dmy_hms(paste(data$Date, data$Time)) 

## Convert the column Date to class 'Date'
data$Date<-dmy(data$Date)

## Get the data for 2007-02-01 and 2007-02-02
plotData<-filter(data,Date == ymd("2007-02-01") | Date == ymd("2007-02-02") )

## Plot1

## Open device to plot to a PNG file
png(file = "plot1.png") 

## Do the the histogram plot
hist(plotData$Global_active_power, col="red", main="Global Active Power", 
      xlab="Global Active Power (Kilowatts)")

## Close the file by shutting down the device
dev.off()
