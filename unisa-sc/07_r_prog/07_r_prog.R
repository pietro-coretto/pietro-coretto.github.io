## =============================================================================
## Corso:          Statistica computazionale 
## Cdl/Percorso:   Management e Informatica
## Docente:        Pietro Coretto (pcoretto@unisa.it)
##
## Argomenti:
##   + programmazione in R 
##   + strutture di controllo 
##   + funzioni e programmazione funzionale
##   + scripts
##   + stile di programmazione
## =============================================================================






## Strutture di controllo
## **********************
## * Nella programmazione imperativa il programma è una successione di istruzioni
##   (direttive, comandi)
##
## * Le strutture di controllo servono ad organizzare il flusso di esecuzione
##   di un programma
##
## * In R (come in molti altri linguaggi) esistono strutture controllo di tipo
##    - alternative (if, if-else, if-else if-else)
##    - iterazione  (for, while, repeat, break, stop)
##    - terminazione (break, stop, next, return)







## Struttura: if
## *************
##
##  if(condizione){
##    istruzioni
##  }

x <- TRUE
if(x){
    message("X è vero")
}

x <- c(0,100,2)
if( length(x)> 10){
    y <- 2*x
}
y


x <- c(0,100,2)
if( length(x)> 1){
    y <- 2*x
}
y








## Struttura: if else if
## ********************
##
##  if(condizione1){
##    istruzione 1
##  }else{
##    istruzione_2
##  }

x <- FALSE
if(x){
    message("X è vero")
}else{
    message("x è falso")
}



x <- 10
if( x <= 5){
    message("x è minore uguale di 5")
}else{
    message("x è più grande di 5")
}










## Struttura: if - else if - else
## ******************************
##
##  if(condizione 1){
##    istruzioni_1
##  }else if(condizione 2){
##    istruzioni_2
##  }else if(condizione 3){
##    istruzioni_3
##  }else{
##    istruzioni_altro
##  }

x <- 0L
if( is.logical(x) ){
    message("X è un valore logico")
}else if ( is.character(x) ){
    message("x è alfanumerico")
}else if( is.double(x) ){
    message("x è floating point")
}else{
    message("x non è logico, non è alfanumerico, e non è nemmeno floating point...")
}










## Vettorizzazione con ifelse()
## ****************************
x <- c(-10, 0, 11, 1, -3, 5)
u <- ifelse(x < 0,   yes = "Negativo", no = "NonNegativo")
u












## Struttura (iterativa): for
## **************************
##
## for( indice ){
##   operazione(indice)
## }
for ( i  in  c(1,10,20) ) {
    print(i)
}

A <- c("Io", "sono",  "Pietro" , "Coretto")
for(x in A){
    print(x)
}






## Vogliamo calcolare un vettore y dove:
##  * y contiene 10 valori
##  * y[1] = 10
##  * ogni elemento di y è pari al doppio del suo predecessore,  
##    y[i] = 2 * y[i-1]

## IMPORTANTE: inizializziamo il contenitore finale
y    <- rep(10, 10)
## y[1] = 10
##
for (i  in 2:10) {
    y[i] <- 2 * y[i-1]
}
y


rm(y)


## NOTA: la memoria può essere allocata anche durante il ciclo, ma questo causa
## una delle peggiori inefficienze
y <- 10
for (i  in 2:10) {
    y[i] <- 2 * y[i-1]
}
y




## Struttua iterativa: while
## ***************************
##
## while(condizione){
##    operazione
##    }

x <- 0
while (x <= 100) {
    x <- 10 + x
}

### Cosa succede se corro il seguente while() ??
x <- 0
while (x >= 0) {
    x <- 10 + x
}



## Nella maggior parte dei casi è importante assicurarsi che in un tempo finito
## la condizione si trovi in stato  FALSE
iter <- 1L
x    <- 0
while ( x >= 0  &  iter <= 100 ) {
    message("Iterazione:...", iter)
    x    <- 10 + x
    iter <- 1 + iter
}
## Controlliamo i calcoli
x
iter


















## Scripts/programma
## ******************
##
##  * è un file testuale solitamente con estensione .R
##  * puo' contenere qualsiasi oggetto/procedura
##  * una volta eseguito l'interprete di R controlla la correttezza della sintassi,
##    poi le istruzioni vengono eseguite in sequenza
##
## Esempio programma.R
## *******************
##
## * assicuriamoci che il file "programma.R" sia contenuto nella directory di 
##   lavor con dir()
## * apriamo il file "prog.R" da RStudio e leggiamo il codice
## *  prepariamoci all'esecuzione del nostro primo programma


## Pulizia del workspace
rm(list=ls())

## Controllo il workspace
ls()

## Eseguo il programma
source("programma.R")


## Controlliamo il workspace
ls()













## Funzioni e programmazione funzionale
## ************************************
##
## * Sono gli elementi base della programmazione funzionale
##
## * Sono oggetti complessi che prendono in input un certo numero di argomeni
##   e danno in output uno o più oggetti
##
## * La funzione opera in un'area di lavoro diversa dal workspace
##
## * Sintassi
##   nome.funzione  <- function(argomenti){
##       operazioni
##       return(oggetto)
##   }
##
##  Attenzione: per questioni di pulizia si consiglia di usare il punto "." solo
##  nei nomi delle funzioni, e nei nomi degli argomenti di una funzione. Evitare
##  di usare i punti nei nomi di altri oggetti      











## Sviluppiamo una funzione per calcolare un polinomio di secondo grado
## y = a*x^2 + b*x + c
##
## Argomenti: x, a, b, c
## Output   : risultato y
##
polinomio <- function(x , a , b, c) {
    y   <- a * x^2   +  b * x + c
    return(y)
}



## Usiamo la funzione
polinomio(x=10, a=10, b=5, c=1)



## La funzione è un oggetto complesso che adesso è in memoria
polinomio


## Ordine degli argomenti
polinomio(10, 5, 10, 1)
polinomio(b=5, a=10, c=1, x=10)


## Lasciare un argomento della funzione non specificato è causa di errore
polinomio(10, 5, 10)



## Valori di default per alcuni parametri
polinomioB <- function(x , a=1 , b=1, c=1) {
    y   <- a * x^2   +  b * x + c
    return(y)
}

polinomioB(x=10)

polinomioB(x=10 , c=1000)



## Se le operazioni all'interno della funzione lo permettono, la vettorizzazione
## è automatica, ad esempio
polinomioB(x=c(1:10))






## Restituire un output complesso
##
polinomioC <- function(x , a=1 , b=1, c=1) {

    y   <- a * x^2   +  b * x + c
    
    ##
    message("\nIl valore del polinomio nel punto  x=",x, " è y=", y)
    
    ##
    out <- list(valore   = y,
                punto    = x,
                coefficienti = c(a=a, b=b, c=c)
    )
    return(out)
}

boo <- polinomioC(x=10)
boo

















## *****************************************************************************
## ESERCIZI:
## ripeti con attenzione la lezione. Explora i seguenti comandi
## ed assicurati di aver compreso pienamente il risultato dell'esecuzione
## *****************************************************************************

## Cicli for nested (annidati)
##
A <- matrix(1:12, nrow = 3 , ncol=4 )
B <- matrix(121:132, nrow = 4 , ncol=3 )

## Prodotto riga-colonna usando il calcolo matriciale
U <- A %*% B
U

## Calcoliamo il prodotto riga-colonna con un ciclo for annidato
P  <- matrix(0, nrow = nrow(A) ,   ncol = ncol(B) )
for( i in 1:nrow(A)  ) {
    for( j in 1:ncol(B) ) {
        P[i , j] <- sum( A[i , ] * B[, j] )
    }
}
P


## Controlliamo il risultato
P-U
identical(P, U)





## Creamo un vettore numerico
x <- c(0, 1, -2, 3, 1)

## Prova ed interpreta i seguenti comandi
all(x>0)

all(is.double(x))

any(x<0)















#
