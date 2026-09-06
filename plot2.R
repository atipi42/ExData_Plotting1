source("load_power_prefilter.R")

plot2 <- function() {
  ## reading data
  ## it assumes that "household_power_consumption.txt" is in the working directory
  ## if not it exits
  data<-load_power_prefilter()
  
  png("plot2.png",width = 480, height=480, units = "px")
  
  plot(data$DateTime,data$Global_active_power,type="l", xlab ="", ylab="Global Active Power (kilowatts)", xaxt = "n")
  axis.POSIXct(1, at = seq(min(data$DateTime), max(data$DateTime)+24*3600, by = "day"), format = "%a")
  
  dev.off()
}