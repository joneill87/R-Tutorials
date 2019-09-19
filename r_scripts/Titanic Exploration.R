## ------------------------------------------------------------------------
# require('packageName') returns TRUE if the package has been downloaded on the 
# user's machine and FALSE otherwise. The '!' operator is read as "Not". Essentially, 
# here we're saying "if the require() function returns false, install the package"
if (!require('ggplot2')) install.packages('ggplot2')
if (!require('lattice')) install.packages('lattice')

# Even though they've been installed we still need to tell R to load them into memory
library(ggplot2)
library(lattice)


## ------------------------------------------------------------------------
data <- read.csv(
  'https://web.stanford.edu/class/archive/cs/cs109/cs109.1166/stuff/titanic.csv'
  )
# The line below forces R to output the dataset we just created
head(data)


## ------------------------------------------------------------------------
summary(data)


## ------------------------------------------------------------------------
data$Survived.logical <- as.logical(data$Survived)


## ------------------------------------------------------------------------
data$Survived <- as.logical(data$Survived)

# Let's tidy up after ourselves and drop the Survived.logical feature we created
# earlier. R has a handy trick to do this. We assign the value list(NULL) to a
# column and R will delete it for us. Note that we're using square bracket notation 
# (rather than the usual $ operator) and passing the column name in as a string. We'll 
# talk more about this in # later classes but for now, just know that these are 
# by-and-large equivalent. 
# The list(NULL) trick only works with square bracket notation, however.
data["Survived.logical"] <- list(NULL)


## ------------------------------------------------------------------------
# By passing in maxsum=5 I'm telling R to show me no more than 5 unique values.
summary(data$Name, maxsum=5)


## ------------------------------------------------------------------------
data$Name <- as.character(data$Name)
summary(data$Name)


## ------------------------------------------------------------------------
summary(data$Sex)


## ------------------------------------------------------------------------
summary(data$Pclass)


## ------------------------------------------------------------------------
?factor


## ------------------------------------------------------------------------
data$Pclass <- factor(data$Pclass, 
                      order=TRUE, 
                      levels=c(1,2,3), 
                      labels=c("1st Class", "2nd Class", "3rd Class")
                      )


## ------------------------------------------------------------------------
summary(data$Age)


## ------------------------------------------------------------------------
summary(as.factor(data$Age %% 1))


## ------------------------------------------------------------------------
data$Age <- as.integer(data$Age)


## ------------------------------------------------------------------------
ggplot(data, aes(x=Age, fill=Survived)) +
  geom_histogram() +
  labs(title="Survival Rate by Age")


## ----fig.height=1.75, fig.width=3.5--------------------------------------
# This for loop is telling R to create this plot with different binwidths.
# 1:10 is a shorthand way of writing c(1,2,3,4,5,6,7,8,9,10)
for (binwidth in 1:10) {
  # Because we're inside a for loop, we now need to explicitly tell ggplot
  # to draw our plot by using the print() function
  print(ggplot(data, aes(x=Age, fill=Survived)) +
    geom_histogram(binwidth=binwidth) +
    labs(title=paste("Survival Rate by Age, Binwidth", binwidth)))
}


## ------------------------------------------------------------------------
ggplot(data, aes(x=Sex, fill=Survived)) + 
  geom_bar(position="dodge") +
  scale_fill_discrete(name = "Outcome", labels = c("Did Not Survive", "Survived")) +
  labs(title="Passenger Survival by Gender")


## ------------------------------------------------------------------------
data$IsChild <- data$Age < 16

ggplot(data, aes(x=IsChild, fill=Survived)) + 
  geom_bar(position="dodge") +
  scale_x_discrete(name="Child/Adult", labels=c("Adult", "Child")) +
  scale_fill_discrete(name = "Outcome", labels = c("Did Not Survive", "Survived")) +
  labs(title="Titanic Survival Rate of Adults/Children")



## ------------------------------------------------------------------------
# Make sure you've loaded the `lattice` module
# We did this with our library(lattice) at the top of the script

ggplot(data, aes(x=Age, fill=Survived)) + 
  geom_histogram(binwidth = 5) + 
  facet_grid(Sex ~ Pclass) +
  ggtitle("Titanic Survival by Age, Gender and Class")

