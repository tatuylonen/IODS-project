# Introduction to Open Data Science
# Exercise 6: Analysis of longitudinal data
# Tatu Ylonen <tatu.ylonen@helsinki.fi>, 2020-12-01

# Import some libraries
library(dplyr)
library(tidyr)

##### (1) Load the data sets (BPRS and RATS) into R

# Let's first load the BPRS dataset
BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep=" ")
str(BPRS)
summary(BPRS)

# Let's then load the RATS dataset
RATS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep="\t")
str(RATS)
summary(RATS)

##### (2) Convert the categorical variables of both data sets to factors

# First BPRS
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
str(BPRS)

# Then RATS
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)
str(RATS)

##### (3) Convert the data sets to long form.  Add a week variable to BPRS and
##### Time to RATS.

# Convert BPRS to long form and add week
BPRSL <- gather(BPRS, key=weeks, value=bprs, -treatment, -subject)
BPRSL$week <- as.integer(substr(BPRSL$weeks, 5, 9))

# Convert RATS to long form and add Time
RATSL <- gather(RATS, key=WD, value=Weight, -ID, -Group)
RATSL$Time <- as.integer(substr(RATSL$WD, 3, 9))
RATSL$Time

##### (4) Check variable names, view the data contents and structures,
##### and create brief summaries of the variables

# Let's first look at BPRSL
# Variable names:
colnames(BPRSL)
# Structure of data
str(BPRSL)
# Summaries
summary(BPRSL)
# Glimpse at data contents
glimpse(BPRSL)
# Look at the full list of week values to make sure they look reasonable
BPRSL$week

# Let's first look at RATSL
# Variable names:
colnames(RATSL)
# Structure of data
str(RATSL)
# Summaries
summary(RATSL)
# Glimpse at data contents
glimpse(RATSL)
# Look at the full list of Time values to make sure they look reasonable
RATSL$Time

# And then I spent a few minutes getting more tea and thinking about the CRUCIAL
# DIFFERENCE between WIDE FORM and LONG FORM data.  I am in fact quite familiar
# with the difference, as I've used both data formats in SQL databases
# and various computer programs many times over the years (most of it in
# non-statistical contexts though and I haven't used R before this course).

# Save the data
write.csv(BPRS, "data/meet_BPRS.csv")
write.csv(RATS, "data/meet_RATS.csv")
write.csv(BPRSL, "data/meet_BPRSL.csv")
write.csv(RATSL, "data/meet_RATSL.csv")