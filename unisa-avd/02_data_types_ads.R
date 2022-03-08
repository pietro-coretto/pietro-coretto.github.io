## =============================================================================
## Corso:          Analisi e Visualizzazione dei Dati [0212800004] / Parte I
## Cdl/Percorso:   Statistica per i Big Data (L41)
## Docente:        Pietro Coretto (pcoretto@unisa.it)
##
## Argomenti:
##    * operazioni elementari
##    * funzioni matematiche di base
##    * tipi numerici e tipi speciali
##    * nozione di struttura dati
##    * vettori
##    * array
##    * liste
##
## last update :: 20-02-2022 at 10:36:21 (CET)
## =============================================================================





# Operazioni elementari
5 + 2

5 * 2

5 - 2

5/2

2^2

2^{1/3}





## Semplici funzioni matematiche
## *****************************

sqrt(4)

exp(2)

log(exp(4))

sin(pi)

cos(pi)

round(5/2, digits = 3)





## Memoria ed assegnazione di variabili locali
## *******************************************

a <- 5

5 -> a

5 <- a  ## !! Attenzione

b <- 2

a + b

a * b

a / b

u <- a+b
u

a <- 10

u <- a+b
u


## ATTENZIONE: evitare l'uso di "T, F, c" per assegnare variabili


## Contenuto del workspace/memoria
ls()





## Tipi di dati
## ************

## Floating point
2/3

## Intero
1L

## Alfanumerico
x <-  "XY2_tttt[[[[[++++333"
x

## Logico
x <- TRUE # e FALSE
x


##  Tipi speciali: NA, NaN and  NULL
2 / 0

Inf/3

0 * Inf

Inf - Inf

x <- NULL
x * 2

x <- NA
x * 2

x <- NaN
x * 2





##  Operatori logici
##  ****************

A <- TRUE

B <- FALSE

! A

A & B

A | B

A == B

A != B



## passaggio di variabili logice in operazioni aritmetiche 
A * B

A + B

A - B

A / B


## ottenere il 'tipo' numerico di una variabile
typeof(A)

x <- 1L
typeof(x)


# funzioni test 'is.*' 
is.logical(x)

is.numeric(x)

is.double(x)

is.integer(x)


## coercizione di un tipo 
as.numeric(A)

as.character(A)

as.integer(x)

as.double(A)

as.numeric("8888")








## CONTENITORI / ABSTRACT DATA STRUCTURES (ADS)
## **********************************************************************
## E' un contenitore con regole per
##   * limitare i data types utilizzabili
##   * accedere a uno o più dati
##   * inserimento di dati
##   * eliminazione dei dati
##   * trovare la locazione dei dati
##   * ordinare i dati
##
## In R abbiamo
##   * array   (includono vettori, le tabelle come casi speciali)
##   * matrici (casi particolari di array)
##   * liste
##   * data.frame (caso particolare di liste)





## Vettore = Array-1D
## *************************************************
##   * l'array più semplice
##   * puo' contenere un solo tipo
##   * serve un solo indice per identificare un dato

x <- c(1,-7, 0, 100, 3, 4, 6)

## print di un vettore
x
print(x)  


## print di vettori lunghi
y <- 1:1000
y

## subsetting di un vettore mediante posizione 
x[3]

x[1:3]

x[-1:-3]

x[c(1,6,10)]



## subsetting di un vettore basato su operatori logici 
x == 3

x[x==3]

## è come se stessi operando come segue
idx <- {x == 3}
x[idx]


## altri esempi 
x[x > 11]

x[x<1]

y <- c("These","are","strings")

y[y=="These"]

y[y=="these"]





## Array Computing
## (vedi https://en.wikipedia.org/wiki/Array_programming)
## ----------------------------------------------------------------------
## Il principio di R (e tanti altri linguaggi ad alto livello) è che se una
## funzione/operazione è applicata ad un array X, questa viene applicata a 
## tutti gli elementi di X. Questo principio sta alla base del moderno 
## "implicit parallelization" (oggi esteso a livello di chipset)
## 
## Quando applichiamo una funzione/operazione a tutti gli elmenenti di un
## array, parliamo di operazioni "component-wise". Oppure nel gergo 
## diciamo semplicemente "calcolo vettoriale".
## 
## !!! WARNING !!! 
## In questo corso è considerato ERRORE GRAVISSIMO sostituire  operazioni 
## "vettoriali" con strutture di controllo (eg: for, while, repeat). Ci 
## ritorneremo. 
## 


x <- c(2,  3, 0, 10)
x

sqrt(x)

x + x

2*x

x / x


## I vettori (intesi 1D-array) non sono i vettori dello spazio euclideo R^n!
x <- c(1,1)
y  <-c(2,2, 3,3)

## queste operazioni sono possibili nell'algebra lineare?
x+y

x*y


## Ovviamente il vettore/array soddisfa la restrizione di tipo numerico
x <- c("Foo", 2)
x


## Metadati di un vettore: names
x <- c(X=1, Y=2, Z=3)
x

2*x

names(x)





## Arrays in generale
## *******************************************************************
##    * possono contenere un solo tipo di dati (restrizione di omogeneità)
##    * un array di dimensione K richiede K indici per identificare un
##      dato contenuto in esso
##    * i vettori sono arrays di dimensione 1
##    * una tabella è un array di dimensione 2

## 2D-array: tabella
x <- array(1:50, dim=c(10,5))
x
dim(x)

## 3D-array: insieme di tabelle
y <- array(1:24, dim=c(3,3,4))
y
dim(y)


## Operazione componentwise su arrays
x + sqrt(x)


## ATTENZIONE
y - x


## Subsetting di arrays
x[1,1]

x[1, ]

x[ , 2]

x[, -2]

x[1:2, ]

## cosa estrae il seguente comando?
x[ x[,1]>5 ,  ]

## nel caso di array di dimensione più grande il metodo di subsetting 
## è lo stesso
y[3,3,3]

y[1:2, 1:2, 1]


## Symplifying vs preserving subsetting
x[1, ]

x[1, , drop = FALSE] ## preserving 

y[ , , 1]

y[ , , 1 , drop = FALSE] ## preserving 



## Metadati di arrays
z <- x[1:3 , 1:3]
z

colnames(z) <- c("C1", "C2", "C3")
z

rownames(z) <- c("R1", "R2", "R3")
z

## classe di un oggetto 
class(z)
class(y)



## Matrici (2D arrays)
## *****************************************************************************
##    * sono un tipo speciale di array 2D con atributi che consentono di passare
##      una matrice sotto operazioni definite nell'algebra lineare
##      (det, inversa, prodotto riga-colonna, transposta, etc.)
##    * richiedono due indici per accedere ad un dato (come per i 2D arrays)
x   <- matrix(c(1,2,3,4),  nrow=2,  ncol=2)
x
class(x)


y   <- matrix(c(1,2,3,4), nrow=2)
y

## concatenazione dei vettori in un vettore
x1   <-c(1,2,3)
x2   <-c(10,20,30)
x3   <-c(100,200,300)
data <-c(x1,x2,x3)
X    <-matrix(data, nrow=3, byrow=TRUE)
X

Y    <-matrix(data, nrow=3, byrow=FALSE)
Y

## concatenazione di vettori per formare matrici/array
Z    <- cbind(x1,x2,x3)
Z

Z    <- rbind(x1,x2,x3)
Z



## Subsetting di matrici = subsetting di 2D-array 
X[1,1]

X[ ,1]

X[1, ]



## !!! WARNING !!!
## le "operazioni vettoriali" su matrici non sono definite nell'algebra lineare
X * X

X / X

X - 2*X

X^2





## Algebra lineare
## ---------------
X  <- matrix(1:6,   nrow=2,  ncol=3)
Y  <- matrix(1:12,  nrow=3,  ncol=4)
## capirete il prossimo comando fra qualche lezione 
set.seed(1)
Z  <- matrix(runif(100),   nrow=10)

## prodotto riga-colonna
X %*% Y

Y %*% X

## trasposta
t(X)

## determinante
det(Z)

## inversa
solve(Z)

## diagonale 
diag(Z)

diag(Z) <- 1

## dimensione della matrice
dim(X)

nrow(X)

ncol(X)




## Metadati di matrici e 2D-array
## ------------------------------
colnames(X)  <- c("A", "B", "C")
rownames(X)  <- c("a", "b")
X

colnames(X)
rownames(X)




## Intermezzo: pulizia del workspace
ls()
rm(list=ls())




## LISTE
## *******************************************************************
##    * l'ADS più flessibile in assoluto
##    * ogni elemento può essere un ADS a sua volta
##    * ogni elemento può contenere tipi diversi
##    * utili per strutturare oggetti rappresentati da dati molto complessi



mylist <- list(studente = "Pinco Palla",
               score    = c(18,30,18),
               tab      = array(1:9, dim = c(3,3))
               )

mylist

length(mylist)

names(mylist)

## subsetting 
mylist$studente  ## simplifying

mylist[[1]]      ## simplifying

mylist[1]        ## preserving 




## cosa fa il seguente comando? 
mylist$score

mylist[[2]][-1]


## Metadati di liste
names(mylist) <- c("Nome1", "Nome2", "Nome3")
mylist





## Data-frames
## *****************************************************************************
##    * uno dei motivi per cui R è diventato popolare
##    * è essenzialmente una lista i cui elementi sono vettori tutti della stessa
##      lungheza 
##    * la visualizziamo come una tabella 
##    * la restrizione di tipo è che ogni colonna deve essere di tipo omogeneo
##    * ha un ricco corredo di metadati (attributi)
##    * l'ADS ideal per costruire il tipico data set statistico

mydata      <- data.frame(ID = c("Maria", "Giuseppe", "Franco"),
                          Gender = c("F", "M", "M"),
                          Age= c(25,23,21))

mydata

class(mydata)

## subsetting come per le liste e 2D-array 
mydata$ID      ## simplifying  

mydata[[1]]    ## simplifying

mydata[1]      ## preserving 

mydata[1,1]    ## simplifying

mydata[1, ]    ## preserving


## supponiamo di voler selezionare tutti i maschi
mydata[ mydata$Gender=="M" , ]

## ... ma in realtà esiste un comando potentissimo
subset(mydata, Gender == "M") 

## e se volessimo selezionare tutti i maschi che hanno più di 22 anni?
subset(mydata, Gender == "M" & Age>=22) 

## e se volessimo liberarci della colonna 'ID'
subset(mydata, Gender == "M" & Age>=22, select=c(Gender, Age)) 

##... o meglio 
subset(mydata, Gender == "M" & Age>=22, select=c(-ID)) 

## Metadati di un data.frame
names(mydata)

colnames(mydata)

rownames(mydata)





## Factor
## *****************************************************************************
##    * non è un ADS
##    * è un sistema di meta-dati su un vettore/array
##    * sono particolarmente utili per codificare dati statistici
##      come variabili ordinabili e nominali

u <- c("high", "low", "median")
u

risk <- factor(u)
risk

as.numeric(risk)

## Vogliamo sapere: risk[1] "segue"  risk[2] ? 
risk[1] > risk[2]


## Livelli/labels ordinati 
x <- c("H", "H", "L", "M", "H", "M", "L")
x

risk   <-  factor(x, levels=c("L", "M", "H"), ordered=TRUE)
risk

levels(risk)


## ed ora...
as.numeric(risk)

risk[1] > risk[2]







## *****************************************************************************
## APPROFONDIMENTI
## ripeti con attenzione la lezione. Explora i seguenti comandi
## ed assicurati di aver compreso pienamente il risultato dell'esecuzione.
## *****************************************************************************

## crea il seguente vettore
x <- c(10,20,33,33,33,-10,1)

## lunghezza di un vettore
length(x)

## inverte l'ordine degli elementi di x dall'ultimo al primo
rev(x)


## somma degli elementi di un vettore
sum(x)

## somma dei quadrati
sum(x^2)

## somma cumulativa degli elementi di un vettore
cumsum(x)


## restituisce la posizione degli elementi del vettore che sono >=20
which(x >= 20)

## stesso risultato usando un vettore logico
idx <- { x >= 20 }
which(idx)

## restituisce la posizione dell'elemento massimo e minimo di x
which.max(x)
which.min(x)

## ordina il vettore x
sort(x, decreasing = FALSE)
sort(x, decreasing = TRUE)


## crea il seguente vettore y
y <- c(10, NA, 100, 0, 0, NA)

## restituisce vero se l'elemento di y è NA
is.na(y)

## restituisce gli elementi di y che sono NA
y[ is.na(y) ]

## cosa restituisce il seguente comando?
y[ !is.na(y) ]

## restituisce la posizione degli elementi di y che sono NA
which( is.na(y) )

## cosa restituiscono i seguenti comandi?
sum( is.na(y) )
sum( !is.na(y) )



## Generazione di successioni numeriche
s1 <- 1:10
s1

s2 <- seq(from=1 ,  to=10 , length=5)
s2

s3 <- seq(1 ,  pi , length=5)
s3

s4 <- seq(1 ,  pi , by = 0.05)
s4

s5 <- rep(5 , times = 5)
s5

s6 <- 1:pi
s6



## Troncamenti numerici
u <- c(2.3332 , 2.56577 , 2.725855)

floor(u)

ceiling(u)

round(u, digits = 3)


