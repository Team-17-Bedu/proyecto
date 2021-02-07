#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(RColorBrewer)

data <- read.csv("https://drive.google.com/uc?export=download&id=1rg2EoCzCRXIBkWpCgm3KD3gCeWjz8pGz")


ui <- bootstrapPage(
    tags$style(type = "text/css", "html, header {width:100%;height:10%}"),
    tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
    leafletOutput("map", width = "100%", height = "100%"),
    absolutePanel(top = 10, right = 10,
                  selectInput("anio", "Periodos", choices = 1990:2019
                  ),
                  selectInput("colors", "Color del esquema",
                              rownames(subset(brewer.pal.info, category %in% c("seq", "div")))
                  ),
                  checkboxInput("legend", "Rangos IDH", TRUE)
                  
    )
)

server <- function(input, output, session) {
    
    # Reactive expression for the data subsetted to what the user selected
    filteredData <- reactive({
        data[data[, paste0("X",input$anio), drop=TRUE] >= 0 & data[, paste0("X",input$anio), drop=TRUE] <= 1,]
    })
    
    # This reactive expression represents the palette function,
    # which changes as the user makes selections in UI.
    colorpal <- reactive({
        #(input$colors,data$TOP )
        colorQuantile(input$colors, data[, paste0("X",input$anio), drop=TRUE], n = 10)
    })
    
    
    output$map <- renderLeaflet({
        # Use leaflet() here, and only include aspects of the map that
        # won't need to change dynamically (at least, not unless the
        # entire map is being torn down and recreated).
        leaflet(data) %>% addTiles() %>%
            fitBounds(~min(longitude), ~min(latitude), ~max(longitude), ~max(latitude))
    })
    
    # Incremental changes to the map (in this case, replacing the
    # circles when a new color is chosen) should be performed in
    # an observer. Each independent set of things that can change
    # should be managed in its own observer.
    observe({
        pal <- colorpal()
        #pal <- colorQuantile("Green", data$X2019, n = 7)
        auxx <- data[ , paste0("X",input$anio)]
        leafletProxy("map", data = filteredData()) %>%
            clearShapes() %>%
            addCircles(radius = ~sqrt(30000000*auxx)*30, stroke = FALSE,
                       fillColor = ~pal(auxx),fillOpacity = 0.8,popup = ~paste(Country,auxx,sep=": ")
            )
    })
    
    # Use a separate observer to recreate the legend as needed.
    observe({
        proxy <- leafletProxy("map", data = data)
        IDH <- data[ , paste0("X",input$anio)]
        # Remove any existing legend, and only if the legend is
        # enabled, create a new one.
        proxy %>% clearControls()
        if (input$legend) {
            pal <- colorpal()
            proxy %>% addLegend(position = "bottomright",
                                pal = pal, values = IDH
            )
        }
    })
    gc()
}

shinyApp(ui, server)