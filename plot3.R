## plot 3 ## 

# Clean up workspace
rm(list = ls())

#######################################################
# Download the file and put the file in the temp folder 
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

######################################################
# Read in the data from files

DataSet <- read.table(unzip(temp, "household_power_consumption.txt"), 
                      sep = ";", header = TRUE, na.strings = "?", dec = ".") 

DataSet$FullTimeDate <- strptime(paste(DataSet$Date, DataSet$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# converts to date format
DataSet$Date <- as.Date(DataSet$Date, "%d/%m/%Y")

# Select a subset
DataSet_select <- subset(DataSet, DataSet$Date >= "2007-02-01" & DataSet$Date <= "2007-02-02")

## Plot

png("plot3.png", width=480, height=480)

with(DataSet_select, plot(FullTimeDate, Sub_metering_1, type = "l", xlab = "Day", ylab = "Energy sub metering"))
with(DataSet_select, lines(FullTimeDate, Sub_metering_2, type="l", col="red"))
with(DataSet_select, lines(FullTimeDate, Sub_metering_3, type="l", col="blue"))
legend("topright", c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ") , col=c("black","red","blue")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()
