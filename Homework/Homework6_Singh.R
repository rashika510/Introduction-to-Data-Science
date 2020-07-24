################################################
# Intro to data science, Standard Homework Heading
#
# Student name: Rashika Pramod Singh
# Homework number: 6
# Date due:  07/17/2020
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
#Step	1:	Make	a	copy	of the	data
#A. Copy	the	built-in	“airquality”	data	frame	into	a	new	data	frame	called	“air.” Your	new	data	frame,	air,	contains	a	so-called	multivariate	time	series:	a	sequence	of	measurements	on	four	variables	captured	repeatedly	over	time.	
air <-airquality #copy the built-in data to new data frame
View(air)

#B. What	is	the	“interval”	of	these	data	(in	other	words,	at	what	frequency	were	the variables	measured)?	Put	your	answer	in	a	comment
#The variables are measured daily from May to September 1973.

#---------------------------------------------------------------------------
#Step	2:	Clean-up	the NAs with	Missing	Data	Mitigation
#A simple	method	of	dealing	with	small	amounts	of	missing	data	in	a	numeric	variable	is	to	substitute	the	mean	of	the	variable	in	place	of	each missing	datum.	This	expression locates (and	reports to	the	console)	all	of	the	missing	data	elements	in	the	Ozone	variable:
air$Ozone[is.na(air$Ozone)]

#C. Write	a	comment	describing	how	that	statement	works.
#The statement checks for missing values in the Ozone column and indicates which elements are missing.

#D. Write	three	more	statements	to	report	missing	data	for	the	other	variables.
air$Solar.R[is.na(air$Solar.R)] #checks missing values in Solar.R column
air$Wind[is.na(air$Wind)] #checks missing values in Wind column
air$Temp[is.na(air$Temp)] #checks missing values in Temp column

#---------------------------------------------------------------------------
#There	is an	R	package called	imputeTS that	is	specifically	designed	to	repair missing	values	in	time	series	data.	We	will	use	this	instead	of	mean	substitution. The	na.interpolation(	)	function	in	this	package	takes	advantage	of	a	unique	characteristic	of	time	series	data:neighboring	points	in	time	can	be	used	to	“guess”	about	a	missing	value in	between	
#E. Install	the	imputeTS package	and	use	na.interpolation(	)	on your	four	variables. Don’t	forget	that	you	need	to	save	the	results	back	to	the	air	data	frame.
install.packages("imputeTS") #install package
library(imputeTS)
air$Ozone <-na.interpolation(air$Ozone) #na.interpolation( ) uses neighboring points to guess the missing values in the Ozone column
air$Solar.R <-na.interpolation(air$Solar.R) #na.interpolation( ) uses neighboring points to guess the missing values in the Solar.R column
air$Wind <-na.interpolation(air$Wind) #na.interpolation( ) uses neighboring points to guess the missing values in the Wind column
air$Temp <-na.interpolation(air$Temp) #na.interpolation( ) uses neighboring points to guess the missing values in the Temp column

#F. Rerun	the	code	from	C	and	D	above	to	check	that	all	missing	data	have	been	fixed.
air$Ozone[is.na(air$Ozone)] #check for missing values in Ozone column
air$Solar.R[is.na(air$Solar.R)] #check for missing values in Solar.R column
air$Wind[is.na(air$Wind)] #check for missing values in Wind column
air$Temp[is.na(air$Temp)] #check for missing values in Temp column

#---------------------------------------------------------------------------
#Step	3:	Use	ggplot	to	explore the	distribution of each	variable. Don’t	forget	to	install	and	library	the	ggplot2	package.	Then	run	the	following	code:
install.packages("ggplot2") #install ggplot2 package
library(ggplot2)

#G. Create	a	histogram for	Ozone.	Be	sure	to	add	a	title.
gozone <-ggplot(air) + aes(x = Ozone) + geom_histogram(binwidth = 15)  #create a histogram with Ozone data 
gozone + ggtitle("Ozone distribution") #add a title to histogram
gozone

#H. Create	histograms	of	each	of	the	other	three	variables with	ggplot(	). Which parameter	do you	need	to	adjust	to	make	the	other	histograms	look	right?
gsolar <-ggplot(air) + aes(x = Solar.R) + geom_histogram(binwidth = 10)  #create a histogram with Solar.R data and add title
gsolar + ggtitle("Solar distribution")
gsolar
gwind <-ggplot(air) + aes(x = Wind) + geom_histogram(binwidth = 2)  #create a histogram with Wind data and add title
gwind + ggtitle("Wind distribution")
gwind
gtemp <-ggplot(air) + aes(x = Temp) + geom_histogram(binwidth = 1)  #create a histogram with Temp data and add title
gtemp + ggtitle("Temp distribution")
gtemp
#The paramter which needs to be adjusted is the binwidth so that all the necessary data is clearly displayed in the histogram.

#---------------------------------------------------------------------------
#Step	4:	Explore	how	the	data	changes	over	time
#I. These	data	were	collected	in	1973. Run	the	following	line	of	code	and	write	a	comment	that	describes	what	it	does:
air$Date	<- as.Date(paste("1973",	airquality$Month,	airquality$Day,	sep="-"))
#The code creates a column data which joins 1973, month and date separated with a "-" and converts it into a date format.

#J. Now	create	a	line	chart,	with	Date	on	the	X-axis	and	Ozone	on	the	Y-axis.
g <- ggplot(air, aes(x=Date)) +geom_line(aes(y=Ozone)) #creates a linechart with Ozone variation on different dates
g + ggtitle("Ozone on various dates")
g

#K. Next create	time	series	graphs	of	each	of	the	other	three	variables.	Change	the	color	of	the	line	plots (any	color	you	want).
g1 <- ggplot(air, aes(x=Date), colors="blue") +geom_line(aes(y=Solar.R), color="blue") #create a time series graph and add color and title
g1 + ggtitle("Solar on various dates")
g1
g2 <- ggplot(air, aes(x=Date)) +geom_line(aes(y=Wind), color="green") #create a time series graph and add color and title
g2+ ggtitle("Wind on various dates")
g2
g3 <- ggplot(air, aes(x=Date),color="red") +geom_line(aes(y=Temp),color="red") #create a time series graph and add color and title
g3 + ggtitle("Temp on various dates")
g3

#---------------------------------------------------------------------------
#Expert	Mode:	Provide	a	brief	scientific	interpretation	of	the	graphs	of	Ozone	and	Temp in	a	block	comment.	Hint:	If	you	explain	the	ups	and	downs	of	Temp	first,	you	might	find	it	easier	to	explain	Ozone. Consult	https://en.wikipedia.org/wiki/Ozone#Low_level_ozone for	assistance.
#Scientifically, when temperature increases so does surface ozone increases. 
#Due to increase in pollution, global warming increases which results in ozone depletion.
#Individually, the graphs do not show relation.

#---------------------------------------------------------------------------
#Expert	Mode:	Plot	both	Temp	and	Ozone	on	the	same	chart	with	different	colors.	Hint:	You	can	have	more	than	one	geom_line(	) statement.
ozonetemp<- ggplot(air, aes(x=Date)) +geom_line(aes(y=Ozone), color="red")+ geom_line(aes(y=Temp),color="blue") # create a line chart and plot ozone and temp using two geom_line( )
ozonetemp
#relation cannot be determined from the graph

