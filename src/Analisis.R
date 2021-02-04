# Title     : Calculo del IDH
# Objective : Calcular el Indice de Desarrollo Humano
# Created by: Equipo 17

# Asignacion dinamica del directorio de trabajo
dir <- paste0(getwd(), "/datasets")
setwd(dir)

#librerias 
install.packages("dplyr")
library(dplyr)



# Lectura del dataset con los registros del PIB
PIB <- read.csv("datapibeng.csv")

# Seleccionar las dos columnas principales y los ultimos 15 años 
PIB <- PIB[, c(2,47:62)]

#tabla de indices de ingreso 04:19
#formula Índice de Ingreso = log(valor row) – log(100) / log(75.000) – log(100) = 0,70
Indice <- (log(PIB[, 2:length(PIB)]) - log(100)) / (log(75000) - log(100))
Indice_Ingreso <- cbind(PIB[,1], Indice)
TablaIndiceIngreso<-data.frame(Indice_Ingreso)
colnames(TablaIndiceIngreso)[1] <- "Country"


# Lectura del dataset con los indices de educacion
TablaIndiceEducacion <- read.csv("Education index.csv")

TablaIndiceEducacion <- TablaIndiceEducacion[ , c(2,16:31)]

# Lectura del dataset con los registros de esperanza de vida
Vida <- read.csv("esperanzavida.csv")

Vida <- Vida[ , c(1, 48:63)]

Indice_Salud <- (Vida[, 2:length(Vida)] - 20) / (85 - 20)
