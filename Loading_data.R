library(dplyr)
library(xlsx)

#Importing data 
docs_consultation = read.csv("Shiny\ Project/Sources/DOCCONSULT_60_13.csv",
                            skip = 8, header=TRUE, check.names=FALSE )[ ,1:55]


remuneration = read.xlsx2("Shiny Project/Sources/Remunerations of doctors ratio_2011.xls",
                          sheetIndex="Data3.6.1",startRow=6 ,endRow=29)
