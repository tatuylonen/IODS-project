# Tatu Ylönen / University of Helsinki
# 1.11.2020
# RStudio Exercise 2 - data wrangling

# This uses the data set described in:
# Kimmo Vehkalahti: ASSIST 2014 - Phase 3 (end of Part 2), N=183
# Course: Johdatus yhteiskuntatilastotieteeseen, syksy 2014
# (Introduction to Social Statistics, fall 2014 - in Finnish),
# international survey of Approaches to Learning, made possible
# by Teachers' Academy funding for KV in 2013-2015.

library(dplyr)

# Load the data into a data frame.
data <- read.csv(file="http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t")

# Print the dimensions of the data.
print("=== dimensions of the data JYTOPKYS3-data dataset")
dim(data)

# Print a summary of what the data frame contains.
# Turns out there are 183 observations for 60 variables.
print("Structure of the JYTOPKYS3-data dataset")
str(data)

# Create the analysis dataset with variables gender, age, attitude,
# deep, stra, surf and points.  First copy the data wrangling statements from
# the datacamp exercises.
data$attitude = data$Attitude / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30",
                    "D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21",
                       "SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20",
                         "ST28")
deep_columns <- select(data, one_of(deep_questions))
data$deep <- rowMeans(deep_columns)
surface_columns <- select(data, one_of(surface_questions))
data$surf <- rowMeans(surface_columns)
strategic_columns <- select(data, one_of(strategic_questions))
data$stra = rowMeans(strategic_columns)

# Select only the desired fields for the analysis data set
anal <- select(data, c("gender", "Age", "attitude", "deep", "stra", "surf",
                       "Points"))
colnames(anal)[2] <- "age"
colnames(anal)[7] <- "points"
# Exclude observations where the exam points variable is zero from the
# analysis data set
anal <- filter(anal, points != 0)

# Show the structure of the analysis dataset
print("=== analysis dataset")
str(anal)

# Write the analysis data set into a file
write.csv(anal, "data/analysis-dataset.csv")

# Demonstrate that we can read back the analysis data set
readback <- read.csv("data/analysis-dataset.csv")
print("=== structure of the readback dataset")
str(readback)
print("=== head of the readback dataset")
head(readback)
