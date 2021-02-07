<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Team-17-Bedu/proyecto">
    <img src="https://github.com/Team-17-Bedu/proyecto/blob/main/img/icono.png" alt="Logo" width="135" height="135">
  </a>

  <h3 align="center"><strong>Países con mayor calidad de vida</strong></h3>

  <p align="center">
    Desarrollo de dashboard para el proyecto
  </p>

</p>

## Objetivos
* Aplicar los conocimientos adquiridos en el módulo programación con R-
* Observar los modelos de regresion lineal para cada uno de los paises disponibles.
* Observar y predecir el posible crecimiento del `IDH` según el país.
* Observar el top 8 de los paises con el _Indice de Desarrollo Humano_ durante el año `2019`.
  
## Requisitos
- RStudio | Jetbrains PyCharm
- R
- Power BI

## Descripción
Una vez definidos los algoritmos que serían capaces de generar los _modelos de regresión lineal_, se prosiguío a concentrar la información obtenida en un [`dashboard`](https://begeistert.shinyapps.io/Proyecto-Team-17/), dividiendo la información e diferentes secciones.

## Desarrollo

Carga de bibliotecas
```r
library(shiny)
library(ggplot2)
library(dplyr)
library(shinydashboard)
library(shinythemes)
```

La aplicación `shiny` fue desarrollada bajo un solo archivo `.R`, por lo que su estructura es de la siguiente manera:
```R
ui <- fluidPage(
    ...
)

server <- function(input, output) {
    ...
}
shinyApp(ui, server)
```

Posteriormente a modo de variable global, se cargo el dataset con los [`IDH`](https://drive.google.com/uc?export=download&id=1guSKT0Ck4pZfSDJWzjZXbr_Qf6UpG_gc) alojado en Google Drive, dentro de una variable llamada `data`
```r
data <- read.csv("https://drive.google.com/uc?export=download&id=1guSKT0Ck4pZfSDJWzjZXbr_Qf6UpG_gc")
```

Posteriormente se preparó un filtro para descartar aquellos paises que no hayan registrado un `IDH`durante `1990`
```r
data <- data[data$X1990 != 0, ]
```

La información se dividio en 4 secciones

### `Modelos de Regresión`

La página mostrada al presionar el item `Modelos de regresión` del sidebar lleva a la siguiente página

<p align="center">
  <a href="https://github.com/Team-17-Bedu/proyecto">
    <img src="https://github.com/Team-17-Bedu/proyecto/blob/main/img/Captura-1-dashboard.png">
  </a>
</p>

Donde ademas de presentar el _modelo de regresión lineal_ para el país seleccionado junto con sus _intervalos de confianza_ e _intervalos de predicción_, también se permite hacer una predicción/estimación del `IDH` en determinado año

<p align="center">
  <a href="https://github.com/Team-17-Bedu/proyecto">
    <img src="https://github.com/Team-17-Bedu/proyecto/blob/main/img/pred.png" >
  </a>
</p>

Por otro lado, existe una pestaña que muestra los registros historicos de `IDH` del país seleccionado

<p align="center">
  <a href="https://github.com/Team-17-Bedu/proyecto">
    <img src="https://github.com/Team-17-Bedu/proyecto/blob/main/img/dash_1.png" >
  </a>
</p>

### `Mapa de IDH`

Este item contiene un hipervinculo hacia la aplicación `shiny` para el [mapa interactivo](https://github.com/Team-17-Bedu/proyecto/blob/main/src/IDHMAP)

### `Tabla`

En esta sección, se presenta el dataset utilizado para la construcción del modelo de regresión

<p align="center">
  <a href="https://github.com/Team-17-Bedu/proyecto">
    <img src="https://github.com/Team-17-Bedu/proyecto/blob/main/img/dash_2.png" >
  </a>
</p>

### `Top 8`
En esta sección se presenta el `Top 8` de países que presentan un mejor IDH, dondé posteriormente se utilizó el módulo para R de Power BI el cual permitió almacenar en una tabla los resultados y así crear una gráfica interactiva. El objetivo principal es dar una vista interactiva al usuario y poder interactuar con toda la información en conjunto. 

<p align="center">
  <a href="https://github.com/Team-17-Bedu/proyecto">
    <img src="https://github.com/Team-17-Bedu/proyecto/blob/main/img/dash_3.png" >
  </a>
</p>

Además de que se muestra una gráfica con las estimaciones del `IDH` para los proximos `10` años

<p align="center">
  <a href="https://github.com/Team-17-Bedu/proyecto">
    <img src="https://github.com/Team-17-Bedu/proyecto/blob/main/img/dash_4.png" >
  </a>
</p>
