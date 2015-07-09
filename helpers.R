
plot_UL = function ( year , df1,df2,country,docs_type){

      docs_consul=df1
      remuneration = df2
      remuneration$Salary = as.numeric(as.character(remuneration$Salary))
      remuneration$Year = as.integer(as.character(remuneration$Year))
      docs_consul$Year = as.integer(as.character(docs_consul$Year))
      
      remuneration <- filter(remuneration, Type_doc_job == docs_type)
      
      
      #year = max
      df_ul = inner_join(docs_consul,remuneration,by=c("Location", "Year"))
      
      selected=filter(df_ul,Location == country)
      
      plot_ul=  df_ul %>%
                  filter(., Year==year) %>%
                  ggplot (.,aes(x= Salary, y=Nmr_consult , color = Location)) +
                        geom_point(colour="#C0C0C0",size = 8) +
                        geom_point(data=selected,colour="#000099",size = 8)+
                        theme(legend.position="none") +
                        ylab(expression(bold("# Consultations [per day]"))) +
                        xlab (expression(bold('Ratio of remuneration'))) +
                        theme_bw() +
                        theme (panel.grid.major = element_blank(), panel.grid.minor = element_blank())
            
      df_ul<-df_ul[complete.cases(df_ul),c("Location","Nmr_consult","Salary")]
           

      return(list(plot_ul,df_ul))
}


plot_UR = function (year, beds,hosp_stay,country){
      
      
      beds$beds_nmr = as.numeric(as.character(beds$beds_nmr))
      beds$Year = as.integer(as.character(beds$Year))
      hosp_stay$Year = as.integer(as.character(hosp_stay$Year))
      hosp_stay$nmr_days = as.integer(as.character(hosp_stay$nmr_days))
      #year = max
      
      df_ur = inner_join(beds,hosp_stay,by=c("Location", "Year"))
      selected_ur=filter(df_ur,Location== country, Year==year)
      
      #df_ul<-df_ul[complete.cases(df_ul),c("Location","Nmr_consult","Salary")]
      
      
      plot_ur<- df_ur %>%
                  filter(., Year==year) %>%
                        ggplot (.,aes(x= nmr_days, y=beds_nmr , color = Location)) +
                        geom_point(colour="#C0C0C0",size = 8) +
                        geom_point(data=selected_ur,colour="#000099",size = 8)+
                        theme(legend.position="none")+
                        ylab(expression(bold("Total beds [per 1k inhabitants]")))+
                        xlab(expression(bold("Length of stay [days]")))  +
                        theme_bw() +
                        theme (panel.grid.major = element_blank(), panel.grid.minor = element_blank())   
      
      df_ur<-filter(df_ur, Year==year)
      df_ur<-df_ur[complete.cases(df_ur),c("Location","nmr_days","beds_nmr")]
      
      
      return(list(plot_ur,df_ur))     
            
}
      
plot_BR = function (year, population,life_exp,country){      

      population$habitants = as.numeric(as.character(population$habitants))
      population$Year = as.integer(as.character(population$Year))
      life_exp$Year = as.integer(as.character(life_exp$Year))
      life_exp$exp_years = as.integer(as.character(life_exp$exp_years))
      
      df_br = inner_join(population,life_exp,by=c("Location", "Year"))
      
      
      #year = max
      selected_br=filter(df_br,Location== country, Year==year)
      
     
      
      plot_br<-df_br %>%
                  filter(., Year==year) %>%
                        ggplot (.,aes(x=habitants, y=exp_years , color = Location)) +
                        geom_point(colour="#C0C0C0",size = 8) +
                        geom_point(data=selected_br,colour="#000099",size = 8)+
                        theme(legend.position="none")+
                        ylab(expression(bold("Life expectancy [years]")))+
                        xlab(expression(bold("Total population [1M habitants]")))  +
                        theme_bw() +
                        theme (panel.grid.major = element_blank(), panel.grid.minor = element_blank())   
      
      
      df_br<-filter(df_br, Year==year)
      df_br<-df_br[complete.cases(df_br),c("Location","habitants","exp_years")]
      
      return(list(plot_br,df_br))  
      
}



plot_BL = function (year, spending,med_units,country){ 


      spending$GDPp = as.numeric(as.character(spending$GDPp))
      spending$Year = as.integer(as.character(spending$Year))
      med_units$Year = as.integer(as.character(med_units$Year))
      med_units$med_units = as.integer(as.character(med_units$med_units))
      
      
      
      #year=max
      df_bl = inner_join(spending,med_units,by=c("Location", "Year"))
      
      
      selected_bl=filter(df_bl,Location== country, Year==year)
      
      
      plot_bl<-df_bl %>%
                  filter(., Year==year) %>%
                        ggplot (.,aes(x=GDPp, y=med_units , color = Location)) +
                        geom_point(colour="#C0C0C0",size = 8) +
                        geom_point(data=selected_bl,colour="#000099",size = 8)+
                        theme(legend.position="none")+
                        ylab(expression(bold("Total units [1M habitants]")))+
                        xlab(expression(bold("Health expenditure [%GDP]")))  +
                        theme_bw() +
                        theme (panel.grid.major = element_blank(), panel.grid.minor = element_blank())   
      
      
      df_bl<-filter(df_bl, Year==year)
      df_bl<-df_bl[complete.cases(df_bl),c("Location","GDPp","med_units")]
      
      return(list(plot_bl,df_bl)) 

}



plot_profs = function (min = 1980, max = 2013, professionals,country){ 
     
      
      professionals$type = as.factor(professionals$type)
      professionals$Year = as.integer(as.character(professionals$Year))
            
      
      selected_prof=filter(professionals,Location == country & (Year>=min & Year<=max ))
            
      selected_prof %>%
            
            ggplot (.,aes(x=Year, y=professionals , color = type)) +
            geom_line(data=selected_prof,size=1)+
            ylab("Total professionals [Per 1000 inhabitants]")+
            xlab("Year") +
            theme(legend.position="bottom", legend.title = element_blank(),
                  panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                  panel.background = element_rect(fill = 'white', colour = 'grey'))
      
}



plot_grads = function (min = 1980, max = 2013, graduates,country){ 
     
      graduates$type = as.factor(graduates$type)
      graduates$Year = as.integer(as.character(graduates$Year))
      
      selected_grad=filter(graduates,Location == country & (Year>=min & Year<=max ))
      
      
      selected_grad %>%
            
            ggplot (.,aes(x=Year, y=graduates , color = type)) +
            
            geom_line(data=selected_grad,size=1)+
            #theme(legend.position="none")+
            ylab("Total graduates [Per 1000 inhabitants]")+
            xlab("Year") +      
            theme(legend.position="bottom", legend.title = element_blank(),
                  panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                  panel.background = element_rect(fill = 'white', colour = 'grey'))
      
}

