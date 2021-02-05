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
PIB <- read.csv("Dataset_pib.csv")

#tabla de indices de ingreso 04:19
#formula Índice de Ingreso = log(x) – log(100) / log(75000) – log(100)
Indice <- (log(PIB[, 3:length(PIB)]) - log(100)) / (log(40000) - log(100))
Indice_Ingreso <- cbind(PIB[,1], Indice)
TablaIndiceIngreso <- data.frame(Indice_Ingreso)
colnames(TablaIndiceIngreso)[1] <- "Country_Name"


# Lectura del dataset con los indices de educacion
TablaIndiceEducacion <- read.csv("Dataset_edu.csv")

TablaIndiceEducacion <- TablaIndiceEducacion[ , c(1,3:18)]

# Lectura del dataset con los registros de esperanza de vida
Vida <- read.csv("Dataset_vida.csv")

Vida <- Vida[ , c(1, 3:18)]

Indice_Salud <- (Vida[, 2:length(Vida)] - 20) / (85 - 20)
Indice_Salud <- cbind(Vida[,1], Indice_Salud)
TablaIndiceSalud<-data.frame(Indice_Salud)
colnames(TablaIndiceSalud)[1] <- "Country_Name"

# Calculo del IDH
IDH <-  (TablaIndiceIngreso[, 2:length(TablaIndiceIngreso)] / 3) + 
        (TablaIndiceEducacion[, 2:length(TablaIndiceEducacion)] / 3) +  
        (TablaIndiceSalud[, 2:length(TablaIndiceSalud)] / 3)

IDH <- cbind(PIB[1:2],IDH)