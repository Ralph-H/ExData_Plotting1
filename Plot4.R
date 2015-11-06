################################################################################
# File name: plot4.R                                                           #
# Author: Ralph Hurtado                                                        #
# Last modified: 11/04/15                                                      #
#                                                                              #
# Purpose: Coursera Exploratory Data Analysis Project 1, file 1                #
# Input file: exdata-data-household_power_consumption.txt                      #
# Output file: Plot3.png, Sub_metering_x line plot, for x = 1, 2, & 3          #
################################################################################

setwd("~/R/coursera/eda/project1/exdata-data-household_power_consumption/")

# Set dates and times - the first date and time were found by reading
# in and inspecting the first 10 rows at the command line
firstDateTime <- strptime("2006-12-16 17:24:00", "%Y-%m-%d %H:%M:%S")
beginDateTime <- strptime("2007-02-01 00:01:00", "%Y-%m-%d %H:%M:%S")

# Calculate which rows to read in
begin <- beginDateTime - firstDateTime
beginLine <- as.numeric(begin) * 24 * 60 # first row to read in
numLines <- 48 * 60 # total number of minutes in 48 hours

# Read in pertinent data
p4data <- read.table(file = "household_power_consumption.txt", header = TRUE,
                     sep = ";", stringsAsFactors = FALSE, na.strings = "?",
                     nrows = numLines, skip = (beginLine - 1))

names(p4data) <- c("Date", "Time", "gap", "grp", "v", "gi", "sm1",
                   "sm2", "sm3")

# Open png device
png("Plot4.png", width = 480, height = 480)
# Set for 2 x 2 array of plots
par(mfrow = c(2, 2))


# Plot global active power
plot(p4data$gap, type = "l", ylab = "Global Active Power", xlab = "", xaxt = "n")
axis(side = 1, at = c(1, (length(p4data$Date)/2), length(p4data$Date)), 
     labels = c("Thu", "Fri", "Sat"))

# Plot voltage
plot(p4data$v, type = "l", ylab = "Voltage", xlab = "datetime", xaxt = "n")
axis(side = 1, at = c(1, (length(p4data$Date)/2), length(p4data$Date)), 
     labels = c("Thu", "Fri", "Sat"))

# Plot energy sub metering
plot(p4data$sm1, type = "l", ylab = "Energy sub metering", xlab = "", xaxt = "n")
lines(p4data$sm2, col = "red")
lines(p4data$sm3, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", lwd = c(1, 1, 1), col = c("black", "red", "blue"))
axis(side = 1, at = c(1, (length(p4data$Date)/2), length(p4data$Date)), 
     labels = c("Thu", "Fri", "Sat"))

# Plot global reactive power
plot(p4data$grp, type = "l", ylab = "Global_reactive_power", xlab = "datetime", xaxt = "n")
axis(side = 1, at = c(1, (length(p4data$Date)/2), length(p4data$Date)), 
     labels = c("Thu", "Fri", "Sat"))
# Copy plot to a .png file
dev.off()