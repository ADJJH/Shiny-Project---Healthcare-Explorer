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

df_test <- readRDS("data/df_ul_test.rds")
testing <- df_test[complete.cases(df_test),c("Location","Nmr_consult","Salary")]
mtcars2 <- mtcars[, c("mpg", "cyl", "disp", "hp", "wt", "am", "gear")]

source("helpers.R")
source("multiplot.R")
# 
# 


shinyServer(
      function(input, output) {
            
            #******** UL *************#
            output$plot_ALL_UL <- renderPlot({
                  
                  args=list()
                  args$min <- input$year[1]
                  args$max <- input$year[2]
                  args$df1 <- docs_consul
                  args$df2 <- remuneration
                  args$country <- input$country[1]
                  ul<-do.call(plot_UL,args)
                  ul[[1]]
            })
            
            
#             output$info_hover <- renderText({
#                   paste0("x=", input$plot_hover$x, "\ny=", input$plot_hover$y)
#             })      
            
            output$info_ul <- renderPrint({
                  args=list()
                  args$min <- input$year[1]
                  args$max <- input$year[2]
                  args$df1 <- docs_consul
                  args$df2 <- remuneration
                  args$country <- input$country[1]
                  ul <- do.call(plot_UL,args)
                  
                  brushedPoints(ul[[2]], input$plot_ul_brush,allRows = FALSE)
            })
            
            #******** UR *************#
            output$plot_ALL_UR <- renderPlot({      
                  args_ur=list()
                  args_ur$min <- input$year[1]
                  args_ur$max <- input$year[2]
                  args_ur$beds <- beds
                  args_ur$hosp_stay <- hosp_stay
                  args_ur$country <- input$country[1]
                  ur <- do.call(plot_UR,args_ur)  
                  ur[[1]]
            })

            output$info_ur <- renderPrint({
                  args_ur=list()
                  args_ur$min <- input$year[1]
                  args_ur$max <- input$year[2]
                  args_ur$beds <- beds
                  args_ur$hosp_stay <- hosp_stay
                  args_ur$country <- input$country[1]
                  ur <- do.call(plot_UR,args_ur)  
                 
                  brushedPoints(ur[[2]], input$plot_ur_brush,allRows = FALSE)
            })

############test

output$plot1 <- renderPlot({
      
      
      ggplot(testing, aes(Nmr_consult, Salary)) + geom_point()
           
})

output$brush_info <- renderPrint({
      brushedPoints(testing, input$plot1_brush)
})

##########333333333

            
#             output$plot_ALL <- renderPlot({
#                   #UL
#                   args=list()
#                   args$min <- input$year[1]
#                   args$max <- input$year[2]
#                   args$df1 <- docs_consul
#                   args$df2 <- remuneration
#                   args$country <- input$country[1]
#                   ul <- do.call(plot_UL,args)
#                   
#                   #UR
#                   args_ur=list()
#                   args_ur$min <- input$year[1]
#                   args_ur$max <- input$year[2]
#                   args_ur$beds <- beds
#                   args_ur$hosp_stay <- hosp_stay
#                   args_ur$country <- input$country[1]
#                   ur <- do.call(plot_UR,args_ur)
#                   
# #                   #BR
#                   args_br=list()
#                   args_br$min <- input$year[1]
#                   args_br$max <- input$year[2]
#                   args_br$population <- population
#                   args_br$life_exp <- life_exp
#                   args_br$country <- input$country[1]
#                   br <- do.call(plot_BR,args_br)
# 
#                   #BL
#                   args_bl=list()
#                   args_bl$min <- input$year[1]
#                   args_bl$max <- input$year[2]
#                   args_bl$spending <- spending
#                   args_bl$med_units <-  switch(input$radio,
#                                                "mri" = mri,
#                                                "ct" = ct,
#                                                )
#                   args_bl$country <- input$country[1]
#                   bl <- do.call(plot_BL,args_bl)
#                   
#                   multiplot(ul,bl,ur,br,cols=2)
#                    
#             })
      }
)