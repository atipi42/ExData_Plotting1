source("load_power_prefilter.R")

plot3 <- function() {
  ## reading data
  ## it assumes that "household_power_consumption.txt" is in the working directory
  ## if not it exits
  data<-load_power_prefilter()
  
  png("plot3.png",width = 480, height=480, units = "px")
  
  plot(data$DateTime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n")
  axis.POSIXct(1, at = seq(min(data$DateTime), max(data$DateTime)+24*3600, by = "day"), format = "%a")
  lines(data$DateTime, data$Sub_metering_2, col = "red")
  lines(data$DateTime, data$Sub_metering_3, col = "blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
  
  dev.off()
}