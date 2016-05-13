### read data

zip<-tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", zip)
dat<-read.table(unz(zip, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")
unlink(zip)

### subset date

dat$Date <- as.Date(as.character(dat$Date), "%d/%m/20%y")
Date1 <- as.Date("2007-02-01") 
Date2 <- as.Date("2007-02-02")
dat<-subset(dat, Date %in% Date1:Date2, select = 1:9)

### merge time and date variables

datetime<-as.POSIXct(paste(dat$Date, dat$Time), format="%Y-%m-%d %H:%M:%S")
dat2<-cbind(datetime, dat)

### plot settings

png(file = "plot4.png")
par(mfrow = c(2,2))

### plot 1

with(dat2, 
     plot(datetime, 
          Global_active_power, 
          type = "l",
          xlab = "",
          ylab = "Global Active Power"
     ))

### plot 2

with(dat2, 
     plot(datetime, 
          Voltage, 
          type = "l",
          xlab = "datetime",
          ylab = "Voltage"
     ))

### plot 3

with(dat2, 
     plot(datetime, 
          Sub_metering_1, 
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"))
with(dat2, 
     lines(x = datetime,
           y = Sub_metering_2,
           col = "red"))

with(dat2, 
     lines(x = datetime,
           y = Sub_metering_3,
           col = "blue"))

legend("topright",
       pch = c("-","-","-"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black","red","blue"),
       bty = "n" )

### plot 4

with(dat2, 
     plot(datetime, 
          Global_reactive_power, 
          type = "l",
          xlab = "datetime",
          ylab = "Global_reactive_power"
     ))

dev.off()