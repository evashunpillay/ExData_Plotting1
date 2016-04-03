##  Exploratory Data Analysis Assignment 1
## E. Pillay
## Plot 1

## This script collects and cleans data from the he UC Irvine Machine Learning Repository, 
## a popular repository for machine learning datasets. In particular, we will be using the 
## "Individual household electric power consumption Data Set" 
## 
## A full description of the data can be found here:
##
## http://archive.ics.uci.edu/ml/
##
## The actual data can be downloaded here:
##
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##
## THis script performs the following function:
##
## 1) Downloads and extracts the data (if necessary)
## 2) Reads in all the text file into R
## 3) Convert dates and times to the the relevant formats
## 4) Plots a histogram of GLobal Active Power

rm(list=ls())

# download file if need be 
if (!file.exists("household_power_consumption.zip")){
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, destfile = "household_power_consumption.zip")
}

# unzip file if necessary
if (!file.exists("household_power_consumption")){
  unzip("household_power_consumption.zip", exdir = "household_power_consumption")
}  

# read in files from household_power_consumption Dataset folder
setwd("household_power_consumption")
power_table <- read.table("household_power_consumption.txt",header = TRUE, sep = ";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings=c("?"))

# Use date and time columns to obtain the correct time data type
timestamp <- paste(power_table$Date, power_table$Time)
timestamp <- strptime(timestamp, format = "%d/%m/%Y %H:%M:%S")
power_table$Time <- timestamp

# convert first column to dates
power_table$Date <- as.Date(power_table$Date, format = "%d/%m/%Y")

# create a subset that includes only data for the days 2007-02-01 and 2007-02-02
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")
date_index <- (power_table$Date >= date1) & (power_table$Date <= date2)
power_table_sub <- power_table[date_index,]
rm(power_table)
rm(timestamp)
rm(date_index)


# plot the histogram
par(mfrow = c(1, 1))
hist(power_table_sub$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png,'plot1.png', width=480, height=480)
dev.off()