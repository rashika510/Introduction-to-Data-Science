################################################
# Intro to data science, Standard Homework Heading
#
# Student name: Rashika Pramod Singh
# Homework number: 7
# Date due:  07/21/2020
#
# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor
# 2. I did this homework with help from the book and the professor and these Internet sources: n/a
# 3. I did this homework with help from <Name of another student> but did not cut and paste any code:n/a

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment

# Set working directory 
setwd("/Users/rashikasingh/Desktop/syr/687/HW")

#installing packages
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("ggmap")
install.packages("maps")
install.packages("mapproj")

# Loading the library
library(tidyverse)
library(ggplot2)
library(ggmap)
library(maps)
library(mapproj)
#---------------------------------------------------------------------------
#Step	1: Load and repair the median income	data
#A. Download	the	provided	MedianZIP.csv file from	Blackboard	and	read into	R-studio into	a	dataframe	called	“mydata”. Use	read_csv() to	simplify	later	steps!
mydata <- read_csv("MedianZIP.csv") #read the data

#B. Find	and	fix	the	missing	data	in	the	Mean	column	by	substituting	the	value	from	the	Median column in	place	of	the	missing	mean	values.	Add	a	comment	explaining	why	the	median	is	a	reasonable replacement	for	the	mean.
View(mydata) #check the data
mydata[is.na(mydata$Mean) == TRUE,] #find missing values 
mydata$Mean[is.na(mydata$Mean)] <- mydata$Median[is.na(mydata$Mean)] #replace missing values in Mean by the Median column 
#Median is not affected by outliers hence, it is a reasonable replacement for Mean.

#C. Examine	the	data	with	View(	) and add	comments	explaining	what	each	column contains.	Add	a	comment explaining	why the	first	2391	zip	codes look	weird.
View(mydata) 
rows1 <- mydata[1:2391,]
#The zip column contains the zipcodes, the Median column is the median income data, the mean column is the mean income and the population is the population for that zipcode.
#The first 2391 zip codes have 4 digits for zipcode and the remaining has zip codes of 5 digits.

#---------------------------------------------------------------------------
#Step	2:	Merge the median	income data with	the	detailed	zipcode	data
install.packages("~/Desktop/zipcode_1.0.tar.gz", repos = NULL, type = "source") #install zipcode package
library(zipcode)
mydata$zip <- clean.zipcodes(mydata$zip) #clean the zipcodes to make it consistent
data(zipcode) #get the zipcode data in r 
dfNew <- merge(mydata,zipcode, by="zip") #merge the income data with zipcode data
View(dfNew)

#D) Run	the	code	shown	above and	finish	the	last	line	of	code. Comment	each	line	of	code	explaining	what	it	does.
#the first line installs the zipcode package
#the clean the zipocodes to get correct zipcodes and store in new data frame

#---------------------------------------------------------------------------
#Step	3:	Merge	the	new	dataset	with	stateName.csv data
#E) You	will	find stateNames.csv	on	Blackboard.	Use	it similarly	to	Step	2.
mystates<- read_csv("stateNames.csv") #read the data
dfNew <- merge(mystates,dfNew, by="state") #merge with dfNew
view(dfNew) 

#---------------------------------------------------------------------------
#Step	4: Visualize	the	data
#F) Plot	points	(on	top	of	a	map	of	the	US)	for	each	zipcode (don’t	forget	to	library	ggplot2	and	ggmap).	Have	the	color	represent	the	mean
us <- map_data("state")
dfNew$name<-tolower(dfNew$name)
view(dfNew)
map1<- ggplot(dfNew, aes(map_id = name)) #ggplot for adding the data and map_id for specifying the data for map
map1<- map1 + geom_map(map = us) #adding the map as us
map1<- map1 + geom_point(aes(x=longitude,y=latitude,color=Mean)) #specifying longitude and latitude and make the color represent the mean
map1

#G) Add	a	block	comment	that	criticizes	the	resulting	map. It’s	not	very	good.
#The map is not very clear and no proper results can be obtained from the map, it does not show any distribution or patterns

#---------------------------------------------------------------------------
#Step	5:	Use	sqldf()	to	Make	a	Data	Frame	of	State-by-State	Income.
#Library	the	sqldf()	package	and	then	run	the	following	query	to	create	a	new	data	frame(make	sure	that	you	type	the	whole	command	on	one	line):
install.packages("sqldf") #install sqldf package
library(sqldf)
dfSimple <- sqldf("select name, SUM(Mean*Pop) as Total, SUM(Pop) as Pop from dfNew GROUP BY name")  #calculate the total income for a population
view(dfSimple) #view tje results

#H) Add	a	comment	describing	what	this	SQL	statement	does.	Make	sure	to	describe how	many	rows	there	are	and	what	aspect	of	the	SQL	command	caused	that	result.
#The statement groups by state, the total income and the sum of the population

#I) Create	a	new	variable	on	dfSimple called	income.	Calculate	income by	dividing Total	by	Pop.	This	will	provide	the	average	income	for	each	state.
dfSimple$income<-dfSimple$Total/dfSimple$Pop #create a new column to calculate average income by state
view(dfSimple)

#---------------------------------------------------------------------------
#Step	6:	Use	ggplot	and	ggmap	to	shade	a	map	of	the	U.S.	with	average	income	
#J) Copy	the	ggplot	code	from	Step	4.	In	the	initial	ggplot	statement,	you	will	need	to	use	your	new	data	frame,	so	substitute	dfSimple	in	place	of	dfNew.	Additionally,	instead	of	using	geom_point	to	plot	points,	use	this	aesthetic	to	fill	the	polygons	with	color	for	each	state:aes(fill	=	dfSimple$income).	Make	sure	to	expand	the	limits	correctly	and	that	you	have	used	coord_map	appropriately.
us<- map_data("state")
view(us)
dfincome <- merge(us, dfSimple, by.x = "region",by.y = "name" ) #merge simpledf with state data
view(dfincome)
mapincome<- ggplot(dfincome,aes(map_id=region)) #plot the map using region
mapincome<- mapincome + geom_map(map = us,aes(fill=income)) #create the map using income for each state
mapincome<- mapincome + geom_point(aes(x=long,y=lat)) 
mapincome<-mapincome+ expand_limits(x=lat, y=long) #expand the limits
mapincome<-mapincome+coord_map()+ ggtitle("Map") #coord_map and add title
mapincome


