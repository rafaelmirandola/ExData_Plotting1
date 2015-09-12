## Plot 2 Script

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
## Creates png file and plots graphic
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "transparent")
with(dataframe, plot(Global_active_power ~ Time_and_Date, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()
print("Graph successfully copied to plot2.png")
