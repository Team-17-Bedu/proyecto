library(ggplot2)
library(dplyr)
library(e1071)

# Asignacion dinamica del directorio de trabajo
dir <- paste0(getwd(), "/datasets")
setwd(dir)

data <- read.csv("HDI_clean.csv")
data <- data[ , 3:length(data)]
write.csv(data, "HDI_clean.csv")

MEX <- data[data$Country == "Mexico", 4:length(data)]
MEX <- t(MEX)
MEX <- as.data.frame(cbind(1990:2019, MEX))
colnames(MEX) <- c("Year", "IDH")

ggplot(MEX, aes(x=Year, y = IDH)) +
  geom_point()  # Tipo de geometría, intenta utilizar alguna otra

attach(MEX)

m1 <- lm(IDH ~ Year)

summary(m1)

plot(Year, IDH, xlab = "Año",
     ylab = "IDH", pch = 16)
abline(lsfit(Year, IDH))

tval <- qt(1-0.05/2, 28)

pt(tval, df = 28)

round(confint(m1, level = 0.95), 3)

Year0 <- c(1990, 1994, 1998, 2002, 2006, 2010, 2014, 2018)

(conf <- predict(m1, newdata =
                   data.frame(Year = Year0),
                 interval = "confidence", level = 0.95))

lines(Year0, conf[, 2], lty = 2, lwd = 2, col = "green") # límites inferiores
lines(Year0, conf[, 3], lty = 2, lwd = 2, col = "green") # límites superiores

(pred <- predict(m1, newdata =
          data.frame(Year = Year0),
        interval = "prediction", level = 0.95))

lines(Year0, pred[, 2], lty = 2, lwd = 2, col = "blue") # límites inferiores
lines(Year0, pred[, 3], lty = 2, lwd = 2, col = "blue") # límites superiores

anova(m1)

par(mfrow = c(2, 2))
plot(m1)
dev.off()

IDH_2020 <- predict(m1, newdata =
          data.frame(Year = 2021),
        interval = "prediction", level = 0.95)


#####################################################
train <- sample(nrow(MEX),
               round(nrow(MEX)/2))

best <- svm(IDH~.,  data = MEX[train,],
            kernel = "linear",
            cost = 100,
            gamma = 1.51
            )

mc <- table(true = MEX[-train, "IDH"],
            pred = predict(best,
                           newdata = MEX[-train,]))

IDH_2020 <- predict(best, 2020)