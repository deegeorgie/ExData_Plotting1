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

##plot3 goes here##

plot3 <- function() {
        
        plot(chosen_dates$timestamp,chosen_dates$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        
        lines(chosen_dates$timestamp,chosen_dates$Sub_metering_2,col="red")
        
        lines(chosen_dates$timestamp,chosen_dates$Sub_metering_3,col="blue")
        
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
        
        dev.copy(png, file="plot3.png", width=480, height=480)
        
        dev.off()
        
        cat("plot3.png has been saved in", getwd())
}
plot3()


