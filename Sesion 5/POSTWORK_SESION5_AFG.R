##########################################################################
#Postwork Sesión 5
##########################################################################

#OBJETIVO
#  - Continuar con el desarrollo de los postworks; en esta ocasión se utiliza la función predict para realizar predicciones de los resultados de partidos para
#   una fecha determinada

#REQUISITOS
#  - Haber desarrollado los postworks anteriores
#  - Cubrir los temas del prework
#  - Replicar los ejemplos de la sesión

#DESARROLLO

install.packages("fbRanks")

library(dplyr) # Cargamos la bibliotecas de dplyr como dice el problema.
library(fbRanks) # Cargamos la biblioteca fbRanks

############################################################################
#  1. A partir del conjunto de datos de soccer de la liga española de las temporadas 2017/2018, 2018/2019 y 2019/2020, crea el data frame SmallData, que contenga
#     las columnas date, home.team, home.score, away.team y away.score; esto lo puede hacer con ayuda de la función select del paquete dplyr. Luego establece un
#     directorio de trabajo y con ayuda de la función write.csv guarda el data frame como un archivo csv con nombre soccer.csv. Puedes colocar como argumento 
#     row.names = FALSE en write.csv.

spain.1718 <- read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv") # Buscamos Datos y los leemos asignandolos a DataFrames
spain.1819 <- read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
spain.1920 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

spain.1720 <- list(spain.1718, spain.1819, spain.1920)
spain.1720 <- lapply(spain.1720, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR) #Seleccionamos las variables requeridas
lapply(spain.1720, FUN = function(x) { str(x)}) # Buscamos la información

spain.1720[[1]] <- mutate(spain.1720[[1]], Date = as.Date(Date, "%d/%m/%y")) #Ajustamos el formato de la fecha a Date
spain.1720[[2]] <- mutate(spain.1720[[2]], Date = as.Date(Date, "%d/%m/%Y")) #Ajustamos el formato de la fecha a Date
spain.1720[[3]] <- mutate(spain.1720[[3]], Date = as.Date(Date, "%d/%m/%Y")) #Ajustamos el formato de la fecha a Date

spain.1720 <- do.call(rbind, spain.1720) # Creamos un solo DataFrame con todos los datos a través de rbind

str(spain.1720)  # str nos muestra el tipo de objeto, número de observaciones y de variables, así como el tipo de dato al que corresponde cada variable
dim(spain.1720)  # dim para obtener la dimensión
head(spain.1720) # Obtenemos los primeros y los últimos 6 elementos.
tail(spain.1720) 
 
# Creamos un dataframe que contenga los datos requeridos con los nombres indicados
SmallData <- select(spain.1720, date = Date, home.team = HomeTeam, home.score = FTHG, away.team = AwayTeam, away.score = FTAG)

# Escribimos los datos en un archivo llamado soccer.csv 
write.csv(SmallData, "soccer.csv", row.names = F)


##########################################################################
#  2. Con la función create.fbRanks.dataframes del paquete fbRanks importe el archivo soccer.csv a R y al mismo tiempo asignelo a una variable llamada listasoccer.
#     Se creará una lista con los elementos scores y teams que son data frames listos para la función rank.teams. Asigna estos data frames a variables 
#     anotaciones y equipos.

listasoccer <- create.fbRanks.dataframes("soccer.csv") # En lista soccer creamos la lista de elementos scores y teams para la funcion rank.teams
anotaciones <- listasoccer$scores # Asignamos a la variable antotaciones
equipos <- listasoccer$teams # Asignamos a la variable equipos

##########################################################################
#  3. Con ayuda de la función unique crea un vector de fechas (fecha) que no se repitan y que correspondan a las fechas en las que se jugaron partidos. Crea una
#     variable llamada n que contenga el número de fechas diferentes. Posteriormente, con la función rank.teams y usando como argumentos los data frames anotaciones
#     y equipos, crea un ranking de equipos usando unicamente datos desde la fecha inicial y hasta la penúltima fecha en la que se jugaron partidos, estas fechas
#     las deberá especificar en max.date y min.date. Guarda los resultados con el nombre ranking.

fecha <- unique(anotaciones$date) # Obtenemos las fechas unicas por cada partido
n <- length(fecha) # Obtenemos el tamaño de la lista de las fechas
ranking.teams <- rank.teams(scores = anotaciones, teams = equipos, min.date = fecha[1], max.date = fecha[n-1]) # Obtenemos el ranking por equipo

##########################################################################
#  4. Finalmente estima las probabilidades de los eventos, el equipo de casa gana, el equipo visitante gana o el resultado es un empate para los partidos que se 
#     jugaron en la última fecha del vector de fechas fecha. Esto lo puedes hacer con ayuda de la función predict y usando como argumentos ranking y fecha[n] que 
#     deberá especificar en date.
predicion <- predict(ranking.teams, date = fecha[n]) # Obtenemos  probabilidades de los eventos

