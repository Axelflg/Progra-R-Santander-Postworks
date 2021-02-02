###############################################################################
#Postwork Sesión 3
###############################################################################

#Objetivo
#  - Realizar descarga de archivos desde internet
#  - Generar nuevos data frames
#  - Visualizar probabilidades estimadas con la ayuda de gráficas

#Requisitos
#  - R, RStudio
#  - Haber realizado el prework y seguir el curso de los ejemplos de la sesión
#  - Curiosidad por investigar nuevos tópicos y funciones de R

#Desarrollo
# Ahora graficaremos probabilidades (estimadas) marginales y conjuntas para el número de goles que anotan en un partido el equipo de casa o el equipo
# visitante.

library(stringr)
library(ggplot2)

###############################################################################
#  1. Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:

# Leemos el CSV que creamos en la sesión 2,la ruta depende de en donde hayas creado el archivo de la sesión 2
# La ruta depende de cada usuario, el archivo esta en la carpeta Data y se llama spain.1720.csv
spain.1720 <- read.csv("E:/Users/afloresgu/Dropbox (GRUPO SALINAS)/2. CURSOS/BEDU DATA SCIENCE/MODULO 2 R Y PYTHON/1. PROGRA Y EST CON R/2. PROG Y MAN DATOS R/DATA/SOCCER POST/spain.1720.csv")
str(spain.1720) # str nos muestra el tipo de objeto, número de observaciones y de variables, así como el tipo de dato al que corresponde cada variable
ngoals <- spain.1720[c("FTHG","FTAG")]
size.ngoals <- dim(spain.1720)[1] # Tamaño del DataFrame

table.x <- table(ngoals$FTHG) #Table del numero de goles que juega en casa (0...6)
table.y <- table(ngoals$FTAG) #Table del numero de goles que juega como visitante (0...6)

###############################################################################
#    1.1 - La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
probx.marg <- table.x / size.ngoals 

###############################################################################
#    1.2 - La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
proby.marg <- table.y / size.ngoals

###############################################################################
#    1.3 - La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
probxy.conj <- (table(ngoals$FTHG, ngoals$FTAG)/size.ngoals) #Multiplico por 100 para mostrar el valor porcentual
probxy.conj


###############################################################################
#Realiza lo siguiente:
#  2. Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa

probx.marg.df <- as.data.frame(probx.marg) #Convertimos a DataFrame
str(probx.marg.df)
probx.marg.df <- mutate(probx.marg.df, Var1 = as.numeric(Var1)) # Cambiamos el tipo de dato como numérico

probx.marg.df %>%
  ggplot() + 
  aes(x=Var1, y=Freq) +
  geom_bar(stat='identity', aes(fill=Freq), position='dodge') + 
  ggtitle("Gráfico de Barras de la probabilidad (marginal)") +
  ylab("Probabilidad Marginal de anotar goles") +
  xlab("Número de Goles Equipo Casa") +
  theme_light() + # Sirve para hacer el fondo claro
  geom_text(aes(label = Var1), size = 3, hjust = 0, vjust = -0.5, position = "stack") 

###############################################################################
#    2.1 - Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.
proby.marg.df <- as.data.frame(proby.marg) #Convertimos a DataFrame
str(proby.marg.df)
proby.marg.df <- mutate(proby.marg.df, Var1 = as.numeric(Var1)) # Cambiamos el tipo de dato como numérico

proby.marg.df %>%
  ggplot() + 
  aes(x=Var1, y=Freq) +
  geom_bar(stat='identity', aes(fill=Freq), position='dodge') + 
  ggtitle("Gráfico de Barras de la probabilidad (marginal)") +
  ylab("Probabilidad Marginal de anotar goles") +
  xlab("Número de Goles Equipo Visitante") +
  theme_light() + # Sirve para hacer el fondo claro
  geom_text(aes(label = Var1), size = 3, hjust = 0, vjust = -0.5, position = "stack") 

###############################################################################
#    2.2 - Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo
#          visitante en un partido.
chart.probxy.conj <- as.data.frame(probxy.conj)
chart.probxy.conj <- rename(chart.probxy.conj, ngoalsx = Var1, ngoalsy = Var2, Frecuencia = Freq)
str(chart.probxy.conj)

chart.probxy.conj %>% ggplot(aes(ngoalsx, ngoalsy)) + 
  geom_tile(aes(fill=Frecuencia)) + 
  ggtitle("HeatMap de Probabilidades conjuntas Núm Goles Casa y Visitante") + 
  scale_fill_gradient(low = "white", high = "orange") +
  ylab("Probabilidad Conjunta y") +
  xlab("Probabilidad Conjunta x") 
