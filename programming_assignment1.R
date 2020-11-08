#Just to be sure of the current directory
getwd()

#Reads the .txt document, using na.strings="?" because it is specified as the value for NA
rawdata<- read.delim("household_power_consumption.txt", header=TRUE, sep=";", dec=".", na.strings = "?",stringsAsFactor = FALSE)
class(rawdata)

#Creates and auxiliar variable called x concatenating date and time columns
rawdata$x <- paste(rawdata$Date, rawdata$Time)

#Creates the variable DateTime formatting the x variable using strptime
rawdata$DateTime <-strptime(rawdata$x, "%d/%m/%Y %H:%M:%S")

#Overwrites the variable Date with format proper format.
rawdata$Datefmt<-as.Date(rawdata$DateTime)
rawdata

str(rawdata)
data <- rawdata[rawdata$Datefmt >= "2007-02-01" & rawdata$Datefmt <= "2007-02-02",]
data
str(data)

hist(data$Global_active_power, ylim=c(0,1200), main="Global Active Power", xlab="Global Active Power kilowatts", col="red")
dev.copy(png, file="Plot 1.Global Active Power Histogram.png")
dev.off()

#example(points)

plot(data$DateTime, data$Global_active_power, type="l", ylab="Global Active Power kilowatts")
dev.copy(png, file="Plot 2.Global Active Power Serie.png")
dev.off()

plot(data$DateTime, data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"),pch="_")
dev.copy(png, file="Plot 3.Energy submetering multiple lines.png")
dev.off()

par(mfrow=c(2,2))
plot(data$DateTime, data$Global_active_power, type="l", ylab="Global Active Power kilowatts",xlab="")

plot(data$DateTime, data$Voltage, type="l",xlab="")

plot(data$DateTime, data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"),pch="_")

plot(data$DateTime, data$Global_reactive_power, type="l", ylab="Global Reactive Power kilowatts",xlab="")
dev.copy(png, file="Plot 4.Overview graphs.png")
dev.off()
