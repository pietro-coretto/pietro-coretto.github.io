## =============================================================================
## Corso         ::  Analisi e Visualizzazione dei Dati [0212800004] / Parte I
## Cdl/Percorso  ::  Statistica per i Big Data (L41)
## Docente       ::  Pietro Coretto (pcoretto@unisa.it)
##
##
##  Argomenti:
##   * funzioni di classe *pply
##   * media, mediana, e moda
##   * decili e percentili
##   * misure condizionate
##   * trasformazione lineari e cambiamenti di unità di misura
##
## Ultimo aggiornamento: 20-02-2022 at 10:51:51 (CET)
## =============================================================================




## Funzione di classe *pply
## ************************
## sono un potente strumento che consente di applicare una determinata funzione
## lungo tutte le dimensioni di un array/data.frame/lista.
A <- array(c(5,20,35,30), dim =c(2,2))
A




## Funzione: apply(input , MARGIN , FUN)
## ******************************************
##  * prende in input un array o data.frame
##  * applica la funzione passata in FUN  a tutti i sotto-array che trova lungo
##    la dimensione indicata da MARGIN.
##  * l'output di apply() sarà un array con una dimensione in meno rispetto
##    all'input


## Applichiamo la somma lungo tutte le righe (MARGIN = 1) di A
apply( A , MARGIN = 1 , FUN = sum)


## Applichiamo la somma  lungo tutte le colonna  (MARGIN = 2) di A
apply( A , MARGIN = 2 , FUN = sum)


## Nota per la somma esiste anche una funzione specifica
colSums(A)
rowSums(A)



## Costruiamo una funzione che calcola il sqrt(massimo di un vettore)
sqmax <- function(x){
   sqrt(max(x))
}

## Proviamo
sqmax(c(1, 4, 49))

## Calcoliamo il sqmax su ogni vettore riga di A
apply( A , MARGIN = 1 , FUN = sqmax)





## La versione base di R contiene diversi data set, prendiamone uno
data(iris)
str(iris)

## Ora inseriamo alcuni NA in iris
iris[1,  1]  <-  NA
iris[2,  2]  <-  NA

## comodo comando per visualizzare la parte iniziale di un data set
head(iris)

## analogamente per la parte finale
tail(iris)

## Adesso costruiamo una funzione che conta il numero di NA in un vettore
conta.na <- function(x){
   sum ( is.na(x) )
}

## Contiamo qunati NA ci sono in ogni riga di IRIS
apply(iris , MARGIN = 1 , FUN = conta.na)

## Applichiamo la somma lungo tutte le righe (MARGIN = 1) di A
apply( iris , MARGIN = 2 , FUN = conta.na)






## Funzione: lapply(lista, FUN)
## ********************************
##  * prende in input una lista
##  * passa FUN su tutti gli elementi della lista
##  * restituisce una lista

x <- list(a=1:10  ,  b=11:20)
x

## sum è applicato a tutti gli elementi della lista
lapply(x, sum)

## prod è applicato a tutti gli elementi della lista
lapply(x, prod)


## sapply(): è un wrapper di lapply, ma a  differenza di lapply() restituisce un
## array
sapply(x, sum)






## Funzione: tapply(X, INDEX, FUN)
## *******************************
##  * prende in input X un oggetto di R il quale puo' essere sottoposto a slicing
##  * uno o più fattori INDEX usati come variabili indicatrici
##  * la funzione passata in FUN viene applicata a tutti gli elmeneti di X
##    separatamente per ogni livello di INDEX

## Per semplicità prendiamo solo le prime 5 osservazioni di IRIS
data(iris)
x <- iris[50:55, ]
x

## Applichiamo  la somma di  Sepal.Length  separatamente per le classi contenute
## in x$Species
tapply( x$Sepal.Length , INDEX = x$Species,   FUN = sum)


## Consideriamo un altro dataset di R
data(mtcars)
str(mtcars)




## Calcoliamo la media del consumo  (mpg)  separatamente per
##  * tipo di canbio (am)
##  * numero di cilindri (cyl)
tapply( mtcars$mpg  ,
        INDEX = list(Cilindri = mtcars$cyl, Cambio = mtcars$am)  ,
        FUN   = mean)



## La funzione by() lavora in modo simile
by( mtcars$mpg  ,  list(Cilindri = mtcars$cyl, Cambio = mtcars$am) ,   mean)







## ==> Slides






## Misure di posizione
## *******************

## Importiamo il data set
## https://pietro-coretto.github.io/datasets/balancesheet/readme.txt
## 
load(url("https://pietro-coretto.github.io/datasets/balancesheet/balancesheet.RData"))
str(dat)

## Lavoriamo con
## sct = costo del personale / ricavi operativi x 100
## Essa misura l'incidenza del costo del lavoro sul fatturato
x <- dat$sct


## Nota: ci sono molti NA
## otteniamo velocemente la distribuzione degli NA
table( is.na(x) )





## Media
## *****

## Calcoliamo la media empirica
mean(x, na.rm = TRUE)


## Nota: prendiamo tutti i valori non NA e calcoliamo la media "a mano"
y <- x[ !is.na(x) ]
sum(y) / length(y)




## Mediana
## ********
median(x, na.rm = TRUE)

## Oppure
quantile(x, probs = 0.5 , na.rm = TRUE)




## Moda
## ****
## consideriamo le classi dell'istogramma calcolato automaticamente da R
h <- hist(x)

## Nota le informazioni che ci servono per sono in
h$density
h$mids

## Troviamo l'indice della classe in corrispondenza della quale abbiamo la massima
## densità
kmoda <- which.max(h$density)
kmoda

## Prendiamo il valore mediano della classe che contiene la moda
moda <- h$mids[kmoda]
moda





## Mettiamo tutto sull'istogramma
## ******************************
h <- hist(x, xlab = "SCT [%]")
## Aggiungiamo lo stripchart dei dati sotto
rug(x)
## Mettiamo una riga verticale rossa per segnare la moda
abline(v = moda, col = 'red')
## Aggiungiamo acnhge media ()
abline(v = mean(x, na.rm= TRUE), col ='blue')
abline(v = median(x, na.rm= TRUE), col ='green')








## ==> Slides






## Serie di quantili
## *****************

## Quartili
## ********
quantile(x, na.rm = TRUE)


## type seleziona il tipo di approssimazione
## default :: type = 6
quantile(x, na.rm = TRUE, type = 1)


## Mettiamo tutto sull'istogramma
## ******************************
h <- hist(x, xlab = "SCT [%]")
## Aggiungiamo lo stripchart dei dati sotto
rug(x)
## Mettiamo una riga verticale rossa per segnare la moda
abline(v = moda, col = 'red')
## Aggiungiamo acnhge media ()
abline(v = mean(x, na.rm= TRUE), col ='blue')
abline(v = median(x, na.rm= TRUE), col ='green')
## E per finire vediamo dove stanno il lowe/upper hinge
abline(v = quantile(x, probs=c(0.25, 0.75), na.rm= TRUE),
       col ='cyan', lty = 3)





## Tukey five-number summary
## *************************
## minimum, lower-hinge, median, upper-hinge, maximum
fivenum(x)

## funzione summary su un vettore
summary(x)

## funzione summary su un 2d-array
summary(iris)



## Decili
alpha <- seq(0, 1, by = 0.1)
alpha
quantile(x, probs = alpha, na.rm=TRUE)



## Percentili
alpha <- seq(0, 1, by = 0.01)
alpha
quantile(x, probs = alpha, na.rm=TRUE)




## Rappresentiamo i percentili in un grafico
## ******************************************
x_alpha <- quantile(x, probs = alpha, na.rm=TRUE)
plot(alpha*100 , x_alpha , t='b',
     main = "Curva percentile per \nSCT = (costo del personale) / (ricavi operativi) x 100",
     xlab = "percentile" ,
     ylab = "SCT [%]")
grid()







## Condizionamento 
## ***************

## Calcoliamo le medie (condizionate) del ROE per regione geografica (NUTS1)
tapply( dat$roe  ,
        INDEX = list(Regione = dat$nuts1)  ,
        FUN   = mean,
        na.rm = TRUE)



## Calcoliamo le mediane (condizionate) di ROE per regione geografica (NUTS1)
tapply( dat$roe  ,
        INDEX = list(Regione = dat$nuts1)  ,
        FUN   = median,
        na.rm = TRUE)



## Calcoliamo le medie (condizionate) di ROE per regione geografica (NUTS1)
## e status
tapply( dat$roe  ,
        INDEX = list(Regione = dat$nuts1, Status = dat$status)  ,
        FUN   = mean,
        na.rm = TRUE)






## ==> Slides






## Trasformazione lineari e cambiamenti di unità di misura
## *******************************************************


## Consideriamo il data set
## https://pietro-coretto.github.io/datasets/icecream/readme.txt
##
A <- read.csv(file = url("https://pietro-coretto.github.io/datasets/icecream/icecream.csv"),
              header = TRUE)
str(A)


## Trasformiamo la temperatura da °F in °C, sappiamo che
## °F = 32 + 9/5 * °C    quindi  °C = 5/9 * {°F - 32}
##
x  <- A$temp            ## Questi sono Fahrenheit
y  <- 5/9 * {x - 32}    ## Questi adesso sono Celsius



## Nota che possiamo scrivere la trasformazione in termini di shift e scaling
## Y =  5/9 * {X - 32}
##    =  -5/9 * 32  + 5/9 * X
##    =  -17.77778  + 0.5555556 * X
##    =       a     + b * X
##
a <- -17.77778    ## shift
b <-   0.5555556  ## scaling



## Vediamo l'effetto sul range
range(x)    ## Variabile originaria in Fahrenheit
range(y)    ## Variabile trasformata in Celsius


## Controlliamo la proprietà riguardante l'ampiezza del range
##
diff( range(x) )      ## ampiezza del range originario in in Fahrenheit
diff( range(y) )      ## ampiezza del nuovo range in Celsius


## Infatti la proprietà dice che (Ymax - Ymin) è dato da
abs(b) * diff( range(x) )






## Effetto sulla media
## ********************
mean(x)   ## media dei dati originario in in Fahrenheit
mean(y)   ## media dei nuovi dati in in Celsius

## Infatti la proprietà dice che mean(y) è data da
a + b * mean(x)




## Effetto sui quantili
## ********************

## Fissiamo un livello
alpha <- 0.25

## Calcoliamo in quantili
quantile(x , probs = alpha)   ## quantile dei dati originario in in Fahrenheit
quantile(y , probs = alpha)   ## quantile dei nuovi dati in in Celsius

## Poichè b>0, la proprietà ci dice che il quantile di y = Celsius è
a + b * quantile(x , probs = alpha)








