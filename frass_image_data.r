# Script for collating all of the image analysis data files into a single table
# with columns for site, date (collection), trap#, particle size

library(stringr)
library(tidyverse)
library(readr)
library(data.table)
library(dplyr)
library(lubridate)

# working directory issue - manually set
setwd("//ad.unc.edu/bio/HurlbertLab/Databases/CaterpillarsCount/Frass/2023/Results")

filelist = list.files()

list_of_files <- list.files(path = ".", recursive = TRUE,
                            pattern = "\\.txt$", 
                            full.names = TRUE)

df1 <- rbindlist(sapply(list_of_files, fread, simplify = FALSE),
                use.names = TRUE, idcol = "FileName", fill = TRUE)


# For loop, read in each file

output = data.frame(Site = NULL, Trap = NULL, Date = NULL, X = NULL, Area = NULL)

for (file in filelist) {
  
  tmpfile = read.table(file, sep = '\t', header = T)
  
  # extracting site, date, and trap from the filename using word()
  # example:
  
  Datestring <- word(file, sep = "_", 1) 
  Site <- word(file, sep = "_", 2) 
  Trap <- word(file, sep = "_", 3) %>% word(sep = "\\.", 1)
  
  Date = paste(substr(Datestring, 1, 4), substr(Datestring, 5, 6), substr(Datestring, 7, 8), sep = "-")
  
  tmpdf = data.frame(Site = NULL, Trap = NULL, Date = NULL, X = NULL, Area = NULL)
  
   tmpdf = tmpfile[, c("X", "Area")]
  tmpdf$Date = rep(Date, nrow(tmpdf))
  tmpdf$Site = rep(Site, nrow(tmpdf))
  tmpdf$Trap = rep(Trap, nrow(tmpdf))
  
  output = rbind(output, tmpdf)
  
} # end loop

output = output[, c("Site", "Trap", "Date", "X", "Area")]
output$Date = as.Date(output$Date, format = "%Y-%m-%d")
names(output)[4] = "Particle"










# delete columns
df1 = subset(df1, select = -c(7:11) )

# rename columns 
colnames(df1)[2] ="Number of Frass"

# create site and date columns by splicing name
# new dataframe for only the file name
list_of_names <- data.table(df1$FileName)

# extracting site, date, and trap from the filename using word()
# example:

Date1 <- word(list_of_names, sep = "_", 1) 
Site1 <- word(list_of_names, sep = "_", 2) 
Trap1 <- word(list_of_names, sep = "_", 3)

# subset Trap and Date by removing unnecessary characters
# loop it for all files
length <- row(list_of_names)


for(i in 1:ncol(list_of_names)) {                                             # Loop over character vector
    Date <- word(Date1, sep = "/", 2)
  }  
  
for(i in 1:ncol(list_of_names)) {                                             # Loop over character vector
    Trap <- word(Trap1, sep = ".txt", 1)
  }    

# store into df1 (dataframe 1) by adding new columns 

df2 <- cbind(df1, Date, Site, Trap)





#End goal is a dataframe like this:

# Site  date      Trap   Particle    Area
# NCBG  20230612  8B      1          .7
# NCBG  20230612  8B      2          .538
# NCBG  20230612  7A      1          .3


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

