#
# Project Assignment# 1: Exploratory Data Analysis
# Author: Girish Sherikar
# plot3.R
#
# Read in the data supplied and store data in memory

if (!file.exists("./exdata_data_household_power_consumption/household_power_consumption_subset.txt")) {
        fileUrl <- "./exdata_data_household_power_consumption/household_power_consumption.txt"
        
        consumptionData <- read.table(fileUrl,sep=";",header=TRUE,
                                      stringsAsFactors=FALSE,na.strings=NA,
                                      colClasses=c("factor","factor","character",
                                                   "character","character","character","character","character","character"))
        # Convert date column into Date type column so we can easily filter based on date instead of character comparison
        consumptionData$Date <- as.Date(consumptionData$Date,format="%d/%m/%Y")
        
        # prepare subset of consumption data
        consumptionDataSubset <-consumptionData[(consumptionData$Date=="2007-02-01" | consumptionData$Date=="2007-02-02") ,]
        
        
        rm(consumptionData) # Clear up  memory
        
        # columns 3 thru 9 are numeric so conver them to numeric 
        for (i in seq(3,9)) {
                consumptionDataSubset[,i] <- as.numeric(consumptionDataSubset[,i])
        }
        
} else {
        fileUrl <- "./exdata_data_household_power_consumption/household_power_consumption_subset.txt"
        
        consumptionDataSubset <- read.table(fileUrl,header=TRUE,
                                      stringsAsFactors=FALSE,na.strings=NA,
                                      colClasses=c("Date","factor","numeric",
                                                  "numeric","numeric","numeric","numeric","numeric","numeric"))
        
}

# Combine the time with date and store in the date column
consumptionDataSubset$Date <- as.POSIXct(paste(strftime(consumptionDataSubset$Date, format="%Y-%m-%d"),consumptionDataSubset$Time),format="%Y-%m-%d %H:%M:%S")

# Open a graphics device in the form of PNG file in current working directory with specified pixels/size
png(filename="plot3.png",width=480,height=480)

# Prepare line plot
plot(consumptionDataSubset$Date,consumptionDataSubset$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
points(consumptionDataSubset$Date,consumptionDataSubset$Sub_metering_2,type="l",col="red")
points(consumptionDataSubset$Date,consumptionDataSubset$Sub_metering_3,type="l",col="blue")
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# Close the graphics device, the PNG file
dev.off()

