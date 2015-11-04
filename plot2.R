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

# plot 2
plot(subepc$datetime, subepc$Global_active_power, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()