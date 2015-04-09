## plot3.R

## Load the complete data file
workData <- read.csv2("household_power_consumption.txt", header=TRUE)
## Select only data with specific date
workData <- workData[((workData$Date == "1/2/2007") | (workData$Date == "2/2/2007")),]
## change the Date and Time to a Date/Time class and Sub metering to numeric
workData$Time <- strptime(paste(workData$Date,workData$Time), format = "%d/%m/%Y %H:%M:%S")
workData$Date <- as.Date(workData$Date,"%d/%m/%Y")
workData$Sub_metering_1 <- as.numeric(as.character(workData$Sub_metering_1))
workData$Sub_metering_2 <- as.numeric(as.character(workData$Sub_metering_2))
workData$Sub_metering_3 <- as.numeric(as.character(workData$Sub_metering_3))
## Generate data for plotting, al Sub_metering together
a <- workData[,c(2,7)]
b <- workData[,c(2,8)]
c <- workData[,c(2,9)]
colnames(a) <- c("Time", "Sub_metering")
colnames(b) <- c("Time", "Sub_metering")
colnames(c) <- c("Time", "Sub_metering")
d <- rbind(a,b,c) 
g <- gl(3,length(a$Time),labels = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Open a png device
png(filename = "plot3.png")
## Plot data without data
plot(d$Time, d$Sub_metering, type = 'n',xlab = " ", ylab = "Energy sub metering")
## Plot each one
points(d$Time[g == "Sub_metering_1"], d$Sub_metering[g == "Sub_metering_1"], type = 'l',col = 'black')
points(d$Time[g == "Sub_metering_2"], d$Sub_metering[g == "Sub_metering_2"], type = 'l',col = 'red')
points(d$Time[g == "Sub_metering_3"], d$Sub_metering[g == "Sub_metering_3"], type = 'l',col = 'blue')
## Add legend
legend('topright', legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = c(2,2,2), col = c("black","red","blue"))
## Generate de png file
#dev.copy(png, file = "plot3.png") ## Copy my plot to a PNG file
dev.off() ## Close the PNG device!

## End Script