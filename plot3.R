t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
t$Date <- as.Date(t$Date, "%d/%m/%Y") ## Format date to Type Date
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2")) ## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
t <- t[complete.cases(t),] ## Remove incomplete observation
dateTime <- paste(t$Date, t$Time) ## Combine Date and Time column
dateTime <- setNames(dateTime, "DateTime") ## Name the vector
t <- t[ ,!(names(t) %in% c("Date","Time"))] ## Remove Date and Time column
t <- cbind(dateTime, t) ## Add DateTime column
t$dateTime <- as.POSIXct(dateTime) ## Format dateTime Column

## Create plot3
with(
    t,{
        plot(Sub_metering_1~dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~dateTime,col='Red')
        lines(Sub_metering_3~dateTime,col='Blue')
    }
)
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png,"plot3.png", width=480, height=480) ## Save file
dev.off() ##close device