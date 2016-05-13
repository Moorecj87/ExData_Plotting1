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

png(file = "plot1.png")
hist(dat$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)"
)
dev.off()
