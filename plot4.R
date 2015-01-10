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

##This is plot4 here##
plot4 <- function() {
        
        par(mfrow=c(2,2))
        
        ##PLOT 1
        plot(chosen_dates$timestamp,chosen_dates$Global_active_power, type="l", xlab="", ylab="Global Active Power")
        
        ##PLOT 2
        plot(chosen_dates$timestamp,chosen_dates$Voltage, type="l", xlab="datetime", ylab="Voltage")
        
        ##PLOT 3
        plot(chosen_dates$timestamp,chosen_dates$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        
        lines(chosen_dates$timestamp,chosen_dates$Sub_metering_2,col="red")
        
        lines(chosen_dates$timestamp,chosen_dates$Sub_metering_3,col="blue")
        
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
        
        #PLOT 4
        plot(chosen_dates$timestamp,chosen_dates$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
        
        #OUTPUT
        
        dev.copy(png, file="plot4.png", width=480, height=480)
        
        dev.off()
        
        cat("plot4.png will be saved in", getwd())
}
plot4()

