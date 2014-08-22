#read the data and subset data for Baltimore City
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
Bal <- subset(NEI, fips == "24510")

#make a new dataframe showing the emissions from each sources and for each year 
library(ggplot2)
library(plyr)
BalType <- ddply(Bal,.(year, type), summarize, sum = sum(Emissions))

#make barplot under ggplot2 plotting system, with four facets based on the  types of sources.
g <- ggplot(BalType, aes(x = year, y = sum))
g +geom_bar(stat = "identity", fill="blue", alpha = 1/2)+facet_grid(.~type)+geom_smooth(method = "lm", color = "red")+labs(x = "year")+labs(y="PM2.5 Emission(tons)")+labs(title = "Baltimore PM2.5 Emissions by Sourse Type")+ylim(0,NA)
dev.copy(png, file="plot3.png")
dev.off