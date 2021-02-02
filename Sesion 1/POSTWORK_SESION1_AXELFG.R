###############################################################
#Postwork Sesión 1.
###############################################################
#Objetivo
#El Postwork tiene como objetivo que practiques los comandos básicos aprendidos durante la sesión, de tal modo que sirvan para reafirmar
#el conocimiento. Recuerda que la programación es como un deporte en el que se debe practicar, habrá caídas, pero lo importante es levantarse
#y seguir adelante. Éxito

#Requisitos
#Concluir los retos
#Haber estudiado los ejemplos durante la sesión

#Desarrollo
#El siguiente postwork, te servirá para ir desarrollando habilidades como si se tratara de un proyecto que evidencie el progreso
#del aprendizaje durante el módulo, sesión a sesión se irá desarrollando. A continuación aparecen una serie de objetivos que deberás
#cumplir, es un ejemplo real de aplicación y tiene que ver con datos referentes a equipos de la liga española de fútbol (recuerda que los
#datos provienen siempre de diversas naturalezas), en este caso se cuenta con muchos datos que se pueden aprovechar, explotarlos y generar
#análisis interesantes que se pueden aplicar a otras áreas. Siendo así damos paso a las instrucciones:


###############################################################
#   1. Importa los datos de soccer de la temporada 2019/2020 de la primera división de la liga española a R, los datos los puedes encontrar en 
#   el siguiente enlace: https://www.football-data.co.uk/spainm.php
data.url <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

###############################################################
#   2. Del data frame que resulta de importar los datos a R, extrae las columnas que contienen los números de goles anotados por los equipos que
#   jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)

summary(data.url)
str(data.url)

ngoals <- data.url[c("FTHG","FTAG")]
size.ngoals <- dim(data.url)[1]

###############################################################
#   3. Consulta cómo funciona la función table en R al ejecutar en la consola ?table
#Posteriormente elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:
table.x <- table(ngoals$FTHG) #Table del numero de goles que juega en casa (0...6)
table.y <- table(ngoals$FTAG) #Table del numero de goles que juega como visitante (0...6)

#     3.1 - La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)
probx.marg <- table.x / size.ngoals

#     3.2 - La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)
proby.marg <- table.y / size.ngoals

#      3.3 - La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles 
#            (x = 0, 1, 2, ..., y = 0, 1, 2, ...)
probxy.conj <- (table(ngoals$FTHG, ngoals$FTAG)/size.ngoals) #Multiplico por 100 para mostrar el valor porcentual
probxy.conj

