countries_oecd = c('Australia',
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
                        selectInput("country",  # choose the residents
                                    label = "Choose a variable to display",
                                    choices = countries_oecd
                        ),
                                                
                  
                        sliderInput("year",  # choose the range
                                    label = "Range of interest:",
                                    min = 1960, max = 2013, value = c(1960, 2013)
                        )
                  ),
                       
                  mainPanel(textOutput("text1"))
            
            )
      )
)
