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

### plot 

png(file = "plot2.png")
with(dat2, 
     plot(datetime, 
          Global_active_power, 
          type = "l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"
))
dev.off()
