
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




