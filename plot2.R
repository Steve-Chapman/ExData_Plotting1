#plot2.R
#Steve Chapman / Exploratory Data Analysis / JUNE 2015

#Load necessary packages
library(sqldf)
library(lubridate)

#Read in data for just the days of interest.
inputDataFile <- "household_power_consumption.txt"
pwrData <- read.csv.sql(inputDataFile, sql = "select * from file 
                        where Date in ('1/2/2007', '2/2/2007')", header = TRUE, sep = ';')
closeAllConnections()

#Replace '?' with NA
pwrData[pwrData == "?"] = NA

#Create a date-time field.
pwrData$DateTime <- dmy_hms(paste(pwrData$Date, pwrData$Time))


#Open the png device
png(filename="plot2.png", width=480, height=480)
#Draw the plot
plot(pwrData$DateTime, pwrData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")


#Close the png device
dev.off()


