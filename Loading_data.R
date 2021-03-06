library(dplyr)
library(xlsx)
library(reshape)
library (stringr)

countries_oecd = c("",
                   'Australia',
                   'Austria',
                   'Belgium',
                   'Brazil',
                   'Canada',
                   'Chile',
                   'Czech Republic',
                   'Denmark',
                   'Estonia',
                   'Finland',
                   'France',
                   'Germany',
                   'Greece',
                   'Hungary',
                   'Iceland',
                   'Ireland',
                   'Israel',
                   'Italy',
                   'Japan',
                   'Korea',
                   'Luxembourg',
                   'Mexico',
                   'Netherlands',
                   'New Zealand',
                   'Norway',
                   'Poland',
                   'Portugal',
                   'Russia',
                   'Slovak Republic',
                   'Slovenia',
                   'South Africa',
                   'Spain',
                   'Switzerland',
                   'Turkey',
                   'United Kingdom',
                   'United States'
)


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
#remuneration$Location = str_replace_all(remuneration$Location, "[^A-z]", "")

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
population = filter(population,Location  %in%  countries_oecd)

life_exp = read.csv("Shiny Project/Prohect-Shiny/Sources/LIFEEXP-TOT-1960-2013.csv",
                     skip = 8, header=TRUE, check.names=FALSE )[ ,1:55]
life_exp = melt(life_exp,id = 'Location')
colnames(life_exp) = c("Location","Year", "exp_years")
life_exp = filter(life_exp,Location  %in%  countries_oecd)




saveRDS(life_exp, file="Shiny Project/Prohect-Shiny/data/life_exp.rds")
saveRDS(population, file="Shiny Project/Prohect-Shiny/data/population.rds")


#************** bottom left **************************************************
spending = read.csv("Shiny Project/Prohect-Shiny/Sources/HEALTHEXP-TOT-PC_GDP-60_13.csv",
                      skip = 8, header=TRUE, check.names=FALSE )[ ,1:55]

spending = melt(spending,id = 'Location')
colnames(spending) = c("Location","Year", "GDPp")


mri = read.csv("Shiny Project/Prohect-Shiny/Sources/MRIUNITS-TOT-82_13.csv",
                    skip = 8, header=TRUE, check.names=FALSE )[ ,1:33]
mri = melt(mri,id = 'Location')
colnames(mri) = c("Location","Year", "med_units")

ct = read.csv("Shiny Project/Prohect-Shiny/Sources/CTSCANNER-TOT-1000000HAB_80-13.csv",
               skip = 8, header=TRUE, check.names=FALSE )[ ,1:35]
ct = melt(ct,id = 'Location')
colnames(ct) = c("Location","Year", "med_units")

saveRDS(spending, file="Shiny Project/Prohect-Shiny/data/spending.rds")
saveRDS(mri, file="Shiny Project/Prohect-Shiny/data/mri.rds")
saveRDS(ct, file="Shiny Project/Prohect-Shiny/data/ct.rds")

####################################################################
#******************** Second tab **********************************

#************* doctors and nurses totals

nurses = read.csv("Shiny Project/Prohect-Shiny/Sources/NURSE-TOT-1000HAB_60_13.csv",
                    skip = 8, header=TRUE, check.names=FALSE ,stringsAsFactors=FALSE)[ ,1:36]
nurses = melt(nurses,id = 'Location')
colnames(nurses) = c("Location","Year", "professionals")
nurses = mutate(nurses,type="Nurse")


docs = read.csv("Shiny Project/Prohect-Shiny/Sources/MEDICALDOC-TOT-1000HAB_60_13.csv",
                  skip = 8, header=TRUE, check.names=FALSE,stringsAsFactors=FALSE )[ ,1:55]
docs = melt(docs,id = 'Location')
colnames(docs) = c("Location","Year", "professionals")
docs = mutate(docs,type="Doctor")


professionals= rbind(nurses,docs)
saveRDS(professionals, file="Shiny Project/Prohect-Shiny/data/professionals.rds")

#************* doctors and nurses graduates

nurses = read.csv("Shiny Project/Prohect-Shiny/Sources/NURSEGRAD-TOT-100000HAB_80_13.csv",
                  skip = 8, header=TRUE, check.names=FALSE ,stringsAsFactors=FALSE)[ ,1:35]
nurses = melt(nurses,id = 'Location')
colnames(nurses) = c("Location","Year", "graduates")
nurses = mutate(nurses,type="Nurse")


docs = read.csv("Shiny Project/Prohect-Shiny/Sources/MEDICALGRAD-TOT-100000HAB_80_13.csv",
                skip = 8, header=TRUE, check.names=FALSE,stringsAsFactors=FALSE )[ ,1:35]
docs = melt(docs,id = 'Location')
colnames(docs) = c("Location","Year", "graduates")
docs = mutate(docs,type="Doctor")


graduates= rbind(nurses,docs)
saveRDS(graduates, file="Shiny Project/Prohect-Shiny/data/graduates.rds")


#*********** mri, ct exams

mri_exams_h = read.csv("Shiny Project/Prohect-Shiny/Sources/MRIEXAM-INHOSPITAL-1000HAB_90_13.csv",
                       skip = 8, header=TRUE, check.names=FALSE ,stringsAsFactors=FALSE)[ ,1:20]
mri_exams_h = melt(mri_exams_h,id = 'Location')
colnames(mri_exams_h) = c("Location","Year", "exams")
mri_exams_h = mutate(mri_exams_h,type="Hospital")

mri_exams_a = read.csv("Shiny Project/Prohect-Shiny/Sources/MRIEXAM-INAMBULATORY-1000HAB_90_13.csv",
                       skip = 8, header=TRUE, check.names=FALSE ,stringsAsFactors=FALSE)[ ,1:20]
mri_exams_a = melt(mri_exams_a,id = 'Location')
colnames(mri_exams_a) = c("Location","Year", "exams")
mri_exams_a = mutate(mri_exams_a,type="Ambulatory")

mri_exams = rbind(mri_exams_h,mri_exams_a)



ct_exams_h = read.csv("Shiny Project/Prohect-Shiny/Sources/CTEXAM-INHOSPITAL-1000HAB_90_13.csv",
                       skip = 8, header=TRUE, check.names=FALSE ,stringsAsFactors=FALSE)[ ,1:25]
ct_exams_h = melt(ct_exams_h,id = 'Location')
colnames(ct_exams_h) = c("Location","Year", "exams")
ct_exams_h = mutate(ct_exams_h,type="Hospital")

ct_exams_a = read.csv("Shiny Project/Prohect-Shiny/Sources/CTEXAM-INAMBULATORY-1000HAB_90_13.csv",
                       skip = 8, header=TRUE, check.names=FALSE ,stringsAsFactors=FALSE)[ ,1:20]
ct_exams_a = melt(ct_exams_a,id = 'Location')
colnames(ct_exams_a) = c("Location","Year", "exams")
ct_exams_a = mutate(ct_exams_a,type="Ambulatory")

ct_exams = rbind(ct_exams_h,ct_exams_a)


saveRDS(mri_exams, file="Shiny Project/Prohect-Shiny/data/mri_exams.rds")
saveRDS(ct_exams, file="Shiny Project/Prohect-Shiny/data/ct_exams.rds")
