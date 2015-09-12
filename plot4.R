## Plot 4 Script

## Checks if the file containing the data is located in working directory
if(!file.exists("exdata-data-household_power_consumption.zip")==TRUE){
        print("Please copy power consumption data to working directory!")
}
## Reassures user that R is reading the file
print("Database located, reading file")
## Unzips the main database
unzip("exdata-data-household_power_consumption.zip")
fn <- "household_power_consumption.txt"
## Reads data from specific days and reassures user again
library(sqldf)
dataframe <- read.csv.sql(fn, sep = ";", sql = 'select * from file where Date = "1/2/2007" OR Date ="2/2/2007"')
print("Read file from days 01-02-2007 and 02-02-2007")
## Transforms date and time into POSIXct class and adds that column to the data
dataframe$Date <- as.Date(dataframe$Date, format="%d/%m/%Y")
Time_and_Date <- paste(as.Date(dataframe$Date), dataframe$Time)
dataframe$Time_and_Date <- as.POSIXct(Time_and_Date)
## Sets weekdays to English 
Sys.setlocale("LC_TIME", "English")
## Creates blank png file 480x480 pixels and plot graphics
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mfrow=c(2,2))
## First graphic (Top-left)
with(dataframe, plot(Global_active_power ~ Time_and_Date, type="l",xlab="",ylab="Global Active Power"))
## Second graphic (Top-right)
with(dataframe, plot(Voltage ~ Time_and_Date, type="l", xlab="datetime",ylab="Voltage"))
## Thrid graphic (Bottom-left)
with(dataframe, plot(Sub_metering_1 ~ Time_and_Date, type="l", ylab="Energy sub metering", xlab=""))
with(dataframe, lines(Sub_metering_2 ~ Time_and_Date, col="red"))
with(dataframe, lines(Sub_metering_3 ~ Time_and_Date, col="blue"))
with(dataframe, legend("topright", col=c("black","red","blue"),lty=1,bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")))
## Fourth graphic (Bottom-right)
with(dataframe, plot(Global_reactive_power ~ Time_and_Date, type="l",xlab="datetime",ylab="Global_reactive_power"))
## Saves plot4 to PNG file
dev.off()
print("Graph successfully copied to plot4.png")