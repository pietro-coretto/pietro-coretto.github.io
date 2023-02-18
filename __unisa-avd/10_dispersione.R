## =============================================================================
## Corso         ::  Analisi e Visualizzazione dei Dati [0212800004] / Parte I
## Cdl/Percorso  ::	 Statistica per i Big Data (L41)
## Docente       ::  Pietro Coretto (pcoretto@unisa.it)
##
##
##  Argomenti:
##   * ottimizzazione numerica
##   * devizioni totali rispetto ad un punto
##   * mediana come minimizzazione delle deviazioni totali assolute
##   * varianza e deviazione standard
##   * IQR ed ampiezza del range
##   * standardizzazione dei dati
##   * strategie per standardizzare una matrice dati
##   * uso dei valori standardizzati per fare confronti grafici
## =============================================================================





## Ottimizzaizone numerica
## ***********************
##
## * vogliamo minimiazzare la funzione f(x) rispetto senza calcolare le derivate
##   di f
## * esistono metodi numerici che consentono di risolvere questo problema
##   numericamente senza il calcolo analitico delle derivate
## * nlm(), nls(), optim() sono funzioni abbastanza generali da consentire
##   la soluzione di problemi di ottimizzazione numerica
## * nlm() è  la funzione più generale




## Funzione da minimizzare
## y = a x^2 + b
## par <- c(a, b)
## ***********************
objfun <- function(x , par){
    y <- par[1] * x^2 + par[2]
    return(y)
}



## y = 2x^2 + 6
x <- seq(-10, 10, length = 1000)
y <- objfun(x, par=c(2,6))
plot(x , y , t='l')



## uso di nlm: nonlinear minimization 
## cerchiamo il minimo di y = 2x^2 + 6
nlm(f    = objfun,     ## funzione da minimizzare
    p    = 10,          ## Punto iniziale per x
    par  = c(2,6)      ## Passiamo gli tutti altri argomenti tranni x
)







## --> Slides






## Importiamo il data set 
## https://pietro-coretto.github.io/datasets/balancesheet/readme.txt
## 
load(url("https://pietro-coretto.github.io/datasets/balancesheet/balancesheet.RData"))
str(dat)


## Consideriamo la variabile dat$solr, per comodità eliminiamo gli NA e i NaN
## nota is.finite(x) resituisce TRUE nel caso in cui x non è {NA, NaN, Inf}
x <- dat$solr[ is.finite(dat$solr) ]
n <- length(x)


## Deviazione totale quadratica da un punto di riferimento
ref <- 0
dtq  <- sum ( { x - ref }^2 )
dtq


## Deviazione totale assoluta da un punto di riferimento
ref <- 0
dta  <- sum ( abs( x - ref ) )
dta




## Costruiamo una funzione
DevTot <- function(dati , ref , tipo = "quadratica", bad.rm = TRUE){

   ## Filtriamo eventuali NA e NaN
   if(bad.rm==TRUE){
      dati <- dati[is.finite(dati)]
      }

   ## Calcoliamo la deviazione totale
   if(tipo=="quadratica"){
      y <- sum ( { dati - ref }^2 )
   }else if(tipo=="assoluta"){
      y <- sum ( abs(dati - ref ) )
   }

   return(y)
}





## Proviamo
dtq
DevTot(dati = dat$solr, ref = 0, tipo = "quadratica")

dta
DevTot(dati = dat$solr, ref = 0, tipo = "assoluta")







## Centralità della media e della mediana
## **************************************

## Consideriamo una griglia di valori candidati ad essere il centro della
## distribuzione
u <- seq(min(x), max(x), length = 100)

## Caloliamo le deviazioni totali assolute e quadratiche per ogni valore di u
DTA <- rep(0, length(u))
DTQ <- rep(0, length(u))
for( i in 1:length(u) ){
   ## Deviazione totale assoluta
   DTA[i] <- DevTot(dati =x, ref = u[i], tipo = "assoluta")

   ## Deviazione totale quadratica
   DTQ[i] <- DevTot(dati = x, ref = u[i], tipo = "quadratica")
}






## Deviazioni totali quadratiche e media
## *************************************
## Dividiamo la finestra grafica in due righe
par(mfrow=c(2,1))
##
## PLOT superiore:
## ***************
## Grafico delle deviazioni totali quadratiche in funzione di u
plot(u, DTQ, t='l', lwd = 2,
     xlab = "Punto di Riferimento",
     ylab = "Deviazione Totale Quadratica")
## Aggiungiamo una linea verticale in corrispondenza della media
abline(v=mean(x), col=2, lty=4)
##
## PLOT  inferiore
hist(x)
## Mettiamo lo stripchart sotto l'istogramma
rug(x)
## Aggiungiamo una linea verticale in corrispondenza della media
abline(v = mean(x),  col =2 ,  lty = 4)







## Deviazioni totali assolute e mediana
## *************************************
## Dividiamo la finestra grafica in due righe
par(mfrow=c(2,1))
##
## PLOT superiore:
## ***************
## Grafico delle deviazioni totali quadratiche in funzione di u
plot(u, DTA, t='l', lwd = 2,
     xlab = "Punto di Riferimento",
     ylab = "Deviazione Totale Assoluta")
## Aggiungiamo una linea verticale in corrispondenza della mediana
abline(v=median(x), col=2, lty=4)
##
## PLOT  inferiore
hist(x)
## Mettiamo lo stripchart sotto l'istogramma
rug(x)
## Aggiungiamo una linea verticale in corrispondenza della media
abline(v = median(x),  col =2 ,  lty = 4)








## Calcolo della mediana come minimo delle Deviazioni Totali Assolute
## ******************************************************************
##
nlm(p    = 0 ,           ## Punto iniziale per ref
    f    = DevTot,       ## funzione da minimizzare
    dati = x,            ## Passiamo gli tutti altri di DevTot tranne ref
    tipo = "assoluta"    ## e che non hanno un default
    )

## confrontiamo $estimate  con la mediana dei dati
median(x)








## --> Slides












## Variabilità
## ***********

## Varianza empirica
sum( {x - mean(x)}^2 )  / length(x)


## Varianza non distora
sum( {x - mean(x)}^2 )  / {length(x)-1}


## Cosa calcola R di default?
var(x)

## Deviazione standard (basata sulla varianza non distorta)
sd(x)

## Infatti
sqrt(var(x))


## IQR
IQR(x)


## Oppure
Q <- quantile(x, probs=c(0.25, 0.75))
Q[2] - Q[1]


## Ampiezza del range
diff(range(x))


## Oppure
max(x) - min(x)







## --> Slides





## Standardizziamo dat$roa
m_roa  <- mean(dat$roa, na.rm=TRUE)
s_roa  <-  sd(dat$roa, na.rm=TRUE)
z_roa  <- { dat$roa - m_roa } / s_roa


## Controlliamo la media e la varianza dei dati standardizzati
mean(z_roa, na.rm=TRUE)
var(z_roa, na.rm=TRUE)



## La standardizzazione ha cambiato altri aspetti della distribuzione ?
par(mfrow = c(2,1))
hist(dat$roa)
hist(z_roa)


## ed infatti anche per la ECDF
par(mfrow = c(2,1))
plot( ecdf(dat$roa) )
plot( ecdf(z_roa) )







## E se volessi standardizzare tutte le variabili nel data set?
## https://pietro-coretto.github.io/datasets/icecream/readme.txt
A <- read.csv(file = url("https://pietro-coretto.github.io/datasets/icecream/icecream.csv"),
              header = TRUE)


## Standardizziamo il data set con scale
z_A <- scale(A)
z_A
















## Utilizzo dei valori standardizzati per effettuare confronti grafici
## *******************************************************************

## Ritorniamo al data set "icecream". Ecco contiene dati in serie storica.
## I dati sono stati rilevati rilevati a frequenza settimanale, qundi le unità
## 1,2,...n sono le settimane.


## Supponiamo di voler  visualizzare l'evoluzione  del prezzo
settimana <- 1:nrow(A)
plot(settimana , A$price, t='l', xlab = "Settimana", ylab = "Prezzo")


## Ora supponiamo di voler vedere sullo stesso grafico l'evoluzione dinamica
## di prezzo e consumo.
plot(settimana, A$price, t='l', xlab = "Settimana", ylab = "Prezzo/Consumo", col=2)
lines(settimana, A$cons, col = 3)
legend("topright", legend = c("Prezzo", "Consumo"), col=c(2,3), lty=c(1,1))


## Infatti il problema è che
range(A$price)
range(A$cons)


## E se proviamo ad allargare i limiti dell'asse delle Y?
## ... Pessima idea, perché una sola scala per le Y con variabili coì diversi
## finirà per creare il seguente disastro:
plot(settimana, A$price, t='l', xlab = "Settimana", ylab = "Prezzo/Consumo", col=2 ,
     ylim = range(A$cons))
lines(settimana,A$cons, col = 3)
legend("topright", legend = c("Prezzo", "Consumo"), col=c(2,3), lty=c(1,1))


## trasformo l'oggetto scale in data.frame
z_A <- as.data.frame(z_A)


## Cosa succede se plottiamo le variabili standardizzate?
##
plot(settimana,  z_A$price, t='b', pch =20,
     xlab = "Settimana",
     ylab = "Valori standardizzati", col=2 ,
     main = "Prezzo e Consumo a Valori Standardizzati",
     ylim = range(z_A$cons))
lines(settimana, z_A$cons, col = 4, t="b", pch = 17)
legend("topright", legend = c("Prezzo", "Consumo"), col=c(2,4), lty=c(1,1))


## Soluzione ancora più elegante sarebbe
##
## * avere due assi delle Y, uno di colore rosso, l'altro blu
## * su questi assi rappresentiamo il valore standardizzato Z_i
## * ma sulla scala numerica sostituiamo (solo visuale) la Z_i con il corrispondente
##   X_i
##
## Vedi esercizi ed approfondimenti sotto
















## *****************************************************************************
## APPENDICE:
## ripeti con attenzione la lezione. Explora tutti i comandi cercando  di
## apportare piccole variazioni ed  analizzando il risultato
## *****************************************************************************



## Calcoliamo le medie e deviazioni standard per tutte le colonne dalla 26 alle 35
Medie_2536 <-  apply(dat[ , 25:35] , MARGIN = 2  , FUN=mean , na.rm=TRUE)
Medie_2536

Sd_2536 <-  apply(dat[ , 25:35] , MARGIN = 2  , FUN=sd , na.rm=TRUE)
Sd_2536

## Reppresentiamole graficamente le medie per variabile
##
barplot(Medie_2536 ,
        ylab = "Media" ,
        xlab = "Variabile")





## Mettiamo su uno stesso plot medie e sd. Cosa noti?
##
par(mfrow = c(2,1))
barplot(Medie_2536 ,
        ylab = "Media" ,
        xlab = "Variabile")
barplot(Sd_2536 ,
        ylab = "Deviazione Standard" ,
        xlab = "Variabile")







## Calcoliamo le mediane e IQR (condizionate) di ROE per regione geografica (NUTS1)
## ********************************************************************************
## Mediana
tapply( dat$roe  ,
        INDEX = list(Regione = dat$nuts1)  ,
        FUN   = median ,
        na.rm = TRUE)
## IQR
tapply( dat$roe  ,
        INDEX = list(Regione = dat$nuts1)  ,
        FUN   = IQR ,
        na.rm = TRUE)

## Cosa noti?








## Standardizzazione di un data set: ppzione 2
## *******************************************
## scale() non funziona quando vi sono colonne non-numeric, come ad esempio
## in dat.  Infatti
scale(dat)

## In questi casi l'opzione più semplice scriver un for() e standardizzare tutte
## le colonne numeric
z_dat <- dat
for(j in 1:ncol(dat)){
   if( is.numeric(dat[ , j])  ){
      dat[, j]  <- {  dat[,j] - mean(dat[,j], na.rm = TRUE) } / sd(dat[,j] , na.rm=TRUE)
   }
}

## diamo uno sguardo alle prime righe di z_dat
head(z_dat)







## Visualizzazione della scala originaria su un grafico costruito
## con valori standardizzati
##
##
## Facciamo un plot   con i valori standardizzati ma senza assi
plot(settimana,  z_A$cons, t='b',  pch = 17, col=4, axes = FALSE,
     xlab = "Settimana", ylab = "")
lines(settimana, z_A$price, t='b', pch = 20, col=2)
##
## Costruiamo l'asse delle x
set_vals <- seq(min(settimana) , max(settimana), by = 4)
axis(1, at =  set_vals, labels = set_vals)
##
## Costruiamo l'asse delle Y per i prezzi
price_vals <- seq(min(z_A$price) , max(z_A$price), length.out = 5)
price_labs <- seq(min(A$price) , max(A$price), length.out = 5)
axis(2 , at = price_vals, labels = round(price_labs,2) , col =2)
##
## Costruiamo l'asse delle Y per il  consumo
cons_vals <- seq(min(z_A$cons) , max(z_A$cons), length.out = 5)
cons_labs <- seq(min(A$cons) , max(A$cons), length.out = 5)
axis(4 , at = cons_vals, labels = round(cons_labs,2) , col =4)
## Legend
legend(1, 3, legend = c("Prezzo", "Consumo"), col=c(2,4), lty=c(1,1))




















