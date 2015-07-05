
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
selected_ur=filter(df_ur,Location== country_var, Year==year)
year = 2011

ggplot (df_ur(Year== year),aes(x= nmr_days, y=beds_nmr , color = Location)) +
      geom_point(colour="#C0C0C0",size = 8) +
      geom_point(data=selected_ur,colour="#000099",size = 8)+
      theme(legend.position="none")+
      ylab("Total beds [per 1k inhabitants]")+
      xlab("Length of stay [days]")


df_ur %>%
      filter(., Year==year) %>%
            ggplot (.,aes(x= nmr_days, y=beds_nmr , color = Location)) +
            geom_point(colour="#C0C0C0",size = 8) +
            geom_point(data=selected_ur,colour="#000099",size = 8)+
            theme(legend.position="none")+
            ylab("Total beds [per 1k inhabitants]")+
            xlab("Length of stay [days]")      


#************************* Bottom right ***********************************


population <- readRDS("Shiny Project/Prohect-Shiny/data/population.rds")
life_exp <- readRDS("Shiny Project/Prohect-Shiny/data/life_exp.rds")

population$habitants = as.numeric(as.character(population$habitants))
population$Year = as.integer(as.character(population$Year))
life_exp$Year = as.integer(as.character(life_exp$Year))
life_exp$exp_years = as.integer(as.character(life_exp$exp_years))

df_br = inner_join(population,life_exp,by=c("Location", "Year"))


country_var = "Austria"
selected_br=filter(df_br,Location== country_var, Year==year)
year = 2011

df_br %>%
      filter(., Year==year) %>%
      ggplot (.,aes(x=habitants, y=exp_years , color = Location)) +
      geom_point(colour="#C0C0C0",size = 8) +
      geom_point(data=selected_br,colour="#000099",size = 8)+
      theme(legend.position="none")+
      ylab("Life expectancy [years]")+
      xlab("Total population [Mill habitants]")      


#********************************* bottom left *******************************

spending <- readRDS("Shiny Project/Prohect-Shiny/data/spending.rds")
mri <- readRDS("Shiny Project/Prohect-Shiny/data/mri.rds")
med_units <- readRDS("Shiny Project/Prohect-Shiny/data/ct.rds")

spending$GDPp = as.numeric(as.character(spending$GDPp))
spending$Year = as.integer(as.character(spending$Year))
med_units$Year = as.integer(as.character(med_units$Year))
med_units$med_units = as.integer(as.character(med_units$med_units))

df_bl = inner_join(spending,med_units,by=c("Location", "Year"))

year = 2011
country_var = "Japan"
selected_bl=filter(df_bl,Location== country_var, Year==year)


df_bl %>%
      filter(., Year==year) %>%
      ggplot (.,aes(x=GDPp, y=med_units , color = Location)) +
      geom_point(colour="#C0C0C0",size = 8) +
      geom_point(data=selected_bl,colour="#000099",size = 8)+
      theme(legend.position="none")+
      ylab("Total units [1M habitants]")+
      xlab("Health expenditure [%GDP]")      

#************************ Plotting second tab 
#### Professionals



professionals<- readRDS("Shiny Project/Prohect-Shiny/data/professionals.rds")
professionals$type = as.factor(professionals$type)
professionals$Year = as.integer(as.character(professionals$Year))

country = "Austria"

selected_prof=filter(professionals,Location== country)


selected_prof %>%
      
      ggplot (.,aes(x=Year, y=professionals , color = type)) +
      
      geom_line(data=selected_prof)+
      #theme(legend.position="none")+
      ylab("Total professionals [Per 1000 inhabitants]")+
      xlab("Year")      











