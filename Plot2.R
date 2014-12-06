# Exploratory Data Analysis: Course Project 1
# Plot 2

################################################
# INSTALL data.table package to your library
# DATA FILE "household_power_consumption.txt" must be in the working directory
################################################

library(data.table)

# Begining date of data gathered is 1/2/2007
bd <- "1/2/2007"

# Calculate the number of rows to read in nr = days * 24hrs/day * 60min/hr
# In this appplication we are gathering 2 days of data
nr <- 2 * 24 * 60

# Read only necessary data
sub_hpc <- fread("household_power_consumption.txt",
              sep=";",
              colClasses = c("character", "character", "numeric", "numeric", 
                             "numeric", "numeric", "numeric", "numeric", "numeric"),
              na.strings = c("?",""),
              skip = bd,
              nrows = nr,
              data.table = FALSE)

# Add column names to data
colnames(sub_hpc) <- colnames(fread("household_power_consumption.txt",
                                   nrows = 0,
                                   data.table = FALSE))

# Combine date and time into one column and convert to time variable
datetime <- strptime(paste(sub_hpc[,1], sub_hpc[,2], 
                     sep = " "), 
               format = "%d/ %m/ %Y %H:%M:%S")

# Create data with time and household power consumption
data <- cbind(datetime, sub_hpc[,-(1:2)])

# Plot 2
png(filename = "plot2.png",
    width = 480, height = 480, units = "px") 
par(mar = c(4,4,4,4))
plot(data$datetime, data$Global_active_power, type="l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")
