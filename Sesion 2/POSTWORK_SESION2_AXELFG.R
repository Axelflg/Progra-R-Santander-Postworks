#########################################################################
#Postwork Sesi�n 2.
#########################################################################

#Objetivo
# - Importar m�ltiples archivos csv a R
# - Observar algunas caracter�sticas y manipular los data frames
# - Combinar m�ltiples data frames en un �nico data frame

#Requisitos
# - Tener instalado R y RStudio
# - Haber realizado el prework y estudiado los ejemplos de la sesi�n.

#Desarrollo
# Ahora vamos a generar un c�mulo de datos mayor al que se ten�a, esta es una situaci�n habitual que se puede presentar para complementar un an�lisis, siempre es importante
# estar revisando las caracter�sticas o tipos de datos que tenemos, por si es necesario realizar alguna transformaci�n en las variables y poder hacer operaciones aritm�ticas
# si es el caso, adem�s de s�lo tener presente algunas de las variables, no siempre se requiere el uso de todas para ciertos procesamientos.


#########################################################################
# 1. Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera divisi�n de la liga espa�ola a R, los datos los puedes encontrar en el
#    siguiente enlace: https://www.football-data.co.uk/spainm.php
getwd()
# Asignar el directorio de trabajo en el que se desea trabajar, depende de cada usuario
setwd("E:/Users/afloresgu/Dropbox (GRUPO SALINAS)/2. CURSOS/BEDU DATA SCIENCE/MODULO 2 R Y PYTHON/1. PROGRA Y EST CON R/2. PROG Y MAN DATOS R/DATA/SOCCER POST") 

u1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv" #Descargamos los archivos requeridos
u1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
u1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = u1718, destfile = "SP1-1718.csv", mode = "wb") #Guardamos los archivos requeridos en CSV
download.file(url = u1819, destfile = "SP1-1819.csv", mode = "wb")
download.file(url = u1920, destfile = "SP1-1920.csv", mode = "wb")

#podemos leer con una sola instrucci�n los archivos descargados usando la funci�n lapply de la siguiente manera
lista <- lapply(dir(), read.csv) # Guardamos los archivos en lista

#########################################################################
# 2. Obten una mejor idea de las caracter�sticas de los data frames al usar las funciones: str, head, View y summary
str(lista) # str nos muestra el tipo de objeto, n�mero de observaciones y de variables, as� como el tipo de dato al que corresponde cada variable
head(lista) # head nos muestra los primeros 6 elementos dentro nuestro data frame.
View(lista) # View nos muestra los datos en formato de tabla
summary(lista) # summary es una funci�n gen�rica usada para obtener resumenes de diferentes objetos de R

#########################################################################
# 3. Con la funci�n select del paquete dplyr selecciona �nicamente las columnas Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los 
#    data frames. 
#    (Hint: tambi�n puedes usar lapply).
library(dplyr)
lista <- lapply(lista, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR) # seleccionamos solo las columnas requeridas

#########################################################################
# 4. Aseg�rate de que los elementos de las columnas correspondientes de los nuevos data frames sean del mismo tipo (Hint 1: usa as.Date y mutate para
#    arreglar las fechas).
head(lista[[1]]); head(lista[[2]]); head(lista[[3]]) #Verifico los tipos de dato de cada dataFrame
lista[[1]] <- mutate(lista[[1]], Date = as.Date(Date, "%d/%m/%y")) # Cambiamos el tipo de dato fecha (dd/mm/yy) del DataFrame 1
for (i in 2:length(lista) ) {
  lista[[i]] <- mutate(lista[[i]], Date = as.Date(Date, "%d/%m/%Y")) # Cambiamos el tipo de dato fecha (dd/mm/YYYY) de los DataFrame 2 y 3
}
str(lista) # Verificamos que los tipos de datos correctos

#  Con ayuda de la funci�n rbind formamos un �nico data frame que contenga las seis columnas mencionadas en el punto 3 (Hint 2: la funci�n do.call podr�a ser utilizada).
data <- do.call(rbind, lista) # Combinamos cada uno de los data frames en un �nico data frame
head(data)
tail(data)
dim(data)

# Ordenamos nuestro dataframe de acuerdo a la fecha en forma ascendente
spain.1720 <- data[order(data$Date), ]

# Guardamos el DataFrame en un archivo CSV
write.csv(spain.1720, "spain.1720.csv", row.names = F)
