## =============================================================================
## Corso        ::  Analisi e Visualizzazione dei Dati [0212800004] / Parte I
## Cdl/Percorso ::  Statistica per i Big Data (L41)
## Docente 	::  Pietro Coretto (pcoretto@unisa.it)
##
##
##  Argomenti:
##    * strutture di controllo (SDC)
##    * SDC: alternative
##    * SDC: iterazione
##    * SDC: terminazione
##    * script
##    * ulteriori approfondimenti sulla rappresentazione numerica
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
if (x) {
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
##  if(condizione){
##    istruzioni
##  }else{
##    istruzioni
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
##    istruzioni
##  }else if(condizione 2){
##    istruzioni
##  }else if(condizione 3){
##    istruzioni
##  }else{
##    istruzioni
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
ifelse(x < 0,   yes = "Negativo", no = "NonNegativo")





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
##  * ogni elemento di y è pari al doppio del suo predecessore,  y[i] = 2 * y[i-1]

## IMPORTANTE: inizializziamo il contenitore finale
y    <- rep(0, 10)
y[1] <- 10
##
for (i  in 2:10) {
   y[i] <- 2 * y[i-1]
}
y


rm(y)




## NOTA: la memoria può essere allocata anche durante il ciclo, ma questo causa
## una delle peggiori inefficienze
y <- 10
##
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
   iter <- iter+1L
}
## Controlliamo i calcoli
x
iter





## Strutture (iterativa):  Repeat
## ******************************
x <- 1
repeat{
   x <- 2 * x
   }
x



## Breaker: break
## ***************
x    <- 1
repeat{
   x <- 2 * x
   if(x > 1000){
      break
   }
}
x



## Breaker:  stop()
## ****************
x    <- 1
repeat{
   x <- 2 * x
   if(x > 1000){
      stop("Troppe iterazioni... io mi arrendo!")
   }
}
x



## Breaker:  next
## **************
x <- 1:10
for (valore in x) {
   if (valore == 5){
      next
   }
   print(valore)
}










## Scripts/programma
## ******************
##
##  * è un file testuale solitamente con estensione .R
##  * puo' contenere qualsiasi oggetto/procedura
##  * una volta eseguito l'interprete di R controlla la correttezza della sintassi,
##    poi le istruzioni vengono eseguite in sequenza
##
## Esempio prog.R
## **************
##
## * assicuriamoci che il file "prog.R" sia contenuto nella directory di lavoro
##   con dir()
## * apriamo il file "prog.R" da RStudio e leggiamo il codice
##
## *  prepariamoci all'esecuzione del nostro primo programma

## Pulizia del workspace
rm(list=ls())


## Controllo il workspace
ls()


## Eseguo il programma
source("prog.R")


## Controlliamo il workspace
ls()










## Ulteriori approfondimenti sulla rappresentazione numerica
## *********************************************************

## esempio
x <- 10^{-30}
a <- 1 + x

## Controlliamo se
a < 1
a > 1
a == 1

## Un controllo di "identità" più accurato può essere eseguito tra oggetti di
## quasiasi complessità con la sequente funzione
identical(a , 1)


## Una lista importante
.Machine



## .Machine$double.eps:
##     è il più piccolo numero floating-point number x tale che   1 + x != 1,
##     nell'esempio di prima x era più piccolo di .Machine$double.eps, ecco
##     spiegato il fenomeno
##
##  .Machine$double.xmin:
##      il più piccolo floating-point maggiore di zero
##
##  .Machine$double.xmax:
##      il più grande  floating-point

.Machine$double.xmin  # [0, .Machine$double.xmin] trattato come se fosse zero

10^{-330}

10^{-330} == 0


.Machine$double.xmax ## che tutti i valorri > .Machine$double.xmax sono trattati come Inf

10^{330}


## Vediamo i primi 300 decimali di un numero
sprintf("%.300f", pi)

sprintf("%.300f", 1)





## Esempio da ricordarsi per sempre!
## *********************************
## Calcoliamo {0.1 + 0.3} e poi sottraiamo questo numero da 0.4
## il risultato dell'operazione esatto è 0
a <- 0.4 - {0.1 + 0.3}
a

## Controlliamo meglio
a == 0

sprintf("%.300f", a)


## Ora sottraggo prima 0.1 da 0.4, ed infine dal risultato ottenuto sottraggo ancora
## 0.3. Il risultato esatto è sempre 0
b <- 0.4 - 0.1 - 0.3
b

## Controllo meglio
b == 0


## Infatti... osserva cosa accade alla magica 16-esima cifra decimale!
sprintf("%.16f", b)


## Ma il "rumore di troncamento" è ancora peggio
sprintf("%.300f", b)


## Tuttavia dal punto di vista "informatico" questi due numeri sono uguali rispetto
## alla tolleranza prevista dal .Machine$double.eps
abs(a - b)


## Se la differenza in valore assoluto tra due numeri è <= di .Machine$double.eps
## dal punto di vista dell'approssimazione floating point potrebbero essere
## esattamente lo stesso numero
abs(a - b) <= .Machine$double.eps




## ATTENZIONE:
## -----------
##   * il rumore di troncamento è cumulativo, si propaga ed aumenta quando vi sono
##     molti calcoli annidati
##   * il rumore di troncamento aumenta moltissimo quando faccio operazioni tra
##     numeri di scala molto diversa ad esempio  calcolo
##     0.000025 * 50012500
##   * il rumore di trocamento spesso si somma all'errore di approssimazione
##     numerica. Ad esempio log(x) è calcolato sulla base di approssimazioni
##     analitiche.













## *****************************************************************************
## APPROFONDIMENTI:
## ripeti con attenzione la lezione. Explora i seguenti comandi
## ed assicurati di aver compreso pienamente il risultato dell'esecuzione
## *****************************************************************************


## Creamo un vettore numerico
x <- c(0, 1, -2, 3, 1)

## Prova ed interpreta i seguenti comandi
all(x>0)

all(is.double(x))

any(x<0)







## Creamo tre variabili
x <- 10
y <- 12
z <- c(-1,-1)

## Prova ed interpreta i seguenti comandi
stopifnot(x < 100)

stopifnot(x < 5)

stopifnot(x < 100 , y > 10,  all(z<0))

stopifnot(x < 100 , y > 10,  all(z>0))



















#
