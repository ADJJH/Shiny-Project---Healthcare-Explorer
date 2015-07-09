#includeCSS("www/custom.css")

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
      
      
     
      navbarPage(
            
            tags$head(includeCSS("www/custom.css")),
            ("Healthcare explorer"),
            tabPanel("By Year", 
            
                       fluidRow(
                        column(10,
                               #h3("Healthcare explorer"),
                               fluidRow(
                                    
                                          column(6, align="center",
                                                h4("Doctors  (only 2011 data available)"),
                                                
                                                plotOutput("plot_ALL_UL",  brush = brushOpts(id = "plot_ul_brush"),
                                                           ,width="300px",height="300px"),
                                                verbatimTextOutput("info_ul")
                                                                                                
                                          ),
                                              
                                          column(6,
                                                h4("Hospitals"),
                                                align="center",
                                                
                                                plotOutput("plot_ALL_UR",  brush = brushOpts(id = "plot_ur_brush"),
                                                           ,width="300px",height="300px"),
                                                verbatimTextOutput("info_ur")
                                                
                                          )
                                            
                                     
                               ),
                               
                               fluidRow(
                                     
                                           column(6, 
                                                  h4("Spending - Resources"), 
                                                  align="center",
                                                  
                                                  plotOutput("plot_ALL_BL",  brush = brushOpts(id = "plot_bl_brush"),
                                                             ,width="300px",height="300px"),
                                                  verbatimTextOutput("info_bl")
                                          ),
                                          
                                          column(6,
                                                  h4("Population"),
                                                 align="center",
                                                 
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
                               
                               
                               selectInput("year",  
                                           label = "Years",
                                           choices = rbind(c(""),as.integer(seq(1980,2013,by =1)))
                                           
                               ),
                               
                               selectInput("docs_type",  
                                           label = "Doctor Type",
                                           choices = rbind(c("", "GP_Salaried",
                                                             "GP_Self", "Specialist_Salaried",
                                                             "Specialist_Self"))
                                           
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
                                  
                                  fluidRow(
                                        column(6,
                                               plotOutput("plot_profs_all")
                                        ) ,
                                        
                                        column(6,
                                               plotOutput("plot_grads_all")
                                          )     
                                    

                                         
                                        
                                    ),
                                    
                                  
                                  
                                  fluidRow(
                                        column(6,
                                          plotOutput("plot_profs")
                                        ),
                                        column(6,
                                          plotOutput("plot_grads")
                                        )
                                  )
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













