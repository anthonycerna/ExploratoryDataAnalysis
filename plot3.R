#------------------------------------------------------------------------------
####### Load Data
electric <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

#Convert date column from factor to date
electric$Date <- as.Date(electric$Date, "%d/%m/%Y")

#subset data to only include desired dates
electric <- subset(electric, Date == as.Date("2007-02-01") | 
                     Date == as.Date("2007-02-02"))

#combine both date and time column to form one continuouse date/time column
electric$Date.Time <- as.POSIXct(paste(electric$Date, electric$Time), 
                                 format="%Y-%m-%d %H:%M:%S")
#Re-order columns
electric <- electric[,c(1,2,10,3:9)]

#make all columns numeric, except for the date and time columns
electric[4:10] <- sapply(electric[4:10],  function(x) as.numeric(as.character(x)))
sapply(electric, class)

#------------------------------------------------------------------------------
######## Plot 3
png("plot3.png")
with(electric, plot(Date.Time, Sub_metering_1, type="l", xlab="",
                    ylab="Energy sub metering"))
with(electric, points(Date.Time, Sub_metering_2, type="l", col="red"))
with(electric, points(Date.Time, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
#------------------------------------------------------------------------------