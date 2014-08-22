#read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#use grepl to get a subset SCC2 from SCC which has "c/Coal" in EI.Sector column.
#subset NEI to get data which have matched value in SCC column with SCC2 dataframe.
SCC2 <- SCC[grepl(".*[cC]oal.*", SCC$EI.Sector),]
NEI_coal <- NEI[which(NEI$SCC %in% SCC2$SCC),]

#make a new dataframe coal to show the total emissions for each year
#from coal-related sources.
library(plyr)
coal <- ddply(NEI_coal,.(year), summarize, sum = sum(Emissions))
colnames(coal) <- c("year", "Emissions")

#make histogram and smooth line by using qplot function. 
library(ggplot2)
qplot(x=year, y = Emissions, data = coal, geom = c("histogram", "smooth"),method = "lm", main = "emissions from coal combustion-related sources(1999–2008)",ylab = "Emissions(tons)", stat = "identity")
dev.copy(png, file="plot4.png")
dev.off
