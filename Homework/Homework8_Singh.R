################################################
# Intro to data science, Standard Homework Heading
#
# Student name: Rashika Pramod Singh
# Homework number: 8
# Date due:  07/24/2020
#
# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor
# 2. I did this homework with help from the book and the professor and these Internet sources: https://bio304-class.github.io/bio304-fall2017/ggplot-bivariate.html
# 3. I did this homework with help from <Name of another student> but did not cut and paste any code:n/a

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment

# Set working directory 
setwd("/Users/rashikasingh/Desktop/syr/687/HW")

#---------------------------------------------------------------------------
#A. Use	install.packages()	and	library()	to	put	the	psych package	into	memory.	Like many	packages,	psych contains	data	sets	that	can	be	used	for	exercises	and	demonstrations.	
#We	will	be	using	the	sat.act data	set	which	contains	data	on	college	entrance	exams.	Use	the	appropriate	functions to	summarize	the	sat.act	data.
install.packages("psych") #install psych package for getting data set
library(psych)
df<-sat.act #load data set
summary(df) #summarize the data set
View(df) #view the data

#---------------------------------------------------------------------------
#B. We	will	be	using	four variables	from	this	data	set:	ACT	as	the	outcome	variable,	as	well	as	gender,	age,	and	education	as	the	predictors.	
#Create	bivariate	scatterplots	(XY)	plots	for	each	of	the	predictors	with	the	outcome.	In	each	case,	put	ACT	scores	on	the	Y-axis.
install("ggplot2") #install ggplot2 package
library(ggplot2) 
#create bivariate plots for each predictors with ACT on Y-axis, labs is used for labelling axis
plot1<-ggplot(df, aes(x=gender, y=ACT)) + geom_point()+geom_smooth(method = "lm", col="red") + labs(x='gender', y='ACT')
plot1
plot2<-ggplot(df, aes(x=age, y=ACT)) + geom_point()+geom_smooth(method = "lm", col="red") + labs(x='age', y='ACT')
plot2
plot3<-ggplot(df, aes(x=education, y=ACT)) + geom_point()+geom_smooth(method = "lm", col="red") + labs(x='education', y='ACT')
plot3

#---------------------------------------------------------------------------
#C. Next,	create	one	regression	model	predicting	ACT	scores	from	the	three	predictors.Refer	to	page	202	in	the	text	for	syntax	and	explanations	of	lm(	).
#Make	sure	to	include	all	three	predictors	in	one	model – NOT	three	different	models	each	with	one	predictor.
model1<-lm(formula =ACT~gender+education+age, data=df) #regression model for predicting ACT score 
summary(model1)
#---------------------------------------------------------------------------
#D. Report	the adjusted R-Squared	in	a	comment. Which	of	the	predictors	are	statistically	significant	in	the model? 
#In	a	comment,	report	the	coefficients	(AKA	slopes	or	B-weights)	for	each	predictor	that	is	statistically	significant. Do	not	report	the	coefficients	for	predictors that	are	not	significant.
summary(model1) #summarize the model
#The adjusted R-Squared means set of variables such as gender, age and education could cause 2.72% variability in the dependent variable ACT score
#The predictor that is statistically significant is education

#---------------------------------------------------------------------------
#E. Write	a	block	comment	that	explains	your	overall	interpretation	of	the	model.Mention	all	predictors	that	were	tested	and	provide	examples	that	explain	the	meaning	of	the	coefficient	for	any	predictors	that	were	significant.
#The model is not strong correlated as adjusted R square is not very high. The predictors used are age, education and gender.
#ACT score= b0+b1*x1+b2*x2+b3*x3
#b0 is the intercept. When gender, age and education are 0, the ACT score is predicted to be 27.41706.
#b1 is the coefficient of the gender, b2 is for education and b3 is for age. The education predictor is significant which means every level of education will increase the ACT score by 0.47.
#(Intercept) 27.41706    
#gender      -0.48606    
#education    0.47890    
#age          0.01623

#---------------------------------------------------------------------------
#F. Create	a	one-row	data	frame	like	this:	predDF	<- data.frame(gender=2,	education=2,	age=20) and	use	it	with	the	predict(	)	function	to	predict	the	resulting	ACT	score.
predDF<- data.frame(gender=2,	education=2,	age=20) #data frame for test data 
predict(model1, predDF, type="response") #predict the ACT score
#The ACT score is 27.72

#---------------------------------------------------------------------------
#G. Power	User: Create	two	additional	linear	models,	one	with	SATV	and	one	with SATQ	as	the	outcome	variable.	
model2<-lm(formula =SATV~gender+education+age, data=df) #linear model for predicting SATV score
summary(model2)
model3<-lm(formula =SATQ~gender+education+age, data=df) ##linear model for predicting SATQ score
summary(model3)
