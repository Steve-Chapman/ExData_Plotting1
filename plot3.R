#plot3.R
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
png(filename="plot3.png", width=480, height=480)
#Create the plot, but don't draw the lines yet
plot(pwrData$DateTime, pwrData$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")

#Draw each of the lines
lines(pwrData$DateTime, pwrData$Sub_metering_1, col="black")
lines(pwrData$DateTime, pwrData$Sub_metering_2, col="red")
lines(pwrData$DateTime, pwrData$Sub_metering_3, col="blue")

legend("topright", lwd=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Close the png device
dev.off()


