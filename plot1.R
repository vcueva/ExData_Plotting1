## plot1.R

## Load the complete data file
workData <- read.table("household_power_consumption.txt", header=TRUE, sep=';')
## Select only data with specific date
workData <- workData[((workData$Date == "1/2/2007") | (workData$Date == "2/2/2007")),]
## change the Date and Time to a Date/Time class
workData$Time <- strptime(paste(workData$Date,workData$Time), format = "%d/%m/%Y %H:%M:%S")
workData$Date <- as.Date(workData$Date,"%d/%m/%Y")
## Extract work data
gap <- workData$Global_active_power
## Create the histogram
hist(as.numeric(as.character(gap)),breaks = 12,col = 'red', main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
## Generate png file
dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
dev.off() ## Close the PNG device!

## End Script