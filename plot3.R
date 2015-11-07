################################################################################
# File name: plot3.R                                                           #
# Author: Ralph Hurtado                                                        #
# Last modified: 11/05/15                                                      #
#                                                                              #
# Purpose: Coursera Exploratory Data Analysis Project 1, program 3             #
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
p3data <- read.table(file = "household_power_consumption.txt", header = TRUE,
                     sep = ";", stringsAsFactors = FALSE, na.strings = "?",
                     nrows = numLines, skip = (beginLine - 1))

names(p3data) <- c("Date", "Time", "Global_active_power", "4", "5", "6", "sm1",
                   "sm2", "sm3")

# Open graphics device
png("plot3.png", width = 480, height = 480)
# Generate plot
plot(p3data$sm1, type = "l", ylab = "Energy sub metering", xaxt = "n")
lines(p3data$sm2, col = "red")
lines(p3data$sm3, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = c(1, 1, 1), col = c("black", "red", "blue"))
axis(side = 1, at = c(1, (length(p3data$Date)/2), length(p3data$Date)), 
     labels = c("Thu", "Fri", "Sat"))

# Close graphics device
dev.off()
