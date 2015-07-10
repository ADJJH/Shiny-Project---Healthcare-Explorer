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
            title="Healthcare explorer",
            
            tabPanel("Introduction",
                  br(),
                  br(),
                  
                  
                  column(2,
                         h4(""),
                         br(),
                         br(),
                         br(),
                         
                         img(src = "beat.jpg",height = 100, width = 135),
                         img(src = "docs.jpg",height = 100, width = 135),
                         img(src = "ct2.jpg",height = 100, width = 135)
                         
                         
                  ),   
                     
                  column(8,
                        h4("Welcome to the Healthcare Explorer"),
                        br(),
                        
                        p(" This application is inspired based on the report 'Health at a Glance'
                        published by OECD (Organisation for Economic Co-operation and Development)."
                        ),
                  
                        p(" The purpose of this application is to enable the discovery of insights and trends
                        in an interactive way. It uses multiple data sets combined into compact views. This helps the user 
                        to visualize and analyze data in an easier way."
                        ),
                        br(),
                     
                        p("The application is divided in two sections:"
                        
                        ),
                     
                        h5(strong("Year")),
                     
                        p( "In this tab you can see how countries compare to others in a specific year."
                        ),
                     
                        h5(strong("Country")),
                        p("This tab shows information about the trends of doctors, nurses 
                          and medical devices for a country"),
                        br(),
                        
                  
                        p("Data was taken from",
                          a(href="https://data.oecd.org/health.htm", "OECD stats site"), "on July 2015.")
                  )   
            
            
            
            ),
            
            tabPanel("By Year", 
            
                       fluidRow(
                        column(10,
                               #h3("Healthcare explorer"),
                               fluidRow(
                                    
                                          column(6, align="center",
                                                h4("Doctors"),
                                                
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
                              
                               helpText("Each bubble represents a country. 
                                        Brush over a bubble(s) to get information of the selection"),      
                               
                               helpText("First select a year"),    
                               selectInput("year",  
                                           label = "Years",
                                           choices = rbind(c(""),as.integer(seq(1980,2013,by =1)))
                                           
                               ),
                               
                               helpText("Select a country to highlight"), 
                               selectInput("country",  
                                           label = "Choose a country to highlight",
                                           choices = countries_oecd,
                                           selected = NULL
                                           
                               ),
                               
                               
                              
                               
                               helpText("Select a type of doctor for the 'Doctors' chart.
                                        Only 2011 data is available for this plot"),  
                               selectInput("docs_type",  
                                           label = "Doctor Type",
                                           choices = rbind(c("", "GP_Salaried",
                                                             "GP_Self", "Specialist_Salaried",
                                                             "Specialist_Self"))
                                           
                               ),
                               
                               helpText("Select the medical device for the 'Spending - Resources' chart"),  
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
                     #fluidRow(
                           column(10,
                                  
                                  fluidRow(
                                        column(12,
                                               plotOutput("plot_DE")
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
                                  
                                  helpText("Trends"),      
                                  selectInput("country2",  
                                              label = "Choose a country",
                                              choices = rbind(c("All"),countries_oecd),
                                              selected = NULL
                                              
                                  ),
                                  
                                  
                                  sliderInput("year2",  
                                              label = "Years",
                                              min = 1980, max = 2013, value = as.integer(c(1980, 2013)),
                                              sep = "",round== TRUE, step=1
                                  ),
                                  
                                  radioButtons("radio2", label = "Medical devices",
                                               choices = list("MRI" = "mri", "CT" = "ct"),
                                               selected = "mri"
                                  ) 
                                  
                                  
                                  
                              )
                        #)
                     
            ) 
      
      
      )
)













