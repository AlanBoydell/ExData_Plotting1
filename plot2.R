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


# Build the plot with plot symbol set to NA (as we want to add a line with no visible points)
plot(
        data$dateAndTime, 
        data$Global_active_power, 
        pch = NA, 
        xlab = "", 
        ylab = "Global Active Power (kilowatts)"
)

# Add a line to the plot with the same x and y values
lines(
        data$dateAndTime, 
        data$Global_active_power
)

# Copy from RStudio to PNG device
dev.copy(png, filename = "plot2.png", height = 480, width = 480)

# Close the graphics device and thus generate the .png file
dev.off()
