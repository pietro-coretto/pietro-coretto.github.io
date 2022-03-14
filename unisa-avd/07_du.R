## =============================================================================
## Corso          Analisi e Visualizzazione dei Dati [0212800004] / Parte I
## Cdl/Percorso   Statistica per i Big Data (L41)
## Docente 	      Pietro Coretto (pcoretto@unisa.it)
##
##
##  Argomenti:
##   * distribuzioni
##   * classi e windowing di dati continui
##   * frequenze / counts
##   * distribuzioni di frequenze
##   * rappresentazioni grafiche: stripchart, barplot, piechart
##
## Ultimo aggiornamento: 20-02-2022 at 10:44:43 (CET)
## =============================================================================




## Importiamo il data set
## https://pietro-coretto.github.io/datasets/bw/readme.txt
##  
X <- read.csv(file = url("https://pietro-coretto.github.io/datasets/bw/bw.csv"),
              header = TRUE)

## Numero di campioni
n <- nrow(X)









## Suddivisione in classi / windowing dei dati continui
## ****************************************************


## Quanti sono i livelli distinti di x?
unique( c(1,1,0) )

## quindi
length( unique( X$lfaminc )  )


## Nota il range dei dati è comodamente determinato con
range( X$lfaminc )



## Calcolco dell'ampiezza del range dei dati
h <- max(X$lfaminc) - min(X$lfaminc)



## Premessa: funzine logaritmo e base
## **********************************
log(n)               ## default: logaritimo in base  naturale (base = e)
log(n , base =10)    ## logaritmo in base 10
log10(n)             ## abbreviazione per logaritmo in base 10
log(n , base = 2)    ## logaritmo in base 2
log2(n)              ## abbreviazione per logaritmo in base  2



## Applichiamo la regola di Sturges
K  <-  1 + ceiling( log2(n) )
K

## La regola di Sturges funziona discretamente quando quando n (sample size)
## non è troppo piccolo o tropo grande
##
##  * per n piccolo tende a restituire un  K troppo piccolo
##  * per n troppo tende a restituire un  K troppo grande
##



## Fissiamo arbitrariamenete un K piccolo per avere un esempio pratico
K <- 5



## Ampiezza dell'intervallo
Delta <- h/K



## Otteniamo gli intervalli calcolando l'estremo superiore e l'estremo inferiore
## in due vettori separati
xSup <- rep(0 , K)
xInf <- rep(0 , K)
xmin <- min(X$lfaminc)
for (k in 1:K){
   xInf[k]   <-   xmin + {k-1} * Delta
   xSup[k]   <-   xmin + k * Delta
}

## Vediamoli fianco a fianco in una matrice
Intervalli <- cbind(LimiteInferiore = xInf,    LimiteSuperiore = xSup)
Intervalli





## Funzione cut()! Con essa possiamo trasformare una X
## quantitativa in un "factor" i cui labels sono l'intervallo di appartenenza
y <- c(0,  -1,  2)
cut(y, breaks = 2)


## Ritorniamo a lfaminc
int <- cut(X$lfaminc, K)
str(int)
levels(int)

## Infatti
int







## Frequenze / counts
## ******************
##
## Prima di tutto esploriamo la funzione table()
x <- 1:10
table(x)

x <- c("A", "A", "C", "B", "C")
table(x)


z <- factor(x)
table(z)




## Quanti sono i livelli distinti di faminc?
length(unique(X$faminc))






## Costruiamo una distribuzione di frequenze usando tutti i livelli
## espressi

## Frequenze assolute
table(X$faminc)

## Frequenze relative
table(X$faminc) / n

## Frequenze relative percentuali
table(X$faminc) / n * 100

## converto in data.frame per leggerlo meglio
as.data.frame( round(table(X$faminc) / n * 100, 2) ) 




## Facciamo il windowing prendendo 3 intervalli di livelli uniformi
## Per comodità mettiamo questo dentro un array
CutFaminc <- cut(X$faminc, breaks = 3)
CutFaminc



## Cosa accade se passiamo un fattore dentro table?
u <- factor(c("A", "B", "C", "A", "B"))
table(u)




## cut() restituisce un fattore... quindi proviamo a passarlo nella funzione
## table()
table( CutFaminc )

## Quindi otteniamo frequenze assolute/relative come prima ....
table( CutFaminc )  / n

table( CutFaminc  )  / n * 100


## costruzioni K=3 classi di livelli arbitrarie
CutFaminc2 <- cut(X$faminc, breaks = c(0, 1, 10, 100))
table( CutFaminc2  )  / n * 100


## costruzioni K=6 classi di livelli arbitrarie
CutFaminc2 <- cut(X$faminc, breaks = c(0, 1, 2, 20, 30, 50, 100))
table( CutFaminc2  )  / n * 100







## Stripchart
## **********
stripchart(X$faminc)

stripchart(X$faminc, pch = 21, col = 2, main ="Stripchart di faminc")


## Jittering dei dati
jitter(c(1,1,2,2))
stripchart(jitter(X$faminc), pch = 21, col = 2, main ="Stripchart di faminc")



## Stripchart paralleli
x1 <- c(-2.94, -3.23, 1.87, -1.16, 2.7, -0.02, 2.18, 4.92, -1.2, 2.77)
x2 <- c(3.6, 3.16, 2.75, 2.11, 3.45, 2.98, 2.99, 3.38, 3.33, 3.24)
dat <- data.frame(X1 = x1 , X2 = x2)

stripchart(dat)

stripchart(dat, vertical = TRUE,
           col=c(2,3), pch = c("x", "+")
           )






## Barplot
ni_male <- table(X$male)
barplot(height = ni_male)



## Barplot in termini di frequenze assolute
barplot(height = ni_male,
        names.arg = c("Femmina", "Maschio"),
        col  = c(2,3),
        main = "Sesso del primo figlio",
        ylab = "Freq. assolute")


## Barplot in termini di frequenze percentuali
barplot(height = ni_male / n * 100,
        names.arg = c("Femmina", "Maschio"),
        col = c(2,3),
        main = "Sesso del primo figlio",
        ylab = "Frequenza [%]")






## Piechart
## ********
pie(ni_male)


## Controlliamo i diversi parametri
pie(x = ni_male / n * 100,
    labels = c("Femmina", "Maschio"),
    col = c(2,3),
    main = "Sesso del primo figlio")












## *****************************************************************************
## ESERCIZI:
## ripeti con attenzione la lezione. Explora i seguenti comandi
## ed assicurati di aver compreso pienamente il risultato dell'esecuzione
## *****************************************************************************


## Diff e range
y<- c(1,2,5,3,4,7)

diff(y)

diff(range(y))



## Prova a modificare  i parametri della funzione cut()
y <- c(0,-1,2,4,2,5)

cut(y, breaks = 3 , include.lowest = TRUE , right = FALSE, dig.lab = 1)

cut(y, breaks = c(1,2,3))












