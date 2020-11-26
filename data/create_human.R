# Tatu Ylonen, 2020-11-16
#
# This implements the data wrangling part of Exercise 4
#
# The datasets are described at:
#   http://hdr.undp.org/en/content/human-development-index-hdi
#   http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

#### First part of this file was created in Exercise 4.  Part created
#### in Exercise 5 is towards the end.

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

#### The remainder of this file was created for Exercise 5: Data
#### reduction techniques

print("===== Start of Exercise 5")

library(stringr)

# We'll start with the "correct" human file provided by the instructors.  Using
# it makes this easier to follow since it uses the same variable names as
# used in the instructions (I chose different names in Exercise 4).
human <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt")
str(human)

# (1) Transform the Gross National Income (GNI) variable to numeric.
# Note that we have renamed it to gni above.
new_gni <- str_replace(human$GNI, pattern=",", replace="") %>% as.numeric
human <- mutate(human, GNI = new_gni)

# (2) Exclude unneeded variables
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI",
          "Mat.Mor", "Ado.Birth", "Parli.F")
human <- dplyr::select(human, one_of(keep))

# (3) Remove all rows with missing values
human <- filter(human, complete.cases(human))

# (4) Remove the observations which relate to regions instead of countries
last <- nrow(human) - 7
human <- human[1:last,]

# (5) Define the row names by the country and remove the country name column
rownames(human) <- human$Country
human <- dplyr::select(human, -Country)
str(human)
rownames(human)
# 155 observations for 8 variables remain, with country as rowname

write.csv(human, "data/human5.csv")
