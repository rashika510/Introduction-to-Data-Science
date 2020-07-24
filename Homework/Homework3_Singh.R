################################################
# Intro to data science, Standard Homework Heading
#
# Student name: Rashika Pramod Singh
# Homework number: 3
# Date due:  07/07/2020
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

#Homework code

#Step	1:	Use	read_csv(	) to read	a	CSV	file from the	web	into	a	data	frame:
#A. Use R	code	to	read	directly	from	a URL	on	the	web. Store	the	dataset	into	a	new	dataframe,	called	dfStates.	The	URL	is:	
#"https://raw.githubusercontent.com/CivilServiceUSA/us-states/master/data/states.csv"
#Hint:	use	read_csv( ),	not	read.csv( ). This	is	from	the	tidyverse	package.	Check	the	help	to	compare	them.
#read_csv is faster for large .csv files and read_csv will read variables containing text as characters whereas read.csv will convert it to factor.
install.packages("tidyverse") #install tidyverse package
library(tidyverse) #basic information about the package
dfStates<-read_csv("https://raw.githubusercontent.com/CivilServiceUSA/us-states/master/data/states.csv") #read data in dfStates
view(dfStates) #view data 

#Step	2:	Create	a new data frame that	only	contains	states	with	Twitter	URLs:
#B. Use	View(	),	head(	),	and	tail(	) to	examine	the	dfStates data frame. Add	a	block	comment	that	briefly	describes	what	you	see.
view(dfStates) #shows the entire data frame
head(dfStates) #top 6 rows in the data frame
tail(dfStates) #bottom 6 rows in the data frame

#C. Create a	variable	 (called	noTwitter)	that	has	TRUE	if	a	state	is	missing	its	Twitter	URL:
noTwitter<-is.na(dfStates$twitter_url) #returns TRUE for missing value

#D. Use	the	table( ) command	to	summarize	the	contents	of	noTwitter. Write	a	comment	interpreting	what	you	see.
table(noTwitter)
#There are 35 states with a twitter url and 15 states without a twitter url

#E. Create	a	new	data	frame	that	contains	only	the	states	with	Twitter	URLs (store	that	dataframe	in	twitterStates:
twitterStates<-dfStates[!is.na(dfStates$twitter_url),] #contains information about states with Twitter URLs
view(twitterStates) #view the dataframe

#F. Use	the	dim() command on	twitterStates to confirm	that	the	data	frame	contained	35	observations	and	19	columns/variables.
dim(twitterStates) #The dataframe contains 35 rows and 19 columns

#Step	3:	Calculate	the	mean	for	each	of	the	three numeric	variables.
#G. The	data	frame	contains	three	numeric	variables. You	can	remind	yourself	of	what	they	are	by	looking	at	the	output	of str(twitterStates).	Calculate	the	mean	for	each	of	the	numeric	variables.
str(twitterStates) #get datatype of all variables
mean(twitterStates$admission_number) #to get mean value of admission number
mean(twitterStates$population) #to get mean value of population
mean(twitterStates$population_rank) #to get mean value of population number

#H. Write	a	comment,	noting	the	mean	population	for	twitterStates.
mean(twitterStates$population)
#The mean population for twitterStates is 6532234

#I. Create	another	data	frame	containing	the	15	states	that	do	not	have	Twitter	URLs.	Find	out	the	mean	population	of	those	15	states.	Compare	that	to	the	answer	you	recorded	for	problem	H.
Nourl<-dfStates[is.na(dfStates$twitter_url),] #dataframe of states without twitter url
view(Nourl) #view the dataframe
mean(Nourl$population) #mean value of 15 states without twitter url
# The mean value of 15 states that do not have Twitter URLs is 5790280. The mean value of states with twitter url is more than those without a twitter url

#Step	4:	 Extract	the	Twitter handle	from	the	URL.
#J. Use	the	gsub() command	to	remove	the	beginning	part	of	the	URL	from	the	Twitter	URLs. This	command	should	work	most	of	the	time:gsub("https://twitter.com/","",	twitterStates$twitter_url)
gsub("https://twitter.com/","",	twitterStates$twitter_url) #replace twitter link by blank value

#K. Take	a	close	look	at	the	output	from	the	gsub( ) command	in	problem	J.	Explain	the	cause	of	the	incorrect	results	in	a	comment.
#The results are incorrect as some links include http whereas some have https so the gsub replace only the ones with the same format in the command. Errors are due to data inconsistency

#L. Assign	the	results	of	the	gsub( ) command	to	a	new	variable	on	the	data	frame.	Note	that	you	do	not	have	to	repair	the	problems	that	you	explained	in	problem	J:twitterStates$handle	<- gsub("https://twitter.com/","",	twitterStates$twitter_url)
twitterStates$handle	<- gsub("https://twitter.com/","",	twitterStates$twitter_url) #assigned the gsub results to a variable

#Step	5:	 Create	a	function	to	extract	Twitter	handles:
#M. The	following	function	should	work	most	of	the	time. Make	sure	to	run	this	code	before	trying	to	test	it.	That	is	how	you	make	the	new	function	known	to	R.	Add	comments	to	each	line	explaining	what	it	does:
getTwitterHandleFromURL	<- function(URL)	{  #creates a function called getTwitterHandleFromURL
fixTry1	<- gsub("https://twitter.com/","",	URL) #removes "https://twitter.com/" from twitter link
fixTry2	<- gsub("http://twitter.com/","",	fixTry1) #uses output of line 1 and removes "http://twitter.com/" from twitter link
fixTry3	<- gsub("http://www.twitter.com/","",	fixTry2) #uses output of line 2 and removes "http://www.twitter.com/" from twitter link
return(fixTry3) #return value of function
} 
getTwitterHandleFromURL("https://twitter.com/coloradogov") #test to check the function

#N. Run	your	new	function	on	the	Twitter	URLs.	Make	sure	to use	a	comment	to explain	the	cause	of	any	problems	that	remain	unfixed:
getTwitterHandleFromURL(twitterStates$twitter_url) 
#There are still problems in the result as data is not consistent i.e. clean, example there is one state with a facebook url in place of twitter

#O. Assign	the	results	of	problem	M	to	a	variable	on	the	data	frame:
twitterStates$handle	<- getTwitterHandleFromURL(twitterStates$twitter_url) #store the function results in a new column to add to dataframe
view(twitterStates) #view results

#Expert	Mode!!! Write	a	comment	in	your	code	that	briefly	describes	an	applied	project	where	you	could	use	the	data	frames and	variables you	just	created.
#The dataframes and variables could be used for example in a project that requires to analyze states and their populations to rank the state. It could be used for extracting social media details of all the states and provide recommendations by analyzing factors which contribute to a higher population.