library (ggplot2)
library (dplyr)

docs_consul <- readRDS("data/docs_consultation.rds")
remuneration <- readRDS("data/remuneration.rds")
beds <- readRDS("data/beds.rds")
hosp_stay <- readRDS("data/hosp_stay.rds")


source("helpers.R")
source("multiplot.R")
# 
# 


shinyServer(
      function(input, output) {
            
            
            output$plot_ALL <- renderPlot({
                  #UL
                  args=list()
                  args$min <- input$year[1]
                  args$max <- input$year[2]
                  args$df1 <- docs_consul
                  args$df2 <- remuneration
                  args$country <- input$country[1]
                  ul <- do.call(plot_UL,args)
                  
                  #UR
                  
                  multiplot(ul,ul,ul,ul,cols=2)
                   
            })
      }
)