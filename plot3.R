if(!exists("pmData")) {
  pmData <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
}
if(!exists("sourceCodes")) {
  sourceCodes <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
}

library(ggplot2)

# Subset Baltimore data and aggregate emissions by year and type
baltimoreData <- pmData[pmData$fips == "24510", ]
aggByYearAndType <- aggregate(Emissions ~ year + type, data = baltimoreData, FUN = sum)

# Create and save the ggplot
png("plot3.png", width = 640, height = 480)
g <- ggplot(aggByYearAndType, aes(x = factor(year), y = Emissions, color = type)) +
      geom_line(aes(group = type)) +
      xlab("Year") +
      ylab(expression("Total PM"[2.5]*" Emissions")) +
      ggtitle("PM2.5 Emissions in Baltimore by Source Type")
print(g)
dev.off()