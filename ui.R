library(shiny)
library(shinyWidgets)

#Sources data file
source("R/covid_source_file.R", local = TRUE)

# custom dropdown func --------------------------------------------------------------------

ui <- fluidPage(
  # Header ------------------------------------------------------------------
  titlePanel("COVID-19 Deaths Over Time in the U.S."),
  
  # Body --------------------------------------------------------------------
  h5("Overview"),
  p("\nTHIS CAN BE MORE CLEAR DUDE!!.\n"),
  #br(),

  hr(),
  # sidebarLayout ----------------------------------------------------------
  h4("Control Panel"),
  sidebarLayout(
    
    sidebarPanel(
      
      # Filter by section -------------------------------------------------------
      
      #p("Filter by"),
      
      #move this to top, so menu can be updated if someone chooses filter
      p(strong("Filter Options")),

      checkboxInput(inputId = "label_button",
                    label = "Put the State Labels",
                    value = FALSE
      ),
      checkboxInput(inputId = "facet_button",
                    label = "Split Panels by Political Party",
                    value = FALSE
      ),
      actionButton(inputId = "all_democrat_button", "Blue states only"),
      actionButton(inputId = "all_republican_button", "Red states only"),
      actionButton(inputId = "reset_button", "Reset all filters"),
      
      hr(),
      
      #drop down menu
      pickerInput(
        inputId = "state_filter", 
        label = "(De)Select U.S. State/s", 
        choices = unique(state_longer_elections$state), 
        options = list(
          `actions-box` = TRUE, 
          size = 10,
          `selected-text-format` = "count > 3"
        ), 
        multiple = TRUE
      ),
      
      ####
      
      # Options section ---------------------------------------------------------
      
      #hr("Options"),
      # creates checkbox for labels of states
      # checkboxInput(inputId = "label_button",
      #               label = "Put the State Labels",
      #               value = TRUE
      # ),
      # checkboxInput(inputId = "facet_button",
      #               label = "Split Panels by Political Party",
      #               value = FALSE
      # ),
      # sidebarPanel Buttons -----------------------------------------------------------------
      
      # all_democrat_button
      #actionButton(inputId = "all_democrat_button", "Select All Democrat States"),
      
      # all_republican_button
      #actionButton(inputId = "all_republican_button", "Select All Republican States"),
      
      # all_state_button
      #actionButton(inputId = "all_state_button", "Select All States"),
      
      # reset_button
      # actionButton(inputId = "reset_button", "Reset Filter"),
      
      # Download Section --------------------------------------------------------
      hr(),
      p(strong("Data Status")),
      h5(paste("Updated:", format(Sys.time(), "%A %B %d, %Y"))),
      #Download button for data
      downloadButton("downloadData", "Download Full Dataset (.csv)"),
      #updated text
      
    ), #End of sidebarPanel
    
    
    # Main Panel --------------------------------------------------------------
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("lineplot")),
        tabPanel("Summary", verbatimTextOutput("summary")),
        tabPanel("Table", tableOutput("table"))
      )
    )
    
  ), #End of sidebarLayout
  
  # Reference Section --------------------------------------------------------  
  hr(),
  h4("Data Source"),
  p("COVID-19 Data:", a(href="https://github.com/CSSEGISandData/COVID-19",target="_blank","CSSEGISandData")),
  p("State Population Data:", a(href="https://worldpopulationreview.com/states/",target="_blank","World Population Review")),
  h6("For questions, raise an issue on our GitHub repo- ", a(href="https://github.com/Big-Data-Analytics-Lab-USF/covid19-shinyapp", target="_blank", "SAIL")),
  h6("otherwise, please email the maintainer: "),
  h6("(1) wesley.gardiner4546@gmail.com")
)
