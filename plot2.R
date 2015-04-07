
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


#Plot Number 2

png('plot2.png',width = 480, height = 480)

with(my_data,plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)"))

dev.off()
