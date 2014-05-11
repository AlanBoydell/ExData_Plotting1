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
png("plot3.png", height=480, width=480)

# Build the plot with plot symbol set to NA (what we use as a y value is not important as it will not appear)
plot(
        data$dateAndTime, 
        data$Sub_metering_1, 
        pch=NA, 
        xlab="", 
        ylab="Energy sub metering"
)

# Add 3 lines to the plot 
lines(data$dateAndTime, data$Sub_metering_1)
lines(data$dateAndTime, data$Sub_metering_2, col = 'red')
lines(data$dateAndTime, data$Sub_metering_3, col = 'blue')

# Add a legend in top right corner
legend(
        'topright', 
        lwd = 1,
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
        col = c('black', 'red', 'blue')
)

# Close the graphics device and thus generate the .png file
dev.off()