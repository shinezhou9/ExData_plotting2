#read the data.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#use "grepl" to get a subset SCC_Moter from SCC, which has "Mobile" and "Road" 
#characters in EI.Sector column, to show emissions from motor vehicle sources
SCC_Motor <- SCC[grepl("Mobile.*Road", SCC$EI.Sector),]
#subset NEI to get dataframe NEI_Motor which have matched value in SCC column 
#with SCC_Motor dataframe.
NEI_Motor <- NEI[which(NEI$SCC %in% SCC_Motor$SCC),]
#subset NEI_Motor with data for Baltimore City & Los Angeles County
Bal_LA_Motor <- subset(NEI_Motor, fips %in% c("24510","06037"))

#use ddply to make a new dataframe showing the emissions from motor vehicle 
#sources for each year in each city.
library(plyr)
Bal_LA_Motordata <- ddply(Bal_LA_Motor,.(year,fips), summarize, sum = sum(Emissions))
colnames(Bal_LA_Motordata) <- c("year", "city", "Emissions")
Bal_LA_Motordata$city <- factor(Bal_LA_Motordata$city, labels = c("LA", "Baltimore"))

#make histogram using qplot, with two facets based on Cities.
library(ggplot2)
qplot(x=year, y=Emissions, data = Bal_LA_Motordata, geom = c("histogram", "smooth"), facets = .~city, main = "Compare emissions from motor vehicle sources",ylab = "Emissions(tons)", stat = "identity")
dev.copy(png, file="plot6.png")
dev.off