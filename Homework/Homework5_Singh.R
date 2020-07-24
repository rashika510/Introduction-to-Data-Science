################################################
# IST687, Standard Homework Heading
#
# Student name: Rashika Pramod Singh
# Homework number: 5
# Date due: 07/14/2020

# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor
# 2. I did this homework with help from the book and the professor and these Internet sources:
# 3. I did this homework with help from <Name of another student> but did not cut and paste any code

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment
##########################################################################

#-------------------------------------------------------------------------
# The following starter code will help you retrieve and transform the data
# from the State of Maryland open data API
#-------------------------------------------------------------------------
# First, install and "library" new packages:

install.packages("RCurl") # Uncomment this if you need to install from the web
library(RCurl)
install.packages("jsonlite") # Uncomment this if you need to install from the web
library(jsonlite)

#-------------------------------------------------------------------------
# Next, retrieve and examine the data from the URL
getURL   # What does this function do and what package does it come from?
dataset <- getURL("http://opendata.maryland.gov/api/views/pdvh-tf2u/rows.json?accessType=DOWNLOAD")
### Add your explanation here
#getURL function comes from the RCurl package which is used to get the source of a webpage.

?fromJSON   # What does this function do and what package does it come from?
mydata <- fromJSON(dataset)
### Add your explanation here
#The fromJSON function is from jsonlite package and is used to convert between R objects from JSON

str(mydata[[1]]) # The metadata, including variable names, is stored here
str(mydata[[2]]) # The data matrix is stored here
myDF <- as.data.frame(mydata[[2]], stringsAsFactors = F) # Convert the data matrix to data frame
colnames(myDF) <- mydata[["meta"]][["view"]][["columns"]][["name"]] # Add the variable names from the metadata
str(myDF) # Note that every column has been turned character data!!!

#-------------------------------------------------------------------------
# Finally, we are ready to run some SQL queries
install.packages("sqldf") # Install the package
library(sqldf)

sqldf("select count(DAY_OF_WEEK) from myDF where TRIM(DAY_OF_WEEK) = 'FRIDAY'") #count the number of accidents with injuries and getting the day of week by trim()
### How many accidents on Friday
#There are 3014 accidents on Friday

sqldf("select count(DAY_OF_WEEK) from myDF where TRIM(DAY_OF_WEEK) = 'FRIDAY' and INJURY='NO'") #count the number of accidents with no injuries and getting the day of week by trim()
### How many accidents on Friday with no injuries
#There are 1971 accidents on Friday with no injuries

#C. What	is	the	total	number	of	accidents	on	Fridays where	there	were	injuries?
sqldf("select count(DAY_OF_WEEK) from myDF where TRIM(DAY_OF_WEEK) = 'FRIDAY' and INJURY='YES'") #count the number of accidents with injuries and getting the day of week by trim()
#There are 1043 number of accidents on Friday where there were injuries

#D. Use	an	SQL	query	to	output a	new	data	frame	that	only	includes	accidents with injuries that	occurred	on	Fridays.		Hint:	the	query	"select	*	from	myDF" returns	a	data	frame	containing	all	of	the	rows	and	columns.
newDF<-sqldf("select * from myDF where TRIM(DAY_OF_WEEK) = 'FRIDAY' and INJURY='YES'")
#query to include accidents with injuries on friday and store to a new data frame

#E. Use	the	new	data	frame	to	calculate	the mean number	of	vehicles	involved	in	accidents with	injuries on	Fridays?
vehcount<-sqldf("select avg(VEHICLE_COUNT) from newDF where TRIM(DAY_OF_WEEK) = 'FRIDAY' and INJURY='YES'" )
#get the mean number of vehicles involved in accidents on Friday

#F. Make	a	histogram	of	the	number	of	vehicles	in	accidents	on	Fridays. Add	a	comment	describing	the	shape	of	the	distribution.
countacc<-sqldf("select VEHICLE_COUNT from newDF where TRIM(DAY_OF_WEEK) = 'FRIDAY' and INJURY='YES' and VEHICLE_COUNT is not null" ) #get the number of vehicles in accidents on Friday
xvariable<-as.numeric((unlist(countacc))) #convert it to numeric format
hist(xvariable) #create a histogram
#The shape of the distribution is right-skewed

#G. Make	up	a	query	of	interest	to	you	and run	it	to display	the	result.
sql_query<-sqldf("select count(1) as Total_Accidents, DAY_OF_WEEK from myDF group by DAY_OF_WEEK")
sql_query
#To get the total accidents on a particular day of week