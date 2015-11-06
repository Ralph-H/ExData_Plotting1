################################################################################
# File name: plot1.R                                                         #
# Author: Ralph Hurtado                                                        #
# Last modified: 11/03/15                                                      #
#                                                                              #
# Purpose: Coursera Exploratory Data Analysis Project 1, file 1                #
# Input file: exdata-data-household_power_consumption.txt                      #
# Output file: Plot1.png, Global Active Power plot                             #
################################################################################

setwd("~/R/coursera/eda/project1/exdata-data-household_power_consumption/")

# Set dates and times - the first date and time were found by reading
# in and inspecting the first 10 rows at the command line
firstDateTime <- strptime("2006-12-16 17:24:00", "%Y-%m-%d %H:%M:%S")
beginDateTime <- strptime("2007-02-01 00:01:00", "%Y-%m-%d %H:%M:%S")

# Calculate which lines to read in
begin <- beginDateTime - firstDateTime
beginLine <- as.numeric(begin) * 24 * 60 # first line to read in
numLines <- 48 * 60 # total number of minutes in 48 hours

# Read in pertinent data
p1data <- read.table(file = "household_power_consumption.txt", header = TRUE,
                     sep = ";", stringsAsFactors = FALSE, na.strings = "?",
                     nrows = numLines, skip = (beginLine - 1))

names(p1data) <- c("Date", "Time", "Global_active_power", "4", "5", "6", "7",
                   "8", "9")

# Generate plot
hist(p1data$Global_active_power, col = "red", breaks = 11, 
        main = "Global Active Power", ylim = c(0, 1299), 
        xlab = "Global Active Power (kilowatts)")

# Copy plot to a .png file
dev.copy(png, file = "Plot1.png", width = 480, height = 480)
dev.off()