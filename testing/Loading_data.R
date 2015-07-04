library(dplyr)
library(xlsx)
library(reshape)
library (stringr)

#************************************ Upper left ************************************************

##### Importing data 
docs_consultation = read.csv("Shiny Project/Prohect-Shiny/Sources/DOCCONSULT_60_13.csv",
                            skip = 8, header=TRUE, check.names=FALSE )[ ,1:55]


remuneration = read.xlsx2("Shiny Project/Prohect-Shiny/Sources//Remunerations of doctors ratio_2011.xls",
                          sheetIndex="Data3.6.1",startRow=7 ,endRow=29) [,1:6]

###### Cleaning tables
colnames(remuneration) = c("Location","Year","GP_Salaried",
                           "GP_Self","Specialist_Salaried",
                           "Specialist_Self")

## DF REMUNERATION

# Years can be different or empty - documentaiton says 2011 - so that year is taken as basis
remuneration$Year = 2011

#Removing non alpha strings
remuneration$Location = str_replace_all(remuneration$Location, "[^A-z]", "")

# Tranposing columns GP, specialist, self employed and salaried
remuneration <- melt(remuneration, id=c("Location","Year"))
colnames(remuneration) = c("Location","Year","Type_doc_job",'Salary')

## DF DOCS_CONSULTATION

#Transposing years
docs_consultation = melt(docs_consultation,id = 'Location')
colnames(docs_consultation) = c("Location","Year", "Nmr_consult")


###### Saving dfs
saveRDS(docs_consultation, file="Shiny Project/Prohect-Shiny/data/docs_consultation.rds")
saveRDS(remuneration, file="Shiny Project/Prohect-Shiny/data/remuneration.rds")

#************************************ Upper right ************************************************
##### Importing data 
beds = read.csv("Shiny Project/Prohect-Shiny/Sources/HOSPITALBED-ACUTE-1000HAB_60-13.csv",
                             skip = 8, header=TRUE, check.names=FALSE )[ ,1:55]

beds = melt(beds,id = 'Location')
colnames(beds) = c("Location","Year", "beds_nmr")

# only up to 2012!

hosp_stay = read.csv("Shiny Project/Prohect-Shiny/Sources/HOSPITALSTAY_60_13.csv",
                       skip = 8, header=TRUE, check.names=FALSE )[ ,1:54]
hosp_stay = melt(hosp_stay,id = 'Location')
colnames(hosp_stay) = c("Location","Year", "nmr_days")


saveRDS(beds, file="Shiny Project/Prohect-Shiny/data/beds.rds")
saveRDS(hosp_stay, file="Shiny Project/Prohect-Shiny/data/hosp_stay.rds")



#********************************** bottom_right **********************************

##### Importing data 
population = read.csv("Shiny Project/Prohect-Shiny/Sources/POP-TOT-MLN_PER_1960_2014.csv",
                skip = 8, header=TRUE, check.names=FALSE )[ ,1:55]

population = melt(population,id = 'Location')
colnames(population) = c("Location","Year", "habitants")


life_exp = read.csv("Shiny Project/Prohect-Shiny/Sources/LIFEEXP-TOT-1960-2013.csv",
                     skip = 8, header=TRUE, check.names=FALSE )[ ,1:55]
life_exp = melt(life_exp,id = 'Location')
colnames(life_exp) = c("Location","Year", "exp_years")


saveRDS(life_exp, file="Shiny Project/Prohect-Shiny/data/life_exp.rds")
saveRDS(population, file="Shiny Project/Prohect-Shiny/data/population.rds")



