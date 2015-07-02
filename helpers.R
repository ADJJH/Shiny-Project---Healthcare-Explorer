
plot_UL = function (min = 0, max = 2011, df1,df2){

      docs_consul=df1
      remuneration = df2
      remuneration$Salary = as.numeric(as.character(remuneration$Salary))
      remuneration$Year = as.integer(as.character(remuneration$Year))
      docs_consul$Year = as.integer(as.character(docs_consul$Year))
      
      remuneration <- filter(remuneration, Type_doc_job == "GP_Salaried")
      
      
      year = max
      df_ul = inner_join(docs_consul,remuneration,by=c("Location", "Year"))
      
      
      plot_ul = ggplot (df_ul,aes(x= Salary, y=Nmr_consult , color = Location)) +
            geom_text(aes(label=Location)) +
            theme(legend.position="none")

      return (plot_ul)
}
