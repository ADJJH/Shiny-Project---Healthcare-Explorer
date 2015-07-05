countries_oecd = c("",
                  'Australia',
                   'Austria',
                   'Belgium',
                   'Brazil',
                   'Canada',
                   'Chile',
                   'Czech Republic',
                   'Denmark',
                   'Estonia',
                   'Finland',
                   'France',
                   'Germany',
                   'Greece',
                   'Hungary',
                   'Iceland',
                   'Ireland',
                   'Israel',
                   'Italy',
                   'Japan',
                   'Korea',
                   'Luxembourg',
                   'Mexico',
                   'Netherlands',
                   'New Zealand',
                   'Norway',
                   'Poland',
                   'Portugal',
                   'Russia',
                   'Slovak Republic',
                   'Slovenia',
                   'South Africa',
                   'Spain',
                   'Switzerland',
                   'Turkey',
                   'United Kingdom',
                   'United States'
)

# shinyUI(
#       
#       fluidPage(
#             titlePanel("An overview on healthcare systems"),   # main title
#       
#             sidebarLayout(
#                  
#                   sidebarPanel(
#                         helpText("Comparison among countries "),      
#                         selectInput("country",  
#                                     label = "Choose a country to highlight",
#                                     choices = countries_oecd,
#                                     selected = NULL
#                                     
#                         ),
#                                                 
#                         
#                         sliderInput("year",  
#                                     label = "Years",
#                                     min = 2000, max = 2011, value = c(2000, 2011)
#                         ),
#                         
#                         radioButtons("radio", label = "Medical devices",
#                                      choices = list("MRI" = "mri", "CT" = "ct"),
#                                      selected = "mri")
#                   ),
#                        
#                   mainPanel(
#                               textOutput("text1"),
#                               plotOutput("plot_ALL")
#                             
#                             
#                   )
#             
#             )
#       )
# )


      


shinyUI(fluidPage(
      fluidRow(
            column(10,
                   "All plots",
                   fluidRow(
                        
                              column(6, 
                                    "Plot UR",
                                    #plotOutput("plot_ALL_UL")
                                    
                                    plotOutput("plot_ALL_UL",  brush = brushOpts(id = "plot_ul_brush")),#hover = "plot_hover"), #hover = "plot_hover",
                                    verbatimTextOutput("info_ul")
                                    #verbatimTextOutput("info_hover")
                                    
                                    
                              ),
                              
                              column(6,
                                    "Plot UL",
                                    
                                    plotOutput("plot_ALL_UR",  brush = brushOpts(id = "plot_ur_brush")),#hover = "plot_hover"), #hover = "plot_hover",
                                    verbatimTextOutput("info_ur")
                                    
                              )
                                
                         
                   ),
                   
                   fluidRow(
                         
                               column(6, 
                                      "Plot BL",
                                      
                                      plotOutput("plot_ALL_BL",  brush = brushOpts(id = "plot_bl_brush")),
                                      verbatimTextOutput("info_bl")
                              ),
                              
                              column(6,
                                      "Plot BR",
                                     
                                     plotOutput("plot_ALL_BR",  brush = brushOpts(id = "plot_br_brush")),
                                     verbatimTextOutput("info_br")
                              )
                         
                  )
                   
                   
            ),
            
            
            
            column(2,
                  
                   helpText("Comparison among countries "),      
                   selectInput("country",  
                               label = "Choose a country to highlight",
                               choices = countries_oecd,
                               selected = NULL
                               
                   ),
                   
                   
                   sliderInput("year",  
                               label = "Years",
                               min = 2000, max = 2011, value = c(2000, 2011)
                   ),
                   
                   radioButtons("radio", label = "Medical devices",
                                choices = list("MRI" = "mri", "CT" = "ct"),
                                selected = "mri"
                  ) 
            
            )
      )
))













