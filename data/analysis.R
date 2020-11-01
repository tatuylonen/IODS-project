# Tatu Ylönen / University of Helsinki
# 1.11.2020
# RStudio Exercise 2 - data wrangling

# This uses the data set described in:
# Kimmo Vehkalahti: ASSIST 2014 - Phase 3 (end of Part 2), N=183
# Course: Johdatus yhteiskuntatilastotieteeseen, syksy 2014
# (Introduction to Social Statistics, fall 2014 - in Finnish),
# international survey of Approaches to Learning, made possible
# by Teachers' Academy funding for KV in 2013-2015.

# The data has been modified by picking the gender, age, attitude, deep, stra,
# surf, and points fields and dividing summed fields by the number of values
# summed (effectively taking them mean).

# Read the instructor's reference analysis data set, just in case I made
# some error in my own data wrangling exercise.
learning2014 <- read.csv(file="http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt")
str(learning2014)

# XXX to be continued
