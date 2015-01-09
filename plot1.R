#
# Project Assignment# 1: Exploratory Data Analysis
# Author: Girish Sherikar
#
# Read in the data supplied
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

# Open a graphics device in the form of PNG file in current working directory with specified pixels/size
png(filename="plot1.png",width=480,height=480)
# Plot the histogram
hist(consumptionDataSubset$Global_active_power,xlab="Global Active Power (kilowatts)", ylab="Frequency",col="red",main="Global Active Power")
# Close the graphics device, the PNG file
dev.off()

# Write out the subset data table so subsequent code can use the same instead of reading entire data again
write.table(consumptionDataSubset,col.names=TRUE,"./exdata_data_household_power_consumption/household_power_consumption_subset.txt",row.names=FALSE)

