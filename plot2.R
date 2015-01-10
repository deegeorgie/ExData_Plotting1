library(data.table)

data <- fread ("household_power_consumption.txt",na.strings="?")

class(data$Date)
class(data$Time)

data$Date <-as.Date(data$Date, format="%d/%m/%Y")
class(data$Date)


##subset the dataset to focus on the dates of interest
chosen_dates <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02"]

##convert the new dataset into a data.frame
chosen_dates <-data.frame(chosen_dates)

# Convert columns to numeric
for(i in c(3:9)) {chosen_dates[,i] <- as.numeric(as.character(chosen_dates[,i]))}

# Create Date_Time variable
chosen_dates$Date_Time <- paste(chosen_dates$Date, chosen_dates$Time)

# Convert Date_Time variable to proper format
chosen_dates <- transform(chosen_dates, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

##Plot 2 goes here##

plot2 <- function() {
        
        plot(chosen_dates$timestamp,chosen_dates$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
        
        dev.copy(png, file="plot2.png", width=480, height=480)
        
        dev.off()
        
}

plot2()
