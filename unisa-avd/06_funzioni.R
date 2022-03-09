## =============================================================================
## Corso        ::  Analisi e Visualizzazione dei Dati [0212800004] / Parte I
## Cdl/Percorso ::  Statistica per i Big Data (L41)
## Docente 	    ::  Pietro Coretto (pcoretto@unisa.it)
##
##
##  Argomenti:
##    * programmazione funzionale
##    * costruzione di una funzione
##    * output complessi
##    * metodi e programmazione ad oggetti
##    * function environment vs global environment
##    * funzioni nascoste, funzioni primitive, esplorare una funzione
##    * introduzione al debugging
##
## Ultimo aggiornamento: 20-02-2022 at 10:43:12 (CET)
## =============================================================================





## Funzioni e programmazione funzionale
## ************************************
##
## * Sono gli elementi base della programmazione funzionale
##
## * Sono oggetti complessi che prendono in input un certo numero di argomeni
##   e danno in output uno o più oggetti
##
## * La funzione opera su un environment separato (vedi dopo).
##   Da questo punto di vista una funzione ha un ruolo diverso da uno script.
##
## * Sintassi
##   nome_funzione  <- function(argomenti){
##       operazioni
##       return(oggetto)
##   }
##
##  Attenzione: per questioni di pulizia si consiglia di usare il punto "." solo
##  nei nomi delle funzioni, e nei nomi degli argomenti di una funzione. Evitare
##  di usare i punti nei nomi delle variabili.







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

print(polinomio)



## Ordine degli argomenti
polinomio(10, 5, 10, 1)

polinomio(x=10, b=5, a=10, c=1)


## Lasciare un argomento della funzione non specificato è causa di errore
polinomio(10, 5, 10)



## Valori di default per alcuni parametri
polinomioB <- function(x , a=1 , b=1, c=1) {
   y   <- a * x^2   +  b * x + c
   return(y)
}

polinomioB(x=10)




## Se le operazioni all'interno della funzione lo permettono, la vettorizzazione
## è automatica, ad esempio
polinomioB(x=c(1:10), a=-5)







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











## Passare argomenti di altre funzioni  con "..." (ellipsis)
##
polinomioD <- function(x , a=1 , b=1, c=1, grafico=TRUE, ...) {

   y   <- a * x^2   +  b * x + c

   if(grafico){
      X <- seq(-10, 10, length = 100)
      Y <- a * X^2   +  b * X + c
      plot(X, Y, t='l', ...)
   }

   return(y)
}

polinomioD(x=1 , grafico = FALSE)


polinomioD(x=1 , grafico = TRUE)


## Passiamo qualche argomento alla funzione plot()
polinomioD(x=1 , main = "f(x) = polinomio", 
           xlab="x", ylab="polinomio", 
           col=2)














## Classe di un oggetto e metodi (OOP: programmazione ad oggetti)
## **************************************************************
##
## * La classe di un oggetto è un sistema di metadati che qualifica un
##   determinato oggetto come appartenete ad una categoria fissata.
##
## * L'attribuzione di classi consente di sviluppare funzioni generiche che
##   hanno un comportamentto specifico quando applicate ad oggetti di una certa
##   classe
##
##  * Esempio: consideriamo una ideale funzione
##
##                              struttura.ossea(x)
##
##   che applicata ai dati relativi ad un essere vivente x, deve dare una
##   descrizione numerica della struttura ossea. Ad esempio deve dare in output
##
##     lunghezza braccio dx  = 60cm
##     lunghezza braccio sx  = 60.68cm
##     etc ...
##
##  se si tratta di un uomo, ma se si trattasse di un cane
##
##     lunghezza zampa posteriore dx  = 36.25cm
##     lunghezza zampa posteriore sx  = 36.38cm
##     etc ...
##
##  Possiamo fare una cosa del genere se ad "x" assegniamo un attributo (metadato)
##  che indichi precisamente di quale essere vivente si tratta. In tal modo una
##  qualsiasi funzione chiamata ad operare su "x" puo' comportarsi di conseguenza




## Prima di tutto consideriamo una delle versioni precedenti
a <- polinomioC(x=1)
a



## A quale classe di oggeti appartiene il risultato di questa funzione?
class(a)




## Costruiamo la nostra solita funzione per calcolare un polinomio, ma questa
## volta assegniamo al risultato un attributo di  "classe" specifico
##
pol <- function(x , a=1 , b=1, c=1) {
   y        <- a * x^2   +  b * x + c

   out <- list(valore   = y,
               punto    = x,
               coefficienti = c(a=a, b=b, c=c)
   )

   class(out) <- "polinomio"
   return(out)
}



## Applichiato la funzione
u <- pol(x=1)
u


## Cosa accade al terminale con il seguente comando?
class(u)


## Creamo un metodo di print specifico per la classe "polinomio"
print.polinomio <- function(x){
   message("Ciao bello!")
           }

print(u)




## Metodi:
## ******
##
##  *  è una procedura di alto livello che produce un risultato specifico che si
##     adegua alla classe dell'oggetto
##
##  *  alcuni metodi fondamentali sono il print, plot, summary, etc...
##     analizziamo il print e programmiamo un seplice metodo di print
##     per la classe "polinomio"

A <- c(1:10)
A
print(A)

x <- 1:10
B <- as.factor(x)
B
print(B)


## Proviamo il nostro risultato di classe = "polinomio"
print(u)



## Implementiamo un semplice "print method" specifico per la classe "polinomio"
##
print.polinomio <- function(foo){
   message("\nIl valore del polinomio nel punto  x=", 
           foo$punto, " e y=", foo$valore)
}


## Ed ora....
z <-  pol(x=1)

z

print(z)

names(z)









## Eplorare le funzioni e funzioni primitive
## *****************************************

kmeans

mean

sum











## Environments
## ************
##
## * È un insieme di oggetti con i loro nomi, i dati ed i metadari in essi
##   contenuti.
##
## * Lo possiamo immaginare come una borsa piena di prodotti: caramelle, salame,
##   pane, etc. La comodità di una borsa è che usando solo due mani possiamo
##   trasportare un insieme di cose molto diverse tra di loro. Se per errore si
##   apre la bottiglia dell'acqua nella borda A questo non rischia di bagnare il
##   pane che porto nella borsa B.
##
## * Quando apriamo una sessione di R iniziamo un environment creato di default
##   chiamato "R_GlobalEnv".
##
## * Lavorare in un environment dedicato permette di tenere separati gli oggetti in
##   memoria, in modo che le operazioni in un environment non interferiscano
##   con oggetti in altri environment.
##
## * Una funzione è una procedura che lavora in un environment suo. Questa è la
##   differenza fondamentale tra una procedura implementata in uno script, ed
##   una procedura implementata a livello di funzione. Tuttavia l'interazione
##   tra il function environment  e l'environment di riferimento può essere letale
##   (vedi esempio dopo)

environment()

search()





## Function environment
## ********************

## Puliamo il workspace
rm(list=ls())

## Creamo una semplicissima funzione
foo <- function(x , y){
      x <- x^2   # qui si sovrascrive il valore in input
      y <- y^2   # qui si sovrascrive il valore in input
      s <- x + y
      return(s)
   }

## Proviamo la funzione
foo(2,2)

ls()


## Fissiamo due variabili in memoria
x <- 1
y <- 1

ls()


## Eseguiamo la funzione
foo(x=2, y=2)


## Controlliamo se questo abbiamo modificato la x e la y che risiedono nel
## global environment
x
y







## ATTENZIONE:
## ***********
## se la funzione risiede nel GlobalEnv, essa utilizzerà tutti gli
## oggetti di GlobalEnv su cui è chiamata ad operare quando questi non sono dati
## in input. Questa regola scooping potrebbe causare bugs letali.

## supponiamo di avere in memoria
z <- 1000000

## supponiamo di aver inserito per errore z nel codice,
foo2 <- function(x , y){
   x <- x^2
   y <- y^2
   s <- x + z  ## !!! errore di programmazione !!!
   return(s)
}


foo2(2,2)









## Prevenzione di errori
## ************************************************************************

## consideriam la funzione 
funA <- function(x) { 
   y <- sum(log(x))
   return(y)
}

x <- c(2,7,9)
funA(x)

## ... ma
x <- c(-2,7,9)
funA(x)




## Tecnica 1: controllo preventivo e conseguente stop 
## (l'esecuzione si ferma allo stop)
funB<- function(x){ 
   if(any(x<=0)) {
      stop("Attenzione! Non posso calcolare il log di numeri <= 0")
   } else {
      y <- sum(log(x))
   }
   return(y)
}

u <- funB(x)

## ovviamente u non esiste in questo caso
u




## Tecnica 2: controllo preventivo, allert e possibilità di produrre un risultato 
## anche se di contenuto non numerico 
funC<- function(x){ 
   if(any(x<=0)){
      y <- NaN
      message("Attenzione! Non posso calcolare il log di numeri <= 0")
   } else {
      y <- sum(log(x))
   }
   return(y)
}

u <- funC(x)

## In questo caso non c'è un breaker, e la funziona calcola un valore non numerico
u












## Debugging: trovare il "call stack" (sequenza a  ritroso fino all'errore)
## ************************************************************************

## consideriamo tre funzioni che interagiscono tutte insiame:
##
f<-function(x) {
   res <- x - g(x)
   return(res)
}

g<-function(y) {
   res <- y * h(y)
   return(res)
}

h<-function(z){

   y <- log(z)

   if(y <10){
      res <- y^2
   }else{
      res <- y^3
   }
   return(y)
}


f(-1)

## RStudio individua il call stack automaticamente, esso è ottenuto da R
traceback()









## Debugging: l'istruzione che ha causato lo stop
## **********************************************
##
## traceback() non dice dove è avvenuto l'errore, ma solo la sequenza che ha portato
## all'errore. Per capire cosa ha cuasato l'errore esistono le funzioni generiche
## debug()/undebug()
##
## * debug(foo): assegna un flag alla funzione foo, questo flag indica all'interprete
##   dei comandi che la funzione va messa sotto osservazione
##
## * undebug(foo): rimuove il flag
##
## * quando il debug flag è attivo sulla funzione foo, essa viene eseguita con uno
##   stop ad ogni esecuzione. Inoltre è possibile bypassare ogni step

debug(f)

## Per iniziare il debugging basta eseguire la funzione, ad ogni step del debug
## possiamo digitare uno dei seguenti comandi (alla console)
##
##  n            = esegue l'istruzione corrente ed indica la prossima
##  c            = esegue il resto delle istruzioni sanza fermarsi
##  Q            = esce dal debug
##  where        = ci dice in quale punto siamo
##  ls()         = ci da la lista degli oggetti nel function environment
##  debug(nome)  = mette in debug una funzione richiamata dalla funzione in
##                 debug. Questo è particolarmente utile se vogliamo trovare
##                 il punto preciso.



## Iniziamo il debugging di f()
f(-1)



## chiudiamo il debug
undebug(f)



## Altre funzioni utili di debugging:
##    * trace()
##    * untrace()
##    * browser()

