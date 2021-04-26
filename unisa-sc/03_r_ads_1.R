## =============================================================================
## Corso:          Statistica computazionale 
## Cdl/Percorso:   Management e Informatica
## Docente:        Pietro Coretto (pcoretto@unisa.it)
##
## Argomenti:
##   + strutture dati e ADS (abstract data structures)
##   + vettori (1D-arrays)
##   + codifica delle variabili non numeriche
##   + 2D-arrays 2 3D-arrays
##   + operazioni su arrays
## =============================================================================






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
##   * array (includono vettori come caso speciale)
##   * matrici
##   * data.frame
##   * liste








## Vettore (array 1D)
## *************************************************
##   * l'array più semplice
##   * puo' contenere un solo tipo
##   * serve un solo indice per identificare un dato

x <- c(10,20,30,40,50,60,70,80,90,100)
y <- c(100,20,30,40,50,60,70,80,90,10)

## subsetting di un vettore
x[1]

x[1:3]

x[-1:-3]

x[c(1,6,10)]



## Subsetting basato su operazioni logiche
idx <- x==30
idx
x[idx]

## oppure direttemante con 
x[x==1]

x[x > 11]

x[x<1]

y <- c("These","are","strings")

y[y=="These"]

y[y=="these"]



## Operazione componentwise su vettori
x <- c(2,  3, -10)
x

x + x

x / x

x^2



## Le operazioni sui vettori (intesi come ADS) non son onecessariamente ben
## be definite nell'ambito dell'algebra lineare
y <-c(1,1,2,2)
y

sqrt(y)

x+y

x * y



## ATTENZIONE: un vettore/array deve contenere un solo tipo
## (restrizione di omogeneità)
x <- c("Foo", 2)
x



## Metadati di un vettore: names
x <- c(X=1, Y=2, Z=3)
x

2*x

names(x)








## Fattori
## *****************************************************************
##    * non è un ADS
##    * è una sovraimposizione di meta-dati ai dati di un vettore/array
##    * sono vettori con meta-dati (anche detti "attributi")
##    * sono particolarmente utili per codificare dati statistici
##      come variabili ordinabili e nominali

risk <- factor(c("high", "medium", "low"))
risk

## Ordering
risk    <- factor(c("H", "H", "L", "M", "H", "M", "L"),
                  levels=c("L", "M", "H"),
                  ordered=TRUE)

risk

## Talvolta per comodità possiamo avere la necessità di trasformare
## l'originale codifica non-numerica in codifica numerica
##
as.numeric(risk)








## Arrays
## *******************************************************************
##    * possono contenere un solo tipo di dati (restrizione di omogeneità)
##    * un array di dimensione K richiede K indici per identificare un
##      dato contenuto in esso
##    * i vettori arrays di dimensione 1
##    * una tabella è un array di dimensione due

## Dimensione 2: tabella
x <- array(1:50, dim=c(10,5))
x
dim(x)


## Subsetting di arrays
x[1 , 1]

x[1, ]

x[ , 2]

x[-1, -3]

x[-1, ]

x[, 2:3]



## Dimensione 3: una sorta di insieme di tabelle 
y <- array(1:24, dim=c(3,3,4))
y
dim(y)

y[3, 3, 3]

y[,,1]

y[1:2, 1:2, 1]


## Operazione componentwise su arrays
y - y

sqrt(y)

log(y)

## ATTENZIONE
y - x







## Symplifying vs preserving subsetting
x[1, ]

y[ , , 1]

x[1, , drop = FALSE]

y[ , , 1 , drop = FALSE]



## Metadati di arrays: vedi dopo





## *****************************************************************************
## ESERCIZI
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











