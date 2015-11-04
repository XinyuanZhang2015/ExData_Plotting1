# reading and subsetting, and cleaning data
epc <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", 
                  stringsAsFactors = FALSE, dec = ".", na.strings = "?")
subepc <- epc[epc$Date %in% c("1/2/2007", "2/2/2007"),]
subepcCopy <- subepc    # create a copy of subset in case of error
subepc$Date = as.Date(subepc$Date, format = "%d/%m/%Y")
datetime <- paste(as.Date(subepc$Date), subepc$Time)
subepc$datetime <- as.POSIXct(datetime) 
subepc$Global_active_power = as.numeric(subepc$Global_active_power)
subepc$Global_reactive_power = as.numeric(subepc$Global_reactive_power)
subepc$Voltage = as.numeric(subepc$Voltage)
subepc$Global_intensity = as.numeric(subepc$Global_intensity)
subepc$Sub_metering_1 = as.numeric(subepc$Sub_metering_1)
subepc$Sub_metering_2 = as.numeric(subepc$Sub_metering_2)

# plot 4
par(mfrow=c(2,2), oma=c(0,0,2,0), mar=c(4,4,2,1))
with(subepc, {
      plot(Global_active_power~datetime, type="l", 
           ylab="Global Active Power (kilowatts)", xlab="")
      plot(Voltage~datetime, type="l", 
           ylab="Voltage (volt)")
      plot(Sub_metering_1~datetime, type="l", 
           ylab="Global Active Power (kilowatts)", xlab="")
      lines(Sub_metering_2~datetime,col='Red')
      lines(Sub_metering_3~datetime,col='Blue')
      legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, bty="n",
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(Global_reactive_power~datetime, type="l", 
           ylab="Global Rective Power (kilowatts)")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
