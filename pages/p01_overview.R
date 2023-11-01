####################### Page 1 #######################

output$p01_overview_ui <-  renderUI({

  div(
	     fluidRow(
            h3("This is a header"),
	           p("This is some text"),
	           p(strong("This is some bold text"))

	      ) #fluidrow
   ) # div
}) # renderUI


# Data table example
output$metadata_table <- DT::renderDataTable({
  make_table(all_metadata(), rows_to_display = 10)
})

