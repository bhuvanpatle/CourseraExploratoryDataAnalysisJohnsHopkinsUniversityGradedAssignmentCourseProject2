if(!exists("pmData")) {
  pmData <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
}
if(!exists("sourceCodes")) {
  sourceCodes <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
}

# Subset data for Baltimore City (fips == "24510")
baltimoreData <- pmData[pmData$fips == "24510", ]

# Aggregate emissions by year for Baltimore
aggBaltimore <- aggregate(Emissions ~ year, data = baltimoreData, FUN = sum)

# Plot and save as PNG
png("plot2.png", width = 480, height = 480)
barplot(height = aggBaltimore$Emissions,
        names.arg = aggBaltimore$year,
        xlab = "Year",
        ylab = expression("Total PM"[2.5]*" Emission"),
        main = expression("PM"[2.5]*" Emissions in Baltimore City"))
dev.off()