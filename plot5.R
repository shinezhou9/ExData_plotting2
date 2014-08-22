#read data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#use "grepl" to get a subset SCC_Moter from SCC, which has "Mobile" and "Road" 
#characters in EI.Sector column, to show emissions from motor vehicle sources
SCC_Motor <- SCC[grepl("Mobile.*Road", SCC$EI.Sector),]
#subset NEI to get dataframe NEI_Motor which have matched value in SCC column
#with SCC_Motor dataframe.
NEI_Motor <- NEI[which(NEI$SCC %in% SCC_Motor$SCC),]
#subset NEI_Motor with only data for Baltimore City.
Bal_Motor <- subset(NEI_Motor, fips == "24510")

#use ddply to make a new dataframe showing the emissions from motor vehicle 
#sources for each year 
library(plyr)
Bal_Motordata <- ddply(Bal_Motor,.(year), summarize, sum = sum(Emissions))
colnames(Bal_Motordata) <- c("year", "Emissions")

#make histogram using qplot
library(ggplot2)
qplot(x=year, y=Emissions, data = Bal_Motordata, geom = c("histogram", "smooth"), main = "emissions from motor vehicle sources in Baltimore City(1999–2008)",ylab = "Emissions(tons)", stat = "identity")
dev.copy(png, file="plot5.png")
dev.off