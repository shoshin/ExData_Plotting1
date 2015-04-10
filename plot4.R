
# The dataset has 2,075,259 rows and 9 columns. A rough estimate of the memory requirements:
# From the course Programming R, is number of rows * number of columns * 8 bytes
# so here 2,075,259 * 9 * 8 bytes =  149,418,648/1,048,576 = 142.496727 MB 
# Not that big really.  :)  So I will read it all in

#Check to see if the data file is available.  If it isn't download from the location and unzip it

location <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("household_power_consumption.txt")) {
	download.file(location,"household_power_consumption.zip")
	unzip("household_power_consumption.zip")
	unlink("household_power_consumption.zip")
}

#Read the data
read_data <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?",stringsAsFactors = FALSE)

#Subset the data for just the days of interest.  Using the format in the original data file.  No need to convert yet.
my_data <- subset(read_data, subset = (Date == "1/2/2007" | Date == "2/2/2007"))

#remove the larger full data set as we are done with it
rm(read_data)

#Clean up the Date/Time and put it in the correct format
my_data$DateTime<- strptime(paste(my_data$Date,my_data$Time), "%d/%m/%Y %H:%M:%S")

#Plot Number 4
# Went with default white background - for transparent we just add bg="transparent" 
#png('plot4.png',width = 480, height = 480,bg="transparent")

png('plot4.png',width = 480, height = 480)

par(mfrow=c(2,2), mar=c(4,4,2,1))
with(my_data, {
  plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power")
  plot(DateTime, Voltage, type="l")
  plot(DateTime, Sub_metering_1, type="l", ylab="Energy Sub Metering", col = "black")
    points(my_data$DateTime, my_data$Sub_metering_2, type = "l", col = "red")
    points(my_data$DateTime, my_data$Sub_metering_3, type = "l", col = "blue")
    legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"), 
           legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(DateTime, Global_reactive_power, type = "l")
})

dev.off()
