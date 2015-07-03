
library (ggplot2)
library (dplyr)
source("multiplot.R")

docs_consul <- readRDS("Shiny Project/Prohect-Shiny/data/docs_consultation.rds")
remuneration <- readRDS("Shiny Project/Prohect-Shiny/data/remuneration.rds")

remuneration$Salary = as.numeric(as.character(remuneration$Salary))
remuneration$Year = as.integer(as.character(remuneration$Year))
docs_consul$Year = as.integer(as.character(docs_consul$Year))

remuneration <- filter(remuneration, Type_doc_job == "GP_Salaried")


year = 2011
df_ul = inner_join(docs_consul,remuneration,by=c("Location", "Year"))


plot_ul = ggplot (df_ul,aes(x= Salary, y=Nmr_consult , color = Location)) +
            geom_text(aes(label=Location)) +
            theme(legend.position="none")


country_var = "Spain"
selected=filter(df_ul,Location== country_var)

ggplot (df_ul,aes(x= Salary, y=Nmr_consult , color = Location)) +
      geom_point(colour="#C0C0C0",size = 8) +
      geom_point(data=selected,colour="#000099",size = 8)+
      theme(legend.position="none")+
      ylab("# Consultations [per day]")


#***************************** upper right ****************************************



beds <- readRDS("Shiny Project/Prohect-Shiny/data/beds.rds")
hosp_stay <- readRDS("Shiny Project/Prohect-Shiny/data/hosp_stay.rds")

beds$beds_nmr = as.numeric(as.character(beds$beds_nmr))
beds$Year = as.integer(as.character(beds$Year))
hosp_stay$Year = as.integer(as.character(hosp_stay$Year))
hosp_stay$nmr_days = as.integer(as.character(hosp_stay$nmr_days))

df_ur = inner_join(beds,hosp_stay,by=c("Location", "Year"))


country_var = "Spain"
selected_ur=filter(df_ur,Location== country_var)
year = 2011

ggplot (df_ur(Year== year),aes(x= nmr_days, y=beds_nmr , color = Location)) +
      geom_point(colour="#C0C0C0",size = 8) +
      geom_point(data=selected_ur,colour="#000099",size = 8)+
      theme(legend.position="none")+
      ylab("Total beds [per 1k inhabitants]")
      xlab("Length of stay [days]")







