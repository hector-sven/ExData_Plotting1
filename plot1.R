t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
t$Date <- as.Date(t$Date, "%d/%m/%Y") ## Format date to Type Date
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2")) ## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
t <- t[complete.cases(t),] ## Remove incomplete observation
dateTime <- paste(t$Date, t$Time) ## Combine Date and Time column
dateTime <- setNames(dateTime, "DateTime") ## Name the vector
t <- t[ ,!(names(t) %in% c("Date","Time"))] ## Remove Date and Time column
t <- cbind(dateTime, t) ## Add DateTime column
t$dateTime <- as.POSIXct(dateTime) ## Format dateTime Column

## Create plot1
hist(t$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="Red")  ## Save file and close device
dev.copy(png,"plot1.png", width=480, height=480) ## Save file
dev.off() ##close device