#read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#dubsut the data for Baltimore City
Bal <- subset(NEI, fips == "24510")

#make a new dataframe "BalTotal" to show the total emission 
#in Baltimore city for each year.
library(plyr)
BalTotal <- ddply(BC,.(year), summarize, sum = sum(Emissions))

#make the barplot under base plotting system.
barplot(BalTotal$sum, names.arg = BalTotal$year, main = "Baltimore City PM2.5 Emissions(U.S.1999-2008)", col = "red", xlab = "Year", ylab = "Baltimore PM2.5 Emission(tons)")
dev.copy(png, file="plot2.png")
dev.off