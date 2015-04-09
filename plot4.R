## plot4.R

## Load the complete data file
workData <- read.csv2("household_power_consumption.txt", header=TRUE)
## Select only data with specific date
workData <- workData[((workData$Date == "1/2/2007") | (workData$Date == "2/2/2007")),]
## change the Date and Time to a Date/Time class and others to numeric
workData$Time <- strptime(paste(workData$Date,workData$Time), format = "%d/%m/%Y %H:%M:%S")
workData$Date <- as.Date(workData$Date,"%d/%m/%Y")
workData$Sub_metering_1 <- as.numeric(as.character(workData$Sub_metering_1))
workData$Sub_metering_2 <- as.numeric(as.character(workData$Sub_metering_2))
workData$Sub_metering_3 <- as.numeric(as.character(workData$Sub_metering_3))
workData$Global_active_power <- as.numeric(as.character(workData$Global_active_power))
workData$Global_reactive_power <- as.numeric(as.character(workData$Global_reactive_power))
workData$Voltage <- as.numeric(as.character(workData$Voltage))
## define 4 regions in canvas
par(mfrow = c(2,2))
## plot the graph 1 in the upper left
plot(workData$Time, workData$Global_active_power, type = 'l', xlab = " ", ylab = "Global Active Power")
## plot the graph 2 in upper right
plot(workData$Time, workData$Voltage, type = 'l', xlab = "datetime", ylab = "Voltage")
## plot the graph 3 in bottom left
## Generate data for plotting, al Sub_metering together
a <- workData[,c(2,7)]
b <- workData[,c(2,8)]
c <- workData[,c(2,9)]
colnames(a) <- c("Time", "Sub_metering")
colnames(b) <- c("Time", "Sub_metering")
colnames(c) <- c("Time", "Sub_metering")
d <- rbind(a,b,c) 
g <- gl(3,length(a$Time),labels = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
## Plot data without data
plot(d$Time, d$Sub_metering, type = 'n', xlab = " ", ylab = "Energy sub metering")
## Plot each one
points(d$Time[g == "Sub_metering_1"], d$Sub_metering[g == "Sub_metering_1"], type = 'l',col = 'black')
points(d$Time[g == "Sub_metering_2"], d$Sub_metering[g == "Sub_metering_2"], type = 'l',col = 'red')
points(d$Time[g == "Sub_metering_3"], d$Sub_metering[g == "Sub_metering_3"], type = 'l',col = 'blue')
## Add legend
legend('topright', legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = c(2,2,2), col = c("black","red","blue"), cex = 0.8)
## plot the graph 4 in bottom right
plot(workData$Time, workData$Global_reactive_power, type = 'l', xlab = "datetime", ylab = "Global_reactive_power")
## Generate de png file
dev.copy(png, file = "plot4.png") ## Copy my plot to a PNG file
dev.off() ## Close the PNG device!

## End Script