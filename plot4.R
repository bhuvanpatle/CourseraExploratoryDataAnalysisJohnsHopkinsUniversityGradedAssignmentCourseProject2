if(!exists("pmData")) {
  pmData <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
}
if(!exists("sourceCodes")) {
  sourceCodes <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
}

# Merge the two datasets for detailed source information
if(!exists("pmSCCData")) {
  pmSCCData <- merge(pmData, sourceCodes, by = "SCC")
}

library(ggplot2)

# Identify coal-related records by searching for "coal" in the Short.Name field
coalMatches <- grepl("coal", pmSCCData$Short.Name, ignore.case = TRUE)
coalData <- pmSCCData[coalMatches, ]

# Aggregate emissions by year for coal sources
aggCoal <- aggregate(Emissions ~ year, data = coalData, FUN = sum)

# Create and save the plot
png("plot4.png", width = 640, height = 480)
g <- ggplot(aggCoal, aes(x = factor(year), y = Emissions)) +
      geom_bar(stat = "identity", fill = "brown") +
      xlab("Year") +
      ylab(expression("Total PM"[2.5]*" Emissions")) +
      ggtitle("Coal Combustion PM2.5 Emissions in the US")
print(g)
dev.off()