source("load_power_prefilter.R")

plot1 <- function() {
  ## reading data
  ## it assumes that "household_power_consumption.txt" is in the working directory
  ## if not it exits
  data<-load_power_prefilter()
  
  png("plot1.png",width = 480, height=480, units = "px")
  hist(data$Global_active_power, col ="red", xlab = "Global Active Power (kilowatts)",main = "Global Active Power")
  dev.off()
}