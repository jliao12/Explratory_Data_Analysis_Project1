#loading the package
library(dplyr)
#loading the table
HPC <- read.csv("household_power_consumption.txt", sep = ";")

#remove rows with "?"
HPCN <- filter(HPC, HPC$Global_active_power !="?")

#subset for 2007/02/01 to 2007/02/02
df <- filter(HPCN, Date == "1/2/2007" | Date == "2/2/2007")

#create a new colume with combine Date and Time and reformat
df$date <- paste(df$Date, df$Time, sep = " ")
df$date <- strptime(df$date, "%d/%m/%Y %H:%M:%S")

#creating plot 4
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)
par(mfrow = c(2,2))
with(df, plot(df$date,df$Global_active_power, 
              type = "l", xlab = "", ylab = "Global Active Power(kilowatts)"))

with(df, plot(df$date,df$Voltage, 
              type = "l", xlab = "datetime", ylab = "Voltage"))

plot(df$date, df$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
points(df$date, df$Sub_metering_1, type = "l", col = "Black")
points(df$date, df$Sub_metering_2, type = "l", col = "Red")
points(df$date, df$Sub_metering_3, type = "l", col = "Blue")
temp <- legend("topright", legend = c(" "," "," "),
               text.width = 10,
               lty = c(1,1,1), bty = "n", xjust = 1, yjust = 1,
               col = c("Black", "Red", "Blue"), x.intersp = 7, y.intersp = 0.3,)
text(temp$rect$left + temp$rect$w, temp$text$y, 
     c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), pos = 2)

with(df, plot(df$date,df$Global_reactive_power, 
              type = "l", xlab = "datetime", ylab = "Global Reactive Power"))

dev.copy(png, file = "plot4.png")
dev.off()





