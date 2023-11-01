
####################### Intro Page #######################

output$intro_page_ui <-  renderUI({

  div(
	     fluidRow(
            h3("MHI Children and Young People"),
	           p(paste("There are currently", n_indicators(), "indicators.")), 
             p(paste(
                "Of these,", n_indicators_dataless(), 
                "are currently dataless, and", n_indicators_not_dataless(), 
                "have sources identified."
            ))
        ) #fluidrow
   ) # div
}) # renderUI
