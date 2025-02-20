if(!exists("pmData")) {
  pmData <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
}
if(!exists("sourceCodes")) {
  sourceCodes <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
}

library(ggplot2)

# Identify motor vehicle–related sources
vehicleFilter <- grepl("vehicle", sourceCodes$SCC.Level.Two, ignore.case = TRUE)
vehicleSCC <- sourceCodes$SCC[vehicleFilter]

# Subset vehicle data for Baltimore (fips "24510") and Los Angeles (fips "06037")
vehicleData <- pmData[pmData$SCC %in% vehicleSCC, ]
baltimoreVehicle <- subset(vehicleData, fips == "24510")
laVehicle <- subset(vehicleData, fips == "06037")

# Add a city label to each dataset
baltimoreVehicle$City <- "Baltimore, MD"
laVehicle$City <- "Los Angeles, CA"

# Combine the two datasets and aggregate emissions by year and city
combinedVehicle <- rbind(baltimoreVehicle, laVehicle)
aggVehicleByCity <- aggregate(Emissions ~ year + City, data = combinedVehicle, FUN = sum)

# Create and save the comparison plot
png("plot6.png", width = 640, height = 480)
g <- ggplot(aggVehicleByCity, aes(x = factor(year), y = Emissions, fill = City)) +
      geom_bar(stat = "identity", position = "dodge") +
      xlab("Year") +
      ylab(expression("Total PM"[2.5]*" Emissions")) +
      ggtitle("Motor Vehicle PM2.5 Emissions: Baltimore vs. Los Angeles")
print(g)
dev.off()