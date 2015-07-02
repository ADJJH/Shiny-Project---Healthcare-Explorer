library (ggplot2)
library (dplyr)

docs_consul <- readRDS("data/docs_consultation.rds")
remuneration <- readRDS("data/remuneration.rds")

source("helpers.R")
# 
# 


shinyServer(
      function(input, output) {
             output$plot_UL <- renderPlot({
                   args=list()
                   args$min <- input$year[1]
                   args$max <- input$year[2]
                   args$df1 <- docs_consul
                   args$df2 <- remuneration
                   do.call(plot_UL, args )
                   
            })
      }
)