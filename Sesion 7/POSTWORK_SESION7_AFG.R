###############################################################
#Postwork.sESIÓN 7 Alojar el fichero a un local host de MongoDB
###############################################################

#OBJETIVO
#  - Realizar el alojamiento del fichero de un fichero .csv a una base de datos (BDD), en un local host de Mongodb a traves de R
#REQUISITOS
#  - Mongodb Compass
#  - librerías mongolite
#  - Nociones básicas de manejo de BDD

#DESARROLLO

###############################################################
#1. Utilizando el manejador de BDD Mongodb Compass (previamente instalado), deberás de realizar las siguientes acciones:
#Importante: Tener instalado previamente MONGO DB de manera local https://docs.mongodb.com/manual/tutorial/install-mongodb-on-windows/

install.packages("mongolite")
library(mongolite) # Incluímos la library de mongolite

#Establecemos el directorio de trabajo, depende de cada usuario
#El archivo a leer se llama data.csv
setwd("E:/Users/afloresgu/Dropbox (GRUPO SALINAS)/2. CURSOS/BEDU DATA SCIENCE/MODULO 2 R Y PYTHON/1. PROGRA Y EST CON R/7. R STUDIO CLOUD/DATA")
url.data <- "https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-07/Postwork/data.csv" # URL de los datos
download.file(url = url.data, destfile = "data.csv", mode = "wb") # Obtenemos los datos y los almacenamos en los data frames.
data.match <- read.csv("E:/Users/afloresgu/Dropbox (GRUPO SALINAS)/2. CURSOS/BEDU DATA SCIENCE/MODULO 2 R Y PYTHON/1. PROGRA Y EST CON R/7. R STUDIO CLOUD/DATA/Data.csv") #Leemos el archivo

###############################################################
# 1.1 - Alojar el fichero data.csv en una base de datos llamada match_games, nombrando al collection como match
mongo_collection = mongo(collection = "match", db = "match_games") # Se crea conexión con MONGO DB, así como la DB y la colección
mongo_collection$insert(data.match) # Insertamos el data Frame a la base de datos

###############################################################
#  1.2 - Una vez hecho esto, realizar un count para conocer el número de registros que se tiene en la base
mongo_collection$count()

###############################################################
#  1.3 - Realiza una consulta utilizando la sintaxis de Mongodb, en la base de datos para conocer el número de goles que metió el Real Madrid el 20 
#        de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?

# Al realizar la busqueda, no se encontraron resultados, debido a que la BD comienza con datos del 2017, por lo que no se puede dar respuesta a esta pregunta específica.
# Se tienen dos alternativas:
#    - Buscar otra fecha de las disponibles dentro de la Base de Datos
#    - Nutrir la Base de Datos, con el fin de abarcar un tiempo mayor de datos y poder dar respuesta a la pregunta
mongo_collection$find('{"Date":"2015-12-20", "HomeTeam":"Real Madrid"}') 
# En esta ocación mandamos la misma búsqueda pero con una fecha distinta (A partir del Año 2017)
# En este caso sí se encontraron resultados el partido fue  Real Madrid (Home Team) vs Valencia (Away Team) y fue empate 2-2
mongo_collection$find('{"Date":"2017-08-27", "HomeTeam":"Real Madrid"}') 


###############################################################
#  1.4 - Por último, no olvides cerrar la conexión con la BDD
rm(mongo_collection) #Cerramos la conexión de MONGO DB
