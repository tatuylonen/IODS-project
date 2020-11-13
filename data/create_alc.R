# Tatu Ylonen, 2020-11-12
#
# This script prepares the exercise 3 data set for the IODS class.  This uses
# the data set at https://archive.ics.uci.edu/ml/datasets/Student+Performance
#
# This script is intended to be run at the top level of the repository.

# install.packages("dplyr")
library(dplyr)

# 3. Read student-mat.csv and student-por.csv
mat <- read.table("data/student-mat.csv", sep=";", header=TRUE)
por <- read.table("data/student-por.csv", sep=";", header=TRUE)

# Explore dimensions and structure of the data
str(mat)
str(por)

# 4. Join the data sets.
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "reason", "nursery", "internet")
mat_por <- inner_join(mat, por, by = join_by, suffixes=c(".mat", ".por"))

# Explore dimensions and structure of the joined data
str(join_by)

# 5. Combine duplicated answers (code largely taken from the datacamp exercise)
alc <- select(mat_por, one_of(join_by))
notjoined_cols <- colnames(mat)[!colnames(mat) %in% join_by]
notjoined_cols

for (name in notjoined_cols) {
  cols <- select(mat_por, starts_with(name))
  first <- select(cols, 1)[[1]]
  if (is.numeric(first)) {
    alc[name] <- round(rowMeans(cols))
  } else {
    alc[name] <- first
  }
}

# 6. Average answers for weekday & weekend alcohol usage and create high_use
alc <- mutate(alc, alc_use = (alc$Dalc + alc$Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

# 7. Glimpse at the joined modified data and save the modified data
glimpse(alc)
write.csv(alc, "data/alc.csv")
