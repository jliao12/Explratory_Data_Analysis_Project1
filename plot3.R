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

#creating plot 3
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
plot(df$date, df$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
points(df$date, df$Sub_metering_1, type = "l", col = "Black")
points(df$date, df$Sub_metering_2, type = "l", col = "Red")
points(df$date, df$Sub_metering_3, type = "l", col = "Blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), col = c("Black", "Red", "Blue"), y.intersp = 0.5)
dev.copy(png, file = "plot3.png")
dev.off()
