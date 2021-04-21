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

#creating plot 2
df$Global_active_power <- as.numeric(df$Global_active_power)
with(df, plot(df$date,df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power(kilowatts)"))
dev.copy(png, file = "plot2.png")
dev.off()