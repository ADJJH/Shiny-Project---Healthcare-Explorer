
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
                  theme(legend.position="none")
            

      return (plot_ul)
}

#source("multiplot.R")


#multiplot(plot_ul,plot_ul,plot_ul,plot_ul, cols=2)


