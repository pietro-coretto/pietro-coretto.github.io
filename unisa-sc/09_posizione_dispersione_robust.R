## =============================================================================
## Corso:          Statistica computazionale 
## Cdl/Percorso:   Management e Informatica
## Docente:        Pietro Coretto (pcoretto@unisa.it)
##
## Argomenti:
##  + funzione di tipo apply
##  + statistiche di posizione e centralità di una distribuzione
##  + statistiche di dispersione
##  + contaminazione dei dati e metodi robusti
##  + standardizzazione dei dati 
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
apply( A  , MARGIN = 1  , FUN = sum)


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


## Adesso costruiamo una funzione che conta il numero di NA in un vettore
conta.na <- function(x){
   sum ( is.na(x) )
}

## Contiamo qunati NA ci sono in ogni riga di IRIS
apply(iris , MARGIN = 1 , FUN = conta.na)

apply(iris , MARGIN = 1 , FUN = function(x){sum(is.na(x))})





## Funzione: lapply(lista, FUN)
## ********************************
##  * prende in input una lista
##  * passa FUN su tutti gli elementi della lista
##  * restituisce una lista

x <- list(a=1:10  ,  b=11:20)

## sum è applicato a tutti gli elementi della lista
lapply(x, sum)


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


## Calcoliamo la media  di  Sepal.Length  separatamente per le classi contenute
## in x$Species
tapply(x$Sepal.Length , INDEX = x$Species,   FUN = mean, rm.na = TRUE)


## Consideriamo un altro dataset di R
data(mtcars)
str(mtcars)


## Calcoliamo il consumo medio  per
##  * tipo di canbio (am)
##  * numero di cilindri (cyl)
tapply( mtcars$mpg  ,
        INDEX = list(Cilindri = mtcars$cyl, Cambio = mtcars$am)  ,
        FUN   = mean)










## Misure di posizione
## *******************

## Importiamo il data set "balancesheets"
##
load(url("https://pietro-coretto.github.io/datasets/balancesheet/balancesheet.RData"))
str(dat)

## Lavoriamo con
## sct = costo del personale / ricavi operativi x 100
## Essa misura l'incidenza del costo del lavoro sul fatturato
x <- dat$sct


## Nota: ci sono molti NA
## otteniamo velocemente la distribuzione degli NA
table(is.na(x))





## Misure di posizione/centralità
## ******************************

## Calcoliamo la media empirica
mean(x, na.rm = TRUE)

## Nota: prendiamo tutti i valori non NA e calcoliamo la media "a mano"
y <- x[ !is.na(x) ]
sum(y) / length(y)

## Calcoliamo la mediana empirica (ottenuta per inversione della ECDF)
median(x, na.rm = TRUE)

## Oppure
quantile(x, probs = 0.5 , na.rm = TRUE)

## Media troncata al 5% 
mean(x, trim = 0.05, na.rm = TRUE)

## Media troncata al 10% 
mean(x, trim = 0.10, na.rm = TRUE)


## Moda
## ****
## consideriamo le classi dell'istogramma calcolato automaticamente da R
h <- hist(x)

## Nota le informazioni che ci servono per sono in
h$density
h$mids

## Troviamo l'indice della classe in corrispondenza della quale abbiamo la massima
## densità
k_moda <- which.max(h$density)
k_moda
## Prendiamo il valore mediano della classe che contiene la moda
moda <- h$mids[k_moda]
moda




## Mettiamo tutto sull'istogramma
## ******************************
h <- hist(x, xlab = "SCT [%]")
## Aggiungiamo lo stripchart dei dati sotto
rug(x)
## Mettiamo una riga verticale rossa per segnare la moda
abline(v = moda, col = "red")
## Aggiungiamo acnhge media ()
abline(v = mean(x, na.rm = TRUE), col = "blue")
abline(v = median(x, na.rm = TRUE), col = "green")
## E per finire vediamo dove stanno i due quartili
abline(v = quantile(x, probs=c(0.25, 0.75), na.rm= TRUE),
       col ="cyan", lty = 3)
legend("topright", 
       legend = c("Moda", "Mediana", "Media", "Quartili"),
       col = c("red", "green", "blue", "cyan"),
       lty = c(1,1,1,1), lwd = c(2,2,2,2)
)




## Tukey's 5-numbers summary
fivenum(x)

## Osserva: summary() è una funzione generica che implementa la sinstesi numerica
summary(x)

##... Ma se consideriamo due variabili insieme
X <- cbind(ROE = dat$roe, SCT = dat$sct)
summary(X)

##.... e ancora
summary(dat)





## Stima condizionata

## Calcoliamo le medie troncate (condizionate) sullo status
tapply(dat$roe  ,
       INDEX = list(Stato_Giuridico = dat$status)  ,
       FUN   = mean, trim = 0.1,  na.rm = TRUE)


## ripetiamo i calcoli condizionando anche sulla regione geografica dell'impresa
tapply(dat$roe  ,
       INDEX = list(Regione = dat$nuts1, Status_Giuridico = dat$status)  ,
       FUN   = mean, trim = 0.1,  na.rm = TRUE)





## Dispersione e variabilità
## *************************

## Varianza campionaria non distorta
var(x , na.rm = TRUE)

## Esercizio: provare a calcolare la varianza non distorta di x senza usare la 
## funzione var()

## deviazione standard 
sqrt(var( x , na.rm = TRUE))

sd(x, na.rm = TRUE)


## IQR
IQR(x , na.rm = TRUE)

## Ovvero
Q <- quantile(x , probs = c(0.25 , 0.75) , na.rm = TRUE) 
Q[2] - Q[1]

### MAD (median absolute deviation from the median)
# * scarto_i = | x_i - mediana(x) |
# * mad(x) = costante * mediana(scarti)
mad( x , na.rm = TRUE)


    
    

## Standardizzazione  
## *****************

## Prendiamo solo alcune colonne del dataset originario
X <- dat[ , 9:15]

## Proviamo a visualizzare i boxplot paralleli, questi sono utili
## per visualizzare differenza nelle forme (simmetria e curtosi) 
## delle distribuzioni
boxplot(X, horizontal = TRUE)


## Standardizziamo centrando sulla media e scalando per la varianza
X_std_1 <- X
for(k in 1:ncol(X)){
        mean_k <- mean(X[,k] , na.rm = TRUE)
    sd_k   <- sd(X[,k] , na.rm = TRUE)
    X_std_1[,k] <- {X[,k] - mean_k}  /  sd_k
    }

## Infatti ora tutte le variabili hanno media=0 e sd=1
apply(X_std_1 , MARGIN = 2 ,  FUN = mean , na.rm = TRUE) 
apply(X_std_1 , MARGIN = 2 ,  FUN = sd , na.rm = TRUE) 


## La stessa operazione si puo' fare con scale()
X_std_1b <- scale(X)

## Riproviamo a vedere i boxplot
boxplot(X_std_1 , ylim = c(-10, 10), horizontal = TRUE)



## Standardiziamo i dati centrando sulla mediana e scalando 
## con il MAD

## Calcoliamo mediane e mad di tutte le variabili
med_X <- apply(X , MARGIN = 2 ,  FUN = median , na.rm = TRUE) 
mad_X <- apply(X , MARGIN = 2 ,  FUN = mad , na.rm = TRUE) 

## standardizziamo 
X_std_2 <- scale(X ,  center = med_X, scale =  mad_X)

## Riproviamo a visualizzare  i boxplot
boxplot(X_std_2 , ylim = c(-10, 10), horizontal = TRUE)











