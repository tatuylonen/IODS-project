# Tatu Ylonen, 2020-11-16
#
# This implements the data wrangling part of Exercise 4
#
# The datasets are described at:
#   http://hdr.undp.org/en/content/human-development-index-hdi
#   http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

library(dplyr)

# (2) Read the data sets into R
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors=F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors=F, na.strings="..")

# (3) Explore the datasets- structure, dimensions, and summaries
str(hd)
dim(hd)
summary(hd)
str(gii)
dim(gii)
summary(gii)

# (4) Look at the meta files and rename variables with (shorter) descriptive
# names
# (I also looked at the metafiles, i.e., the URLs describing the datsets)
colnames(hd)
colnames(gii)

colnames(hd)[1:8] <- c("hdirank", "country", "hdi", "lifexp",
                       "expedu", "meanedu", "gni", "rankdiff")
colnames(gii)[1:10] <- c("giirank", "country", "gii", "matmort",
                         "adolbirth", "parlrep", "seceduf", "secedum",
                         "lfprf", "lfprm")

# Verify that names were successfully changed
print("After name changes")
str(hd)
str(gii)

# (5) Mutate gii by adding two variables
gii <- mutate(gii, seceduratio = seceduf / secedum)
gii <- mutate(gii, lfpratio = lfprf / lfprm)

# Verify that the fields were successfully added
print("After adding two more variables")
str(gii)

# (6) join the datasets using ``country`` as the identifier
human <- inner_join(hd, gii, by=c("country"))
print("After join")
str(human)

# Save in my data folder
write.csv(human, "data/human.csv")
