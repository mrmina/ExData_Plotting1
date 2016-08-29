# initialize download url and filenames 
zipFilename <- "household_power_consumption.zip"
zipDir <- "./data"
dataFile <- paste(zipDir, "/household_power_consumption.txt", sep="")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## if the data zip wasn't present, will download the file
if (!file.exists(zipFilename)){
  download.file(url, zipFilename, method="curl")
}

## check if the data dir that will be used to extraxct the data file exists. If not, create it.
if (!dir.exists(zipDir)){
  dir.create(zipDir)
}

# if the zip was downloaded successfully, unzip it
if (file.exists(zipFilename)){
  unzip(zipFilename, exdir = zipDir)
}

# check if the data file was extracted successfully. If not abort!
if (!file.exists(dataFile)){
  stop("couldn't find data file after unzipping")
}


# loading data file
d <- read.table(dataFile,header=TRUE,sep=';',na.strings='?')

# seleccting a subset of the data to be analyzed
d2 <- d[d$Date=='1/2/2007' | d$Date=='2/2/2007',]

# Converting Date and Time field from characted field to a Date/Time field
# and strong them in a new field named: DateTime
d2$DateTime <- paste(d2$Date, d2$Time)
d2$DateTime <- strptime(d2$DateTime, "%d/%m/%Y %H:%M:%S")


## Plot 3
png(filename = "plot3.png",width = 480, height = 480, units = "px")
plot(d2$DateTime ,d2$Sub_metering_1 ,type="l", xaxt="n", xlab="", ylab="Energy sub metering")
axis.POSIXct(1, d2$DateTime, format="%A")
points(d2$DateTime ,d2$Sub_metering_2, col="red", type="l")
points(d2$DateTime ,d2$Sub_metering_3, col="blue", type="l")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),  lty="solid", col=c("black", "red", "blue"),  xjust=0)
dev.off()

