# Script for collating all of the image analysis data files into a single table
# with columns for site, date (collection), trap#, particle size

library(stringr)
library(tidyverse)
library(readr)
library(data.table)
library(dplyr)

# working directory issue - manually set
setwd("z:/Databases/CaterpillarsCount/Frass/2023/Results/")

filelist = list.files()

list_of_files <- list.files(path = ".", recursive = TRUE,
                            pattern = "\\.txt$", 
                            full.names = TRUE)

DT <- rbindlist(sapply(list_of_files, fread, simplify = FALSE),
                use.names = TRUE, idcol = "FileName", fill = TRUE)

# delete columns
DT = subset(DT, select = -c(7:11) )

# rename columns 
colnames(DT)[2] ="Number of Frass"

# create site and date columns by splicing name
# new dataframe for only the file name
list_of_names <- data.table(DT$FileName)

# extracting site, date, and trap from the filename using word()
# example:

Date <- word(list_of_names, sep = "_", 1) 
Site <- word(list_of_names, sep = "_", 2) 
Trap <- word(list_of_names, sep = "_", 3)

# subset Trap and Date by removing unnecessary characters

Date2 <- word(Date, sep = "/", 2)

Trap2 <- word(Trap, sep = ".txt", 1)

# store into DT by adding new columns 

df2 <- cbind(DT, Date2, Site, Trap2)
df2




#End goal is a dataframe like this:

# Site  date      Trap   Particle    Area
# NCBG  20230612  8B      1          .7
# NCBG  20230612  8B      2          .538
# NCBG  20230612  7A      1          .3

#Tj's attempts
# Trial 1
tmpfrass <- read.table("20230518_NCBG_1A.txt", sep = '\t', header = T)
frassdf= data.frame(c("site", "date", "trap", "particle", "area"))
site= word("20230518_NCBG_1A.txt", sep="_", 2)
date= word("20230518_NCBG_1A.txt", sep="_", 1)
trap= word("20230518_NCBG_1A.txt", sep="_", 3)
particle= tmpfrass$X 
area= tmpfrass$Area
print(nrow(tmpfrass))

# Trial 2
"frassdata" <- read.table("20230518_NCBG_1A.txt", sep = '\t', header = T)
"frassdf" <- data.frame("frassdata"("site"=NULL, "date"=NULL, "trap"=NULL, "particle"=NULL, "area"=NULL))
site= word("20230518_NCBG_1A.txt", sep="_", 2)
date= word("20230518_NCBG_1A.txt", sep="_", 1)
trap= word("20230518_NCBG_1A.txt", sep="_", 3)
particle= tmpfrass$X 
area= tmpfrass$Area

