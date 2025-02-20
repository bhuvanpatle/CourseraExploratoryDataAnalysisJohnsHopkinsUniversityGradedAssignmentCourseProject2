if(!exists("pmData")) {
  pmData <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
}
if(!exists("sourceCodes")) {
  sourceCodes <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
}

library(ggplot2)

# Identify motor vehicle-related sources using the SCC.Level.Two field
vehicleFilter <- grepl("vehicle", sourceCodes$SCC.Level.Two, ignore.case = TRUE)
vehicleSCC <- sourceCodes$SCC[vehicleFilter]

# Subset data for Baltimore City and motor vehicle sources
baltimoreVehicleData <- pmData[pmData$fips == "24510" & pmData$SCC %in% vehicleSCC, ]
aggBaltimoreVehicle <- aggregate(Emissions ~ year, data = baltimoreVehicleData, FUN = sum)

# Create and save the plot
png("plot5.png", width = 640, height = 480)
g <- ggplot(aggBaltimoreVehicle, aes(x = factor(year), y = Emissions)) +
      geom_bar(stat = "identity", fill = "blue") +
      xlab("Year") +
      ylab(expression("Total PM"[2.5]*" Emissions")) +
      ggtitle("Motor Vehicle PM2.5 Emissions in Baltimore")
print(g)
dev.off()
