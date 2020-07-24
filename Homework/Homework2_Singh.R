################################################
# Intro to data science, Standard Homework Heading
#
# Student name: Rashika Pramod Singh
# Homework number: 2
# Date due:  07/03/2020
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
str(mtcars)

#Homework code
myCars<-mtcars
summary(myCars)
View(myCars)
#Step	1:	Explore	mpg	(mpg	stands	for	“miles	per	gallon”)		
#A. What	is	the	mean	mpg?	Use	mean()	or	summary()
mean(myCars$mpg) #mean returns mean value
#B. What	is	the	value	of	the	highest	mpg?	Use	max()	or	summary()
max(myCars$mpg) #max returns maximum value
#C. What	is	the	value	of	the	lowest	mpg?	Use	min()	or	summary()
min(myCars$mpg) #min returns minimum value
#D. Create	a	sorted	dataframe based	on	mpg	and	store	it	in	mtCarsSorted;	Use	order(	)
mtCarsSorted<-myCars[order(myCars$mpg),] #order is used to order the myCars dataframe by attribute mpg
mtCarsSorted
#Step	2:	Which	car	has	the	highest HP (hp	stands	for	“horsepower”)
#E. Write	a	comment:	Is	higher	or	lower	HP	best?
#House power is how rapidly car can perform which translates into speed so higher is better however, it may vary in certain cases
#F. Which	car	has	the	highest	hp?	Use	which.max(	)
row.names(myCars[which.max(myCars$hp),]) #Maserati Bora has highest HP
#which.max() returns maximum value in attribute and row.names() returns name of the car in this case
#G. Which	car	has	the	lowest hp? Use	which.min(	)
row.names(myCars[which.min(myCars$hp),]) #Honda Civic has lowest HP
#which.min() returns minimum value in attribute and row.names() returns name of the car in this case
#Step	3:	Calculate	a combination	of	mpg	and	hp
#H. Run	scaledMPG	<- scale(myCars$mpg,	center=0,	scale=T)
scaledMPG	<- scale(myCars$mpg,	center=0,	scale=T) #scaledMPG for scaling MPG values
scaledMPG
#I. Write	a	comment	that	explains	what	that	command	accomplishes.
#Scale is a function which centers or scales the columns of numeric matrix in this case it scales all the values of mpg centered around 0 
#J. Copy	that	command	and	modify	it	to	create	a	new,	scaled	version	of	myCars$hp.
scaledHP	<- scale(myCars$hp,	center=0,	scale=T) #scales HP values
scaledHP
#K. Combine	the	two	scaled	measurements	by	multiplying	them.	Explain	in	a	comment and how	and	why	this	works.
myCars$combined<-scaledMPG*scaledHP 
myCars$combined
#All the values in scaledMPG are multiplied by values in scaledHP having the same index and they are stored in the combined variable at that same index. 
#L. Add	the	combined	measurement	to	your	dataset.	Something	like	this	should	work:
myCars$combined	<- scaledMPG	*	scaledHP
myCars$combined
#Multiply and stores the result to the dataset
#J. Which	car	has the highest combination	of	mpg	and	hp?
row.names(myCars[which.max(myCars$combined),])
#Maserati Bora has highest combination of mpg and hp