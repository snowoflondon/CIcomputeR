#Load R packages
library(shiny)
library(shinythemes)
library(tidyverse)
library(CIcomputeR)
library(cowplot)

# UI function
ui <- fluidPage(theme = shinytheme("cosmo"),
                navbarPage("CIcomputeR v1.0"), 
                titlePanel('CIcomputeR v1.0'),
                # Side panel for user input & main panel for figures
                sidebarLayout(position = 'left',
                              sidebarPanel = sidebarPanel(fileInput("myfileinput", 
                                                                    label = 'Choose file to upload',
                                                                    accept = c('text/csv',
                                                                               'text/comma-separated-values',
                                                                               '.csv')),
                                                          actionButton('mybutton', label = 'Run CIcomputeR'),
                                                          tableOutput('mytable'),
                                                          downloadButton('myfiledownload', label = 'Download File')),
                              mainPanel = mainPanel('Figures', plotOutput('myplot', width = '1200px', height = '500px'))))


# Server function 
server <- function(input, output) {
  reactives <- reactiveValues(df_output = NULL)
  observeEvent(input$mybutton, {
    # Flag notification if no file uploaded by user
    if(!is.null(input$myfileinput)){
      df_input <- read_csv(input$myfileinput$datapath)
      # Run core CIcomputeR
      reactives$df_output <- computeCI(data = df_input, 
                                       edvec = seq(from = 0.05, to = 0.95, by = 0.05),
                                       frac1 = max(df_input$Conc1),
                                       frac2 = max(df_input$Conc2),
                                       viability_as_pct = FALSE)
      # Accessory figures
      tmp <- df_input %>% as_tibble() %>% mutate(
        Drug = case_when(Conc1 !=0 & Conc2 !=0 ~ 'Combo', 
                         Conc1 !=0 & Conc2 ==0 ~ unique(df_input$Drug1),
                         Conc1 ==0 & Conc2 !=0 ~ unique(df_input$Drug2))) %>%
        select(-c(Drug1, Drug2)) %>% group_by(Drug) %>% group_split()
      tmp <- lapply(tmp, function(x) x %>% group_by(Conc1, Conc2) %>%
                      mutate(`Dose Level` = cur_group_id()) %>% ungroup())
      tmp <- bind_rows(tmp)
      # Grid figures
      reactives$plot_output <- plot_grid(CIplot(CIdata = reactives$df_output, 
                                                edvec = c(0.05, 0.95)),
                                         MEplot(data = df_input, viability_as_pct = FALSE), 
                                         ggplot(tmp, aes(x = `Dose Level`, y = Response, color = Drug)) 
                                         + geom_point() + geom_line(aes(group = Drug)) + theme_classic() 
                                         + theme(legend.position = 'bottom', text = element_text(size=14))
                                         + xlab('Dose Level - higher the level, higher the dosage'),
                                         ncol = 2)
      showNotification("File successfully processed", type = "message")
    } else { 
      showNotification("Ensure file is uploaded", type  = "error") #error notification pop-up
    }
  })
  output$mytable <- renderTable({
    reactives$df_output}
  )
  output$myplot <- renderPlot({
    reactives$plot_output
  })
  # Allow user download of CI result
  output$myfiledownload <- downloadHandler(
    filename = 'CIcomputerR_result.csv', #default file name
    content = function(file) {
      write.csv(reactives$df_output, file, row.names = FALSE)
    }
  )
}

# Create Shiny object
shinyApp(ui = ui, server = server)