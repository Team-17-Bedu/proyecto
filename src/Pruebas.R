library(ggplot2)

# Asignacion dinamica del directorio de trabajo
dir <- paste0(getwd(), "/datasets")
setwd(dir)

data <- read.csv("Human Development Index (HDI).csv")

MEX <- data[75, 3:length(data)]
MEX <- t(MEX)
MEX <- as.data.frame(cbind(2003:2019, MEX))
colnames(MEX) <- c("Year", "IDH")

ggplot(MEX, aes(x=Year, y = IDH)) +
  geom_point()  # Tipo de geometría, intenta utilizar alguna otra

hist(MEX$IDH)