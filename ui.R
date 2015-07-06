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




shinyUI(
      
      navbarPage("Healthcare explorer",
            tabPanel("By Year", 
      
      #fluidPage(
                  fluidRow(
                        column(10,
                               #h3("Healthcare explorer"),
                               fluidRow(
                                    
                                          column(6, 
                                                "Plot UR (only 2011 data available)",
                                                
                                                plotOutput("plot_ALL_UL",  brush = brushOpts(id = "plot_ul_brush"),
                                                           ,width="300px",height="300px"),
                                                verbatimTextOutput("info_ul")
                                                                                                
                                          ),
                                          
                                          column(6,
                                                "Plot UL",
                                                
                                                plotOutput("plot_ALL_UR",  brush = brushOpts(id = "plot_ur_brush"),
                                                           ,width="300px",height="300px"),
                                                verbatimTextOutput("info_ur")
                                                
                                          )
                                            
                                     
                               ),
                               
                               fluidRow(
                                     
                                           column(6, 
                                                  "Plot BL",
                                                  
                                                  plotOutput("plot_ALL_BL",  brush = brushOpts(id = "plot_bl_brush"),
                                                             ,width="300px",height="300px"),
                                                  verbatimTextOutput("info_bl")
                                          ),
                                          
                                          column(6,
                                                  "Plot BR",
                                                 
                                                 plotOutput("plot_ALL_BR",  brush = brushOpts(id = "plot_br_brush"),
                                                            ,width="300px",height="300px"),
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
                                           min = 2000, max = 2011, value = as.integer(c(1980, 2013)),
                                           sep = "",round== TRUE, step=1
                               ),
                               
                               radioButtons("radio", label = "Medical devices",
                                            choices = list("MRI" = "mri", "CT" = "ct"),
                                            selected = "mri"
                              ) 
                              
                              #verbatimTextOutput("info_ul")
                        
                        )
                  )
            ),
      
 #*********     Second panel **********
            tabPanel("Country",
                     fluidRow(
                           column(10,
                                  plotOutput("plot_profs"),
                                  plotOutput("plot_grads")
                              ),
                     
                           column(2,
                                  
                                  helpText("Comparison among countries "),      
                                  selectInput("country2",  
                                              label = "Choose a country to highlight",
                                              choices = countries_oecd,
                                              selected = NULL
                                              
                                  ),
                                  
                                  
                                  sliderInput("year2",  
                                              label = "Years",
                                              min = 1980, max = 2013, value = as.integer(c(1980, 2013)),
                                              sep = "",round== TRUE, step=1
                                  )
                                  
                                  
                                  
                              )
                        )
                     
            ) 
      
      
      )
)













