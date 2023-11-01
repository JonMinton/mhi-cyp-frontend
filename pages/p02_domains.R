


output$p02_indicators_domains_ui <-  renderUI({
  
  div(
    fluidRow(
      h3("Domains and indicators"),
      p("Here are the domains and indicators"),
      tags$ul(
        lapply(
          lines,
          function(x) tags$li(x)
        )
      )
    ) #fluidrow
  ) # div
}) # renderUI