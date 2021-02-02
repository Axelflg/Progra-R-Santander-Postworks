#######################################################################
#Postwork Sesión 4
#######################################################################

#Objetivo
#  - Investigar la dependencia o independecia de las variables aleatorias X y Y, el número de goles anotados por el equipo de casa y el número de
#    goles anotados por el equipo visitante.

#Requisitos
#  - R, RStudio
#  - Haber trabajado con el Prework y el Work

#Desarrollo

"Ahora investigarás la dependencia o independencia del número de goles anotados por el equipo de casa
y el número de goles anotados por el equipo visitante mediante un procedimiento denominado bootstrap
revisa bibliografía en internet para que tengas nociones de este desarrollo."

install.packages("here")

library(stringr)
library(reshape2)
library(here)
library(dplyr)

#data <- read.csv('SP1.csv')
data <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

size.registers <- dim(data)[1]

goals.fthg <- data$FTHG
goals.ftag <- data$FTAG

marginal_casa <- (table(goals.fthg) / size.registers)
marginal_fuera <- (table(goals.ftag) / size.registers)
conjunta <- (table(goals.fthg, goals.ftag) / size.registers)


"1. Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles (x=0,1,... ,8),
y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. Obtén una tabla de cocientes al dividir
estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes."


(t_cocientes <- apply(conjunta, 2, function (c) c / marginal_casa)) #Divido todo el dataframe por la probabilidad marginal casa, con el 2 indica que se va a dividir por columna
(t_cocientes <- apply(t_cocientes, 1, function (r) r / marginal_fuera))  #Divido todo el dataframe por la probabilidad marginal fuera, con el 1 indica que se va a dividir por fila
(t_cocientes <- t(t_cocientes)) #al dividir dos veces es lo mismo que si dividiera entre el producto de las probabilidades marginales, se aplica una transpuesta para obtener el ordenamiento original

t_cocientes  #Esta es la tabla de cocientes.

"2. Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla del punto anterior.
Esto para tener una idea de las distribuciones de la cual vienen los cocientes en la tabla anterior.
Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla en el punto 1,
son iguales a 1 (en tal caso tendríamos independencia de las variables aleatorias X y Y)."
#Extraer de manera aleatoria algunas filas de nuestro data frama.

set.seed(66)

Lista_matrices_BOT = list() #Se crea una lista vacía en donde se guardaran las muestras generadas.
Num.muestras.bot = 10 #Esta variable nos da el número de muestras que queremos que nos realice le proceso de bootstrap.


for (k in 1:100) {
  muestras <- sample(size.registers, size = 380, replace = TRUE) #Genera números aleatorios del 1 al númeor maximo de registros; en este caso 380.
  BOT <- data[muestras, ] #Esos números aleatorios serán los índices que tomara de la base de datos para remuestrear.
  marginal_casa_bot <- table(BOT$FTHG) / size.registers
  marginal_fuera_bot <- table(BOT$FTAG) / size.registers
  conjunta_bot <- table(BOT$FTHG, BOT$FTAG) / size.registers
  t_cocientes_bot <- apply(conjunta_bot, 2, function (c) c / marginal_casa_bot)
  t_cocientes_bot <- apply(t_cocientes_bot, 1, function (r) r / marginal_fuera_bot)
  t_cocientes_bot <- data.matrix(t(t_cocientes_bot))
  row = nrow(t_cocientes_bot)
  col = ncol(t_cocientes_bot)
  if( (row == 7)&(col == 6) ){
    Lista_matrices_BOT <- append(Lista_matrices_BOT,list(t_cocientes_bot),k)
    Lista_matrices_BOT <- Lista_matrices_BOT[seq(1,Num.muestras.bot,1)]
  }
  
}

Lista_matrices_BOT #Esta es la lista con el número de muestras indicado por el usuario.


################################################################################################################
##################################### ANÁLISIS DE LA TABLA DE COEFICIENTES #####################################
################################################################################################################


"Para que existe independencia entre las variables los valores de la tabla de cocientes deben ser igual a 1
ya que el teorema de independencia de variables dice que la multiplicación de las probabilidades
marginales de dos variables debe ser igual a la conjunta de las mismas; por lo tanto si dividimos la conjunta
entre la multiplicación de las marginales se espera que haya independencia cuando el resultado sea uno. Este teorema de independencia 
se debe comprobar en cada una de las casillas.
Aquellos caso en los que el cociente es mayor que uno es porque el producto de las marginales es un número menor a la probabilidad
conjunta; mientras que aquellos casos donde el cociente es menor a uno es porque el producto de las marginales es un
número mayor a la probabilidad conjunta"

"En aquellos casos en los que se obtuvo un cociente mayor a uno, pero menor a 1.1, podríamos tomar dicho coeficientes
como uno, y decir que existe independencia de las variables".

"Pero al no cumplirse el teorema en todos los casos podemos concluir que las variables X y Y son estadísticamente dependientes, es
decir sí hay relación entre ellas"

