# Read the entire dataset, setting the right seperator, classes and NA symbol
data <- read.table(
        'household_power_consumption.txt', 
        sep=';', 
        header=TRUE, 
        colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'),
        na.strings='?'
)

# Subset the first and second of February using the pipe "|" operator meaning OR
data <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007" ,]

# Add an extra Column to the table that combines both date and time into a calendar format
data$dateAndTime <- strptime(
        paste(data$Date, data$Time),
        "%d/%m/%Y %H:%M:%S"
)

# Configure the PNG file with the right dimensions
png("plot4.png", height=480, width=480)

# Configure the multiplot 2 x 2
par(mfrow=c(2,2))

# Create the Global Active Power plot
plot(
        data$dateAndTime, 
        data$Global_active_power, 
        pch=NA, 
        xlab="", 
        ylab="Global Active Power"
)

# Add the Global Active Power line
lines(data$dateAndTime, data$Global_active_power)

# Create the Voltage plot
plot(
        data$dateAndTime, 
        data$Voltage, 
        ylab="Voltage", 
        xlab="dateTime", 
        pch=NA
)

# Add the Voltage line
lines(data$dateAndTime, data$Voltage)

# Create the Submetering plot
plot(
        data$dateAndTime, 
        data$Sub_metering_1, 
        pch=NA, 
        xlab="", 
        ylab="Energy sub metering"
)

# Add the Submetering lines
lines(data$dateAndTime, data$Sub_metering_1)
lines(data$dateAndTime, data$Sub_metering_2, col='red')
lines(data$dateAndTime, data$Sub_metering_3, col='blue')

# Add the Submetering legend
legend(
        'topright', 
        c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
        lty = 1,
        col = c('black', 'red', 'blue'),
        bty = 'n'
)

# Create the Global reactive power plot
with(data, plot(dateAndTime, Global_reactive_power, xlab='dateTime', pch=NA))

# Add the Global reactive power line
with(data, lines(dateAndTime, Global_reactive_power))

# Close PNG file
dev.off()