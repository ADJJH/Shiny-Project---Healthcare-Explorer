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
professionals<- readRDS("data/professionals.rds")
graduates<- readRDS("data/graduates.rds")

source("helpers.R")
#source("multiplot.R")


shinyServer(
      function(input, output) {
            
            #******** UL *************#
            output$plot_ALL_UL <- renderPlot({
                  
                  args=list()
                  #args$min <- input$year[1]
                  args$year <- input$year[1]
                  args$df1 <- docs_consul
                  args$df2 <- remuneration
                  args$country <- input$country[1]
                  args$docs_type <- input$docs_type[1]
                  ul<-do.call(plot_UL,args)
                  ul[[1]]
            })
            
            
#             output$info_hover <- renderText({
#                   paste0("x=", input$plot_hover$x, "\ny=", input$plot_hover$y)
#             })      
            
            output$info_ul <- renderPrint({
                  args=list()
                  #args$min <- input$year[1]
                  args$year <- input$year[1]
                  args$df1 <- docs_consul
                  args$df2 <- remuneration
                  args$country <- input$country[1]
                  args$docs_type <- input$docs_type[1]
                  ul <- do.call(plot_UL,args)
                  
                  #cat("input$plot_ul_brush:\n")
                  #str(input$plot_ul_brush)
                  brushedPoints(ul[[2]], input$plot_ul_brush,allRows = FALSE)
            })
            
            #******** UR *************#
            output$plot_ALL_UR <- renderPlot({      
                  args_ur=list()
                  #args_ur$min <- input$year[1]
                  args_ur$year <- input$year[1]
                  args_ur$beds <- beds
                  args_ur$hosp_stay <- hosp_stay
                  args_ur$country <- input$country[1]
                  ur <- do.call(plot_UR,args_ur)  
                  ur[[1]]
            })

            output$info_ur <- renderPrint({
                  args_ur=list()
                  #args_ur$min <- input$year[1]
                  args_ur$year <- input$year[1]
                  args_ur$beds <- beds
                  args_ur$hosp_stay <- hosp_stay
                  args_ur$country <- input$country[1]
                  ur <- do.call(plot_UR,args_ur)  
                 
                  brushedPoints(ur[[2]], input$plot_ur_brush,allRows = FALSE)
                  #width = getOption("width")
            })

            #******** BL *************#
            output$plot_ALL_BL <- renderPlot({      
                              args_bl=list()
                              #args_bl$min <- input$year[1]
                              args_bl$year <- input$year[1]
                              args_bl$spending <- spending
                              args_bl$med_units <-  switch(input$radio,
                                                            "mri" = mri,
                                                            "ct" = ct,
                                                      )
                              args_bl$country <- input$country[1]
                              bl <- do.call(plot_BL,args_bl)
                  #                   
                  bl[[1]]
            })
            
            output$info_bl <- renderPrint({     
                  args_bl=list()
                  #args_bl$min <- input$year[1]
                  args_bl$year <- input$year[1]
                  args_bl$spending <- spending
                  args_bl$med_units <-  switch(input$radio,
                                               "mri" = mri,
                                               "ct" = ct,
                                          )
                  args_bl$country <- input$country[1]
                  bl <- do.call(plot_BL,args_bl)
                  
                  brushedPoints(bl[[2]], input$plot_bl_brush,allRows = FALSE)
            })
            
            #******** BR *************#
            output$plot_ALL_BR <- renderPlot({      
                  args_br=list()
                  #args_br$min <- input$year[1]
                  args_br$year <- input$year[1]
                  args_br$population <- population
                  args_br$life_exp <- life_exp
                  args_br$country <- input$country[1]
                  br <- do.call(plot_BR,args_br)
                  #                   
                  br[[1]]
            })
            
            output$info_br <- renderPrint({     
                  args_br=list()
                  #args_br$min <- input$year[1]
                  args_br$year <- input$year[1]
                  args_br$population <- population
                  args_br$life_exp <- life_exp
                  args_br$country <- input$country[1]
                  br <- do.call(plot_BR,args_br)
                  
                  brushedPoints(br[[2]], input$plot_br_brush,allRows = FALSE)
            })
            
############### second tab ###############################
            output$plot_profs <- renderPlot({      
                  args_prof=list()
                  args_prof$min <- input$year2[1]
                  args_prof$max <- input$year2[2]
                  args_prof$professionals <- professionals
                  args_prof$country <- input$country2[1]
                  do.call(plot_profs,args_prof)
            })
            
            output$plot_grads <- renderPlot({      
                  args_grad=list()
                  args_grad$min <- input$year2[1]
                  args_grad$max <- input$year2[2]
                  args_grad$graduates <- graduates
                  args_grad$country <- input$country2[1]
                  do.call(plot_grads,args_grad)
            })

            output$plot_grads_all <- renderPlot({      
                                    graduates %>% ggplot (.,aes(x=Year, y=graduates)) +
                                                      geom_point(aes(color=type)) +
                                                      scale_x_discrete(breaks=seq(1980,2010,10))+
                                                      theme(legend.position="bottom", legend.title = element_blank(),
                                                            panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                            panel.background = element_rect(fill = 'white', colour = 'grey')) +
                                                      ylab("Total graduates [Per 1000 inhabitants]")+
                                                      xlab("Year")
                                                      #theme_bw() 
                  
            })

            output$plot_profs_all <- renderPlot({    
                                    professionals$type = as.factor(professionals$type)
                                    professionals$Year = as.integer(as.character(professionals$Year))
                                    
                                    professionals %>% filter(.,Year>=1980) %>%
                                          ggplot (.,aes(x=Year, y=professionals)) +
                                          geom_point(aes(color=type)) +
                                          #scale_x_discrete(breaks=seq(1980,2010,10))+
                                          theme(legend.position="bottom", legend.title = element_blank(),
                                                panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                panel.background = element_rect(fill = 'white', colour = 'grey')) +
                                          ylab("Total professionals [Per 1000 inhabitants]")+
                                          xlab("Year") 
                                          #theme_bw() 
                  
            })

      }
)