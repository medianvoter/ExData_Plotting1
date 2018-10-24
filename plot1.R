library(lubridate)

rm(list = ls())
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

fileName <- "household_power_consumption.zip"
dateDownloaded <- Sys.Date()
# fileName <- paste0(dateDownloaded, "_", fileName)
download.file(url, fileName)
unzip(fileName)

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
data$Date <- dmy(data$Date)
smaller <- subset(data, ymd("2007-02-01") <= Date & Date <= ymd("2007-02-02"))
str(smaller)
# converting global power, voltage, and submetering from factor to numeric
smaller$Global_active_power <- 
    as.numeric(as.character(smaller$Global_active_power))
smaller$Global_reactive_power <- 
    as.numeric(as.character(smaller$Global_reactive_power))
smaller$Voltage <- as.numeric(as.character(smaller$Voltage))
smaller$Sub_metering_1 <- as.numeric(as.character(smaller$Sub_metering_1))
smaller$Sub_metering_2 <- as.numeric(as.character(smaller$Sub_metering_2))
# producing date-time variable
smaller$datetime <- ymd_hms(paste(smaller$Date, smaller$Time))

png("plot1.png") # defaults are already 480 x 480 pixels
par(bg = NA) # set transparent background
hist(smaller$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

# The rest of the code is commented out and put in other files. 

#png("plot2.png")
#par(bg = NA)
#plot(smaller$datetime, smaller$Global_active_power, type = "l", 
#     ylab = "Global Active Power (kilowatts)", xlab = "")
#dev.off()

#png("plot3.png")
#par(bg = NA)
#plot(smaller$datetime, smaller$Sub_metering_1, type = "l", 
#     ylab = "Energy sub metering", xlab = "")
#points(smaller$datetime, smaller$Sub_metering_2, type = "l", col = "red")
#points(smaller$datetime, smaller$Sub_metering_3, type = "l", col = "blue")
#legend("topright", lty = 1, col = c("black", "red", "blue"), 
#       legend = names(smaller)[7:9])
#dev.off()

#png("plot4.png")
#par(bg = NA, mfcol = c(2,2))
#plot(smaller$datetime, smaller$Global_active_power, type = "l", 
#     ylab = "Global Active Power (kilowatts)", xlab = "")
#plot(smaller$datetime, smaller$Sub_metering_1, type = "l", 
#     ylab = "Energy sub metering", xlab = "")
#points(smaller$datetime, smaller$Sub_metering_2, type = "l", col = "red")
#points(smaller$datetime, smaller$Sub_metering_3, type = "l", col = "blue")
#legend("topright", lty = 1, col = c("black", "red", "blue"), 
#       legend = names(smaller)[7:9])
#with(smaller, plot(datetime, Voltage, type = "l"))
#with(smaller, plot(datetime, Global_reactive_power, type = "l"))
#dev.off()
