# Program for creating the first plot, requires the file 'household_power_consumption.txt' to be present
# in the working directory

# read in the column names first
header <- read.table(file = "household_power_consumption.txt", nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)

# only read in the relevant data by skipping the first 66636 lines and reading only 2880 rows
data <- read.csv2(file = "household_power_consumption.txt",na.strings="?",skip=66636,nrows=2880,header=TRUE)

# set the variable names of the data frame
colnames(data) <- unlist(header)

# convert the data variable to type 'Date'
data[,1] <- as.Date(strptime(data[,1],"%d/%m/%Y"))

# start the png graphics device, set the correct width and height (although default values would do the same).
# the background could be set to transparent by using the 'bg = "transparent"' parameter to png(). For better
# readability when opening the file outside of a browser we will go with the default white background
png("plot1.png",width=480, height=480)

# create the plot
hist(as.numeric(as.character(data$Global_active_power)),col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")

# close the graphics device
dev.off()