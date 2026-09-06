source("load_power_prefilter.R")

plot4 <- function() {
  ## reading data
  ## it assumes that "household_power_consumption.txt" is in the working directory
  ## if not it exits
  data<-load_power_prefilter()
  
  png("plot4.png",width = 480, height=480, units = "px")

  ## Configure 2x2 grid
  par(mfcol = c(2,2))
  
  ## Top-left
  ## plot2
  plot(data$DateTime,data$Global_active_power,type="l", xlab ="", ylab="Global Active Power (kilowatts)", xaxt = "n")
  axis.POSIXct(1, at = seq(min(data$DateTime), max(data$DateTime)+24*3600, by = "day"), format = "%a")
  
  ## Bottom-left
  ## plot3
  plot(data$DateTime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n")
  axis.POSIXct(1, at = seq(min(data$DateTime), max(data$DateTime)+24*3600, by = "day"), format = "%a")
  lines(data$DateTime, data$Sub_metering_2, col = "red")
  lines(data$DateTime, data$Sub_metering_3, col = "blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
  
  ## Top-right
  ## Voltage 
  plot(data$DateTime,data$Voltage,type="l", xlab ="datetime", ylab="Voltage", xaxt = "n")
  axis.POSIXct(1, at = seq(min(data$DateTime), max(data$DateTime)+24*3600, by = "day"), format = "%a")
  
  ## Bottom-right
  ## Global Reactive Power
  plot(data$DateTime,data$Global_reactive_power,type="l", xlab ="datetime", ylab="Globa_reactive_power", xaxt = "n")
  axis.POSIXct(1, at = seq(min(data$DateTime), max(data$DateTime)+24*3600, by = "day"), format = "%a")
  
  dev.off()
}