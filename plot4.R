#plot4.R
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
png(filename="plot4.png", width=480, height=480)

#Set up the 2x2 grid
par(mfcol=c(2,2))

#Draw the upper left plot
plot(pwrData$DateTime, pwrData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Create the lower left plot, but don't draw the lines yet
plot(pwrData$DateTime, pwrData$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
#Draw each of the lines
lines(pwrData$DateTime, pwrData$Sub_metering_1, col="black")
lines(pwrData$DateTime, pwrData$Sub_metering_2, col="red")
lines(pwrData$DateTime, pwrData$Sub_metering_3, col="blue")

legend("topright", bty="n", lwd=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Draw the upper right plot
plot(pwrData$DateTime, pwrData$Voltage, type="l", xlab="datetime", ylab="Voltage")

#Draw the lower right plot
plot(pwrData$DateTime, pwrData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")


#Close the png device
dev.off()


