library(shiny)
library (ggplot2)
library (dplyr)

docs_consul <- readRDS("data/docs_consultation.rds")
remuneration <- readRDS("data/remuneration.rds")
beds <- readRDS("data/beds.rds")
hosp_stay <- readRDS("data/hosp_stay.rds")
population <- readRDS("data/population.rds")
life_exp <- readRDS("data/life_exp.rds")
spending <- readRDS("data/spending.rds")
mri <- readRDS("data/mri.rds")
ct <- readRDS("data/ct.rds")


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
                  args_ur=list()
                  args_ur$min <- input$year[1]
                  args_ur$max <- input$year[2]
                  args_ur$beds <- beds
                  args_ur$hosp_stay <- hosp_stay
                  args_ur$country <- input$country[1]
                  ur <- do.call(plot_UR,args_ur)
                  
#                   #BR
                  args_br=list()
                  args_br$min <- input$year[1]
                  args_br$max <- input$year[2]
                  args_br$population <- population
                  args_br$life_exp <- life_exp
                  args_br$country <- input$country[1]
                  br <- do.call(plot_BR,args_br)

                  #BL
                  args_bl=list()
                  args_bl$min <- input$year[1]
                  args_bl$max <- input$year[2]
                  args_bl$spending <- spending
                  args_bl$med_units <- mri
                  args_bl$country <- input$country[1]
                  bl <- do.call(plot_BL,args_bl)
                  
                  multiplot(ul,bl,ur,br,cols=2)
                   
            })
      }
)