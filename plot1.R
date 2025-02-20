# Read in the PM2.5 data and source classification codes
if(!exists("pmData")) {
  pmData <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
}
if(!exists("sourceCodes")) {
  sourceCodes <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
}

# Aggregate total emissions by year
aggTotalByYear <- aggregate(Emissions ~ year, data = pmData, FUN = sum)

# Create the plot and save as PNG
png("plot1.png", width = 480, height = 480)
barplot(height = aggTotalByYear$Emissions,
        names.arg = aggTotalByYear$year,
        xlab = "Year",
        ylab = expression("Total PM"[2.5]*" Emission"),
        main = expression("Total PM"[2.5]*" Emissions over Years"))
dev.off()
