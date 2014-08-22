#read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(plyr)

#make a new dataframe shows the total emission for each year
UStotal <- ddply(NEI,.(year), summarize, sum = sum(Emissions))
UStotal <- transform(UStotal, year = as.numeric(year))

#make barplot under base plotting system.
barplot(UStotal$sum, names.arg = UStotal$year, main = "Total PM2.5 Emissions(U.S.1999-2008)", col = "red", xlab = "Year", ylab = "Total PM2.5 Emission(tons)")
dev.copy(png, file="plot1.png")
dev.off