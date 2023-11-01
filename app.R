##########################################################
# MHI CYP Dashboard
# Original author(s): Jon Minton
# Original date: 2023-10-10
# Written/run on RStudio desktop 2023.6.0.421 and R 4.2.2
# Description of content
##########################################################

# Get packages
source("setup.R")

# UI
ui <- fluidPage(
tagList(
  # Specify most recent fontawesome library - change version as needed
  tags$style("@import url(https://use.fontawesome.com/releases/v6.1.2/css/all.css);"),

  navbarPage(
      id = "intabset", # id used for jumping between tabs
      title = div(
          tags$a(img(src = "phs-logo.png", height = 40),
                 href = "https://www.publichealthscotland.scot/",
                 target = "_blank"), # PHS logo links to PHS website
      style = "position: relative; top: -5px;"),
      windowTitle = "MHI CYP Dashboard",# Title for browser tab
      header = tags$head(
        includeCSS("www/styles.css"),  # CSS stylesheet
        includeCSS("www/more_styles.css"),                 
      tags$link(rel = "shortcut icon", href = "favicon_phs.ico") # Icon for browser tab
  ), ##############################################.
  # INTRO PAGE ----
  ##############################################.
  tabPanel(title = "Introduction",
      icon = icon_no_warning_fn("circle-info"),
      value = "intro",
  
      h1("Welcome to the dashboard"),
      uiOutput("intro_page_ui")
  
  ), # tabpanel
  ##############################################.
  # PAGE 1 ----
  ##############################################.
  tabPanel(title = "Overview",
      # Look at https://fontawesome.com/search?m=free for icons
      icon = icon_no_warning_fn("layer-group"),
      value = "intro",
  
      h1("Overview"),
      uiOutput("p01_overview_ui"),
      linebreaks(2),
      
      h2("An example data table using fetched metadata"),
      DT::dataTableOutput("metadata_table"),
      linebreaks(2)
  
      ),
  ##############################################.
  # PAGE 2 ----
  ##############################################.
  tabPanel(title = "Indicators and Domains",
           # Look at https://fontawesome.com/search?m=free for icons
           icon = icon_no_warning_fn("layer-group"),
           value = "indicatorsAndDomains",
           
           h1("Indicators and Domains"),
           uiOutput("indicator_domains"),         
           # uiOutput("p02_indicators_domains_ui"),
           linebreaks(2)
           
        ), # tabpanel
  
  # PAGE 3 : Domains 
  tabPanel(
    title = "Domains only",
    value = "domainsOnly",
    h1("Domains only"),
    uiOutput("domains")
  )
      ) # navbar
    ) # taglist
  ) # ui fluidpage

# ----------------------------------------------
# Server

server <- function(input, output, session) {
  
    reactiveTestItems <- reactive(testItems)
  

    # Get functions
    source(file.path("functions/core_functions.R"), local = TRUE)$value
    source(file.path("functions/intro_page_functions.R"), local = TRUE)$value
    source(file.path("functions/page_1_functions.R"), local = TRUE)$value
    
    # Get services 
    source(file.path("services/cypServices.R"), local = TRUE)$value
  
    n_indicators <- reactive(
      get_number_of_indicators()
    )
    
    n_indicators_dataless <- reactive(
      get_number_of_dataless_indicators()
    )
    
    n_indicators_not_dataless <- reactive(
      get_number_of_data_indicators()
    )
    
    all_metadata <- reactive(
      get_all_metadata()
    )
    
    all_data <- reactive(
      get_all_data() 
    )
    
    make_formatted_line <- function(x){
      glue("{x$id[[1]]}: {x$metadata$domain[[1]]}\t{x$metadata$indicator[[1]]}")  
    }
    
    lines <- reactive(sapply(all_data(), make_formatted_line))
    


    # Get content for individual pages
    source(file.path("pages/intro_page.R"), local = TRUE)$value
    source(file.path("pages/p01_overview.R"), local = TRUE)$value
    
    # The following creates a list item for each indicator loaded.
    output$indicator_domains <- renderUI(
      {
        fluidRow(
          tags$h1("Welcome to Indicator Domains!"),
          tags$ul(
            lapply(all_data(), function(x) tags$li(make_formatted_line(x)))
          )
        )
      }
    )
    
    # I now want to create a formatted list, one for each domain. 
    # Within each domain I want the number of indicators, and number of 
    # dataless indicators, to be listed.
    
    # source(file.path("pages/p02_domains.R"), local =TRUE)$value
    
    output$domains <- renderUI(
      {
        tags$div(
          h1("Domains section heading"),
          
          tags$section(
            tags$article(
              h2("Domain 1"),
              p("Text for domain 1")
            ),
            tags$article(
              h2("Domain 2"),
              p("Text for domain 2")
            ),
            tags$article(
              h2("Domain 3"),
              p("Text for domain 3")
            ),
            tags$article(
              h2("Domain 4"),
              p("Text for domain 4")
            ),
            tags$article(
              h2("Domain 5"),
              p("Text for domain 5")
            ),
            tags$article(
              h2("Domain 6"),
              p("Text for domain 6")
            )
          )
          
        )
      }
    )

}

# Run the application
shinyApp(ui=ui, server=server)

### END OF SCRIPT ###
