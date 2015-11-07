################################################################################
# File name: plot2.R                                                           #
# Author: Ralph Hurtado                                                        #
# Last modified: 11/04/15                                                      #
#                                                                              #
# Purpose: Coursera Exploratory Data Analysis Project 1, program 2             #
# Input file: exdata-data-household_power_consumption.txt                      #
# Output file: Plot2.png, Global Active Power line plot                        #
################################################################################

setwd("~/R/coursera/eda/project1/exdata-data-household_power_consumption/")

# Set dates and times - the first date and time were found by reading
# in and inspecting the first 10 rows at the command line
firstDateTime <- strptime("2006-12-16 17:24:00", "%Y-%m-%d %H:%M:%S")
beginDateTime <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")

# Calculate which rows to read in
begin <- beginDateTime - firstDateTime
beginLine <- as.numeric(begin) * 24 * 60 # first row to read in
numLines <- 48 * 60 # total number of minutes in 48 hours

# Read in pertinent data
p2data <- read.table(file = "household_power_consumption.txt", header = TRUE,
                     sep = ";", stringsAsFactors = FALSE, na.strings = "?",
                     nrows = numLines, skip = (beginLine - 1))

names(p2data) <- c("Date", "Time", "Global_active_power", "4", "5", "6", "7",
                   "8", "9")

# Set upper bound on data to plot
bound <- 60 * 48

# Generate plot
plot(p2data[1:bound, 3], type = "l", xlab = "", ylab = "Global Active Power (kw)", xaxt = "n")
axis(side = 1, at = c(1, (length(p2data$Date)/2), length(p2data$Date)), 
     labels = c("Thu", "Fri", "Sat"))

# Copy plot to a .png file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()