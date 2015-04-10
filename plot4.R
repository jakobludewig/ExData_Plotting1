# Program for creating the fourth plot, requires the file 'household_power_consumption.txt' to be present
# in the working directory

# set the locale so that the weekdays will be printed in english language
Sys.setlocale("LC_ALL","C")

# read in the column names first
header <- read.table(file = "household_power_consumption.txt", nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)

# only read in the relevant data by skipping the first 66636 lines and reading only 2880 rows
data <- read.csv2(file = "household_power_consumption.txt",na.strings="?",skip=66636,nrows=2880,header=TRUE)

# set the variable names of the data frame
colnames(data) <- unlist(header)

# convert the data variable to type 'Date'
data[,1] <- as.Date(strptime(data[,1],"%d/%m/%Y"))

# create an additional variable/column containing the full time stamp of the recording which will be necessary
# for plotting
data <- cbind(data,strptime(paste(data$Date, data$Time),"%Y-%m-%d %H:%M:%S"))
colnames(data)[10] <- "datetime"

# start the png graphics device, see comments in 'plot1.R' for the choice of parameters
png("plot4.png",width=480, height=480)

# create the plot/multiplot
par(mfrow = c(2, 2))
plot(x = data$datetime, y= as.numeric(as.character(data$Global_active_power)),type="o",pch="",ylab="Global Active Power (kilowatts)",xlab="")
plot(x = data$datetime, y= as.numeric(as.character(data$Voltage)),type="o",pch="",ylab="Voltage",xlab="datetime")
plot(x = data$datetime, y= as.numeric(as.character(data$Sub_metering_1)),type="o",pch="",ylab="Energy sub metering",xlab="")
lines(x= data$datetime, y= as.numeric(as.character(data$Sub_metering_2)), type="o", col="red",pch="")
lines(x= data$datetime, y= as.numeric(as.character(data$Sub_metering_3)), type="o", col="blue",pch="")
legend(x="topright", pch = "",lty=rep(1,3), col = c("black","blue" ,"red"),bty="n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),cex=0.9)
plot(x = data$datetime, y= as.numeric(as.character(data$Global_reactive_power)),type="o",pch="",xlab="datetime",ylab="Global_reactive_power")

# close the graphics device
dev.off()
