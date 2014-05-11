## plot1.R 

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

# Build the histogram, so as to preview in RStudio
hist(
        data$Global_active_power, 
        col = "red", 
        main = "Global Active Power", 
        xlab= "Global Acrive Power (kilowatts)"
)

# Copy the histogram from RStudio to PNG device
dev.copy(png, filename = "plot1.png", height = 480, width = 480)

# Close the graphics device and thus generate the .png file
dev.off()