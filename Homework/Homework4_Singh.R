################################################
# Intro to data science, Standard Homework Heading
#
# Student name: Rashika Pramod Singh
# Homework number: 4
# Date due:  07/10/2020
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

#---------------------------------------------------------------------------
#Part	1:	Write	a	function	to	compute statistics	for a	vector of	numeric	values
vectorStats <- function(numVector)
{
  
  listOfStats <- c(mean(numVector),
                   median(numVector)
  )
  return(listOfStats)
} #function to compute mean and median for vector of numeric values

#A. Test	your	function	by	calling	it	with	the	numbers	one	through	ten: vectorStats(1:10)
vectorStats(1:10) #passing arguments numbers one through 10 to test the function

#B. Enhance	the	vectorStats()	function	to add the	max,	min	and	standard	deviation	to the	output.
vectorStats <- function(numVector) 
{
  
  listOfStats <- c(mean(numVector),
                   median(numVector),
                   max(numVector),
                   min(numVector),
                   sd(numVector))
  return(listOfStats)
}#function to compute mean, median, maximum value, minimu value and standard deviation for vector of numeric values

#C. Retest	your	enhanced	function	by	calling	it	with	the	numbers	one	through	ten:vectorStats(1:10)
vectorStats(1:10) #call the function by passing numbers one through ten

#---------------------------------------------------------------------------
#Part	2:	Sample repeatedly from the	airquality	built-in	data frame

#D. Copy	the	airquality	data frame:	myAQdata	<- airquality. Use	View(myAQdata) to	show	the	data. Add	a block comment	that	describes	what you	think	each variable	in	the	data	set	contains.	Hint:	Use	the	?	 or	help(	)	command	to	get	help	on	this	data	set.
myAQdata	<- airquality #load data into variable
View(myAQdata) #view the data
help(airquality) #to get more information about the data set

#The Data set shows the daily air quality measurements in New York for May 1, 1973 to September 30, 1973. Ozone variable shows the mean ozone in parts per billion from 1300 to 1500 at Roosevelt Island.
#Solar.R variable is the solar radiation in Langleys in the frequency band 4000-7700 Angstroms from 0800 to 1200 hours at Central Park. Wind is the average wind speed in miles per hour at 0700 and 1000 hours at LaGuardia Airport.
#Temp is the maximum daily temperature in degrees Fahrenheit at La Guardia Airport.

#E. Sample	five observations	from	myAQdata$Wind,	like	this:
sample(myAQdata$Wind, size=5, replace=TRUE) #sample the given source data for five times

#F. Call	your vectorStats(	)	function	with	a	sample	of	five	observations	from myAQdata$Wind.
vectorStats(sample(myAQdata$Wind, size=5, replace=TRUE)) #call the vectorStats function with the five sampled values from the myAQdata$Wind

#G. Use	the	replicate(	) function	to	repeat	your	code	from	problem	F	ten	times. The	first	argument	to	replicate(	)	is	the	number	of	repeats	you	want.	The	second	argument	is	the	little	chunk	of	code	you	want	repeated.
replicate(10,vectorStats(sample(myAQdata$Wind, size=5, replace=TRUE))) #replicate is repeating the sample many times in this case ten times 

#H. Write	a	comment	describing	why	every	replication	produces	a	different	result.
#It chooses different samples at every different replication iterations and hence we get different results are the process is random

#I. Raise	your	sample	size	from	5	up	to	50.	How	does	that	affect	your	replications?
replicate(10,vectorStats(sample(myAQdata$Wind, size=50, replace=TRUE)))

#When you increase sample size from 5 to 50, according to law of large numbers when you run a statistical process a large number of times it will converge to a stable result and in our case the result is stable and there is not much variation with the results. 