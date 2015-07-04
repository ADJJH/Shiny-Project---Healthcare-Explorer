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
      
      fluidPage(
            titlePanel("An overview on healthcare systems"),   # main title
      
            sidebarLayout(
                 
                  sidebarPanel(
                        helpText("Comparison among countries "), ## subtitle      
                        selectInput("country",  
                                    label = "Choose a country to highlight",
                                    choices = countries_oecd,
                                    selected = NULL
                                    
                        ),
                                                
                        #textInput(inputId, label, value = "", ...)
                        sliderInput("year",  # choose the range
                                    label = "Years",
                                    min = 2000, max = 2011, value = c(2000, 2011)
                        )
                  ),
                       
                  mainPanel(
                              textOutput("text1"),
                              plotOutput("plot_ALL")
                            
                            
                  )
            
            )
      )
)
