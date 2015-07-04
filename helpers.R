
plot_UL = function (min = 1960, max = 2011, df1,df2,country){

      docs_consul=df1
      remuneration = df2
      remuneration$Salary = as.numeric(as.character(remuneration$Salary))
      remuneration$Year = as.integer(as.character(remuneration$Year))
      docs_consul$Year = as.integer(as.character(docs_consul$Year))
      
      remuneration <- filter(remuneration, Type_doc_job == "GP_Salaried")
      
      
      year = max
      df_ul = inner_join(docs_consul,remuneration,by=c("Location", "Year"))
      
      selected=filter(df_ul,Location == country)
      
      plot_ul= ggplot (df_ul,aes(x= Salary, y=Nmr_consult , color = Location)) +
                  geom_point(colour="#C0C0C0",size = 8) +
                  geom_point(data=selected,colour="#000099",size = 8)+
                  theme(legend.position="none") +
                  ylab("# Consultations [per day]") +
                  xlab ('Ratio of remuneration')
            

      return (plot_ul)
}


plot_UR = function (min = 1960, max = 2011, beds,hosp_stay,country){
      
      
      beds$beds_nmr = as.numeric(as.character(beds$beds_nmr))
      beds$Year = as.integer(as.character(beds$Year))
      hosp_stay$Year = as.integer(as.character(hosp_stay$Year))
      hosp_stay$nmr_days = as.integer(as.character(hosp_stay$nmr_days))
      year = max
      
      df_ur = inner_join(beds,hosp_stay,by=c("Location", "Year"))
      selected_ur=filter(df_ur,Location== country, Year==year)
      
      
      plot_ur<- df_ur %>%
                  filter(., Year==year) %>%
                        ggplot (.,aes(x= nmr_days, y=beds_nmr , color = Location)) +
                        geom_point(colour="#C0C0C0",size = 8) +
                        geom_point(data=selected_ur,colour="#000099",size = 8)+
                        theme(legend.position="none")+
                        ylab("Total beds [per 1k inhabitants]")+
                        xlab("Length of stay [days]")     
      
      return (plot_ur)      
            
}
      
plot_BR = function (min = 1960, max = 2011, population,life_exp,country){      

      population$habitants = as.numeric(as.character(population$habitants))
      population$Year = as.integer(as.character(population$Year))
      life_exp$Year = as.integer(as.character(life_exp$Year))
      life_exp$exp_years = as.integer(as.character(life_exp$exp_years))
      
      df_br = inner_join(population,life_exp,by=c("Location", "Year"))
      
      
      year = max
      selected_br=filter(df_br,Location== country, Year==year)
     
      
      plot_br<-df_br %>%
                  filter(., Year==year) %>%
                        ggplot (.,aes(x=habitants, y=exp_years , color = Location)) +
                        geom_point(colour="#C0C0C0",size = 8) +
                        geom_point(data=selected_br,colour="#000099",size = 8)+
                        theme(legend.position="none")+
                        ylab("Life expectancy [years]")+
                        xlab("Total population [Mill habitants]")      
      
      return(plot_br)
      
}