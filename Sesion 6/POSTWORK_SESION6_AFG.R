######################################################################
#Postwork Sesión 6.
######################################################################

#Objetivo
#Aprender a crear una serie de tiempo en R

#Requisitos
#Tener instalado R y RStudio
#Haber trabajado con el Prework y el Work

#Desarrollo
library(dplyr)

######################################################################
#1. Importa el conjunto de datos match.data.csv a R y realiza lo siguiente:
url.match.data <- "https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-06/Postwork/match.data.csv"
match.data <- read.csv(url.match.data)
matchD <- mutate(match.data, date = as.Date(date, "%Y-%m-%d")) # Cambiamos a tipo Date

# Vemos los datos
head(matchD)
tail(matchD)
str(matchD)

######################################################################
#  1.1 - Agrega una nueva columna sumagoles que contenga la suma de goles por partido.
matchD <- mutate(matchD, sumagoles = home.score + away.score)

######################################################################
#  1.2 - Obtén el promedio por mes de la suma de goles.
matchD <- mutate(matchD, xmonth = format(date, "%Y-%m")) # Creamos una columna con los meses y el año
matchD <- group_by(matchD, xmonth) # Agrupamos por mes la anterior columna
matchD <- summarise(matchD, goles.promedio = mean(sumagoles)) # Realizamos la sumatoria y obtenemos el promedio de goles.
typeof(matchD) # Vemos que es una lista
matchD <- as.data.frame(matchD) # Convertimos a dataframe
indexDiciembre2019 <- which(matchD$xmonth == "2019-12") # Buscamos el indice de la fecha del 12 de diciembre
matchD1219 <- matchD[1:indexDiciembre2019, ] # Buscamos los meses hasta la fecha del indice

######################################################################
#  1.3 - Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.
prom.goles <- ts(matchD1219$goles.promedio, start = 1, frequency = 10) # Obtemeos los datos para la serie de tiempo
# Gráfica de la serie de tiempo, la cual inciia a partir de agosto del 2010
ts.plot(prom.goles) # Obtenemos un outlier de agosto del 2013.
matchD1219 <- filter(matchD1219, matchD1219$xmonth != "2013-06") # Eliminamos el valor de los datos con el fin de obtener
# una frecuencia de entre año y año de 10 meses
dim(matchD1219) # Obtenemos la dimensión
prom.goles <- ts(matchD1219$goles.promedio, start = 1, frequency = 10) # Obtenemos los datos de nuestra serie de tiempo.

######################################################################
#  1.4 - Grafica la serie de tiempo.
# Comienza la grafica desde agosto del 2010
ts.plot(prom.goles) # Se tiene una frecuencia de 10

