#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(leaflet)
library(RColorBrewer)
## Dash board para el data set 'mtcars'
library(shinydashboard)
#install.packages("shinythemes")
library(shinythemes)

data <- read.csv("https://drive.google.com/uc?export=download&id=1guSKT0Ck4pZfSDJWzjZXbr_Qf6UpG_gc")
data <- data[data$X1990 != 0, ]

#Esta parte es el análogo al ui.R
ui <- fluidPage(
    
    dashboardPage(
        
        dashboardHeader(title = "Analisis del IDH"),
        
        dashboardSidebar(
            
            sidebarMenu(
                menuItem("Modelos de Regresión", tabName = "linear", icon = icon("chart-line")),
                menuItem(a("Mapa de IDH", href = "https://begeistert.shinyapps.io/IDHMap/"), tabName = "map_t"),
                menuItem("Tabla", tabName = "data_table", icon = icon("table")),
                menuItem("Top 8", tabName = "top", icon = icon("star"))
            )
            
        ),
        dashboardBody(
            tabItems(
                # Histograma
                tabItem(tabName = "linear",
                        fluidRow(
                            column(width = 3, box(
                                title = "Parametros", width = NULL, status = "primary",
                                p("Crear plots del IDH, junto con el modelo de regresion lineal y sus intervalos de confianza"),
                                selectInput("x", "Seleccione el país",
                                            choices = data$Country),
                                selectInput("pred_year", "Seleccione el año del cual desea estimar el IDH",
                                            choices = 1900:2100, selected = 2021),
                            )),
                            column(width = 9,
                                   tabsetPanel(type = "tabs",
                                               tabPanel("Modelos de Regresión",
                                                        h3(textOutput("output_text")),
                                                        includeMarkdown("https://drive.google.com/uc?export=download&id=1V1QNtISzE9WIiCRBUJVfV8nzx1l4ktSV"),
                                                        plotOutput("output_plot"),
                                                        h4(textOutput("pred_text")),
                                                        verbatimTextOutput("prediction"),
                                                        includeMarkdown("https://drive.google.com/uc?export=download&id=1QifvXK1LayWJ1yzLGry9-nIzuS2Ah5g8"),
                                               ),
                                               tabPanel("Registros Historicos del País",
                                                        dataTableOutput("table")
                                               )
                                   )
                            )
                        )
                ),
                
                # Dispersión
                tabItem(tabName = "map_t",
                        fluidRow(
                            
                        )
                ),
                
                
                
                tabItem(tabName = "data_table",
                        fluidRow(
                            dataTableOutput("data_table")
                        )
                ),
                
                tabItem(tabName = "top",
                        fluidRow(
                            column(width = 3, box(
                                title = "Top 8", width = NULL, status = "primary",
                                p("Selecciona el país"),
                                selectInput("x_top", "Seleccione el país",
                                            choices = arrange(data, -X2019)[1:8, 1])
                            )),
                            column(width = 9,
                                   tabsetPanel(type = "tabs",
                                               tabPanel("Paises con el mejor IDH",
                                                        h3(textOutput("output_text_top")),
                                                        textOutput("idh_top"),
                                                        plotOutput("output_plot_top"),
                                               ),
                                               tabPanel("Expectativas de Crecimiento del IDH ",
                                                        h3(textOutput("output_text_IDH")),
                                                        textOutput("idh_plot"),
                                                        plotOutput("output_plot_IDH")
                                               )
                                   )
                            )
                        )
                )
            )
        )
    )
)

#De aquí en adelante es la parte que corresponde al server

server <- function(input, output) {
    
    output$output_text <- renderText(paste("IDH de", input$x))   #Titulo del main Panel
    # Cambio de nombre de columnas
    
    #Gráficas                       <----------
    output$output_plot <- renderPlot({
        Country <- data[data$Country == input$x, 2:length(data)]
        Country <- t(Country)
        Country <- as.data.frame(cbind(1990:2019, Country))
        colnames(Country) <- c("Year", "IDH")
        attach(Country)
        m1 <- lm(IDH ~ Year)
        plot(Year, IDH, xlab = "Año",
             ylab = "IDH", pch = 16)
        abline(lsfit(Year, IDH))
        Year0 <- c(1990, 1994, 1998, 2002, 2006, 2010, 2014, 2018)
        conf <- predict(m1, newdata = data.frame(Year = Year0),
                        interval = "confidence", level = 0.95)
        lines(Year0, conf[, 2], lty = 2, lwd = 2, col = "green") # límites inferiores
        lines(Year0, conf[, 3], lty = 2, lwd = 2, col = "green") # límites superiores
        (pred <- predict(m1, newdata = data.frame(Year = Year0),
                         interval = "prediction", level = 0.95))
        lines(Year0, pred[, 2], lty = 2, lwd = 2, col = "blue") # límites inferiores
        lines(Year0, pred[, 3], lty = 2, lwd = 2, col = "blue") # límites superiores
        legend("bottomright", legend = c("Intervalos de confianza", "Intervalos de predicción"),
               lty = 2,lwd = 2, col = c("green", "blue"))
        legend("topleft", legend = "Modelo de regresion Lineal",
               lwd = 2, col = "black")
    })
    
    output$pred_text <- renderText(paste("Estimaciones de IDH para", input$x, "correspondiente al año", input$pred_year))
    
    output$prediction <- renderPrint({
        Country <- data[data$Country == input$x, 2:length(data)]
        Country <- t(Country)
        Country <- as.data.frame(cbind(1990:2019, Country))
        colnames(Country) <- c("Year", "IDH")
        attach(Country)
        m1 <- lm(IDH ~ Year)
        predict(m1, newdata = data.frame(Year = as.numeric(input$pred_year)),
                interval = "prediction", level = 0.95)
    })
    output$table <- renderDataTable({
        Country <- data[data$Country == input$x, 2:length(data)]
        Country <- t(Country)
        Country <- as.data.frame(cbind(1990:2019, Country))
        colnames(Country) <- c("Año", paste("Indice de Desarrollo Humano de", input$x))
        Country
    }, options = list(aLengthMenu = c(5,25,50),
                      iDisplayLength = 5))
    output$data_table <- renderDataTable({data},
                                         options = list(aLengthMenu = c(5, 25, 50),
                                                        iDisplayLength = 20, scrollX = TRUE))
    
    output$output_plot_top <- renderPlot({
        Country <- data[data$Country == input$x_top, 2:length(data)]
        Country <- t(Country)
        Country <- as.data.frame(cbind(1990:2019, Country))
        colnames(Country) <- c("Year", "IDH")
        attach(Country)
        m1 <- lm(IDH ~ Year)
        plot(Year, IDH, xlab = "Año",
             ylab = "IDH", pch = 16)
        abline(lsfit(Year, IDH))
        Year0 <- c(1990, 1994, 1998, 2002, 2006, 2010, 2014, 2018)
        conf <- predict(m1, newdata = data.frame(Year = Year0),
                        interval = "confidence", level = 0.95)
        lines(Year0, conf[, 2], lty = 2, lwd = 2, col = "green") # límites inferiores
        lines(Year0, conf[, 3], lty = 2, lwd = 2, col = "green") # límites superiores
        (pred <- predict(m1, newdata = data.frame(Year = Year0),
                         interval = "prediction", level = 0.95))
        lines(Year0, pred[, 2], lty = 2, lwd = 2, col = "blue") # límites inferiores
        lines(Year0, pred[, 3], lty = 2, lwd = 2, col = "blue") # límites superiores
        legend("bottomright", legend = c("Intervalos de confianza", "Intervalos de predicción"),
               lty = 2,lwd = 2, col = c("green", "blue"))
        legend("topleft", legend = "Modelo de regresion Lineal",
               lwd = 2, col = "black")
    })
    
    output$output_text_top <- renderText(paste("IDH de", input$x_top))
    output$idh_top <- renderText({
        top_8 <- arrange(data, -X2019)[1:8, 1]
        paste(input$x_top, "uno de los paises pertenecientes al Top 8 de paises con el mejor Indice de Desarrollo Humano durante el año 2019")
    })
    output$output_plot_IDH <- renderPlot({
        Country <- data[data$Country == input$x_top, 2:length(data)]
        Country <- t(Country)
        Country <- as.data.frame(cbind(1990:2019, Country))
        colnames(Country) <- c("Year", "IDH")
        attach(Country)
        m1 <- lm(IDH ~ Year)
        Year0 <- 2021:2031
        (pred <- predict(m1, newdata = data.frame(Year = Year0),
                         interval = "prediction", level = 0.95))
        plot(Year0, pred[, 1], xlab = "Año",
             ylab = "IDH", pch = 16)
    })
    
    output$output_text_IDH <- renderText(paste("Expectativas de crecimiento para", input$x_top, "durante los proximos 10 años"))
    
}
shinyApp(ui, server)
