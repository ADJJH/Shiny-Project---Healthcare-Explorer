library(dplyr)
library(xlsx)
library(reshape)
library (stringr)

##### Importing data 
docs_consultation = read.csv("Shiny Project/Prohect-Shiny/Sources/DOCCONSULT_60_13.csv",
                            skip = 8, header=TRUE, check.names=FALSE )[ ,1:55]


remuneration = read.xlsx2("Shiny Project/Prohect-Shiny/Sources//Remunerations of doctors ratio_2011.xls",
                          sheetIndex="Data3.6.1",startRow=7 ,endRow=29) [,1:6]

###### Cleaning tables
colnames(remuneration) = c("Location","Year","GP_Salaried",
                           "GP_Self","Specialist_Salaried",
                           "Specialist_Self")

# Years can be different or empty - documentaiton says 2011 - so that year is taken as basis
remuneration$Year = 2011

#Removing non alpha strings
remuneration$Location = str_replace_all(remuneration$Location, "[^A-z]", "")

# Tranposing columns GP, specialist, self employed and salaried
remuneration <- melt(remuneration, id=c("Location","Year"))


