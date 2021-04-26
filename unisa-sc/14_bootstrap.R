## =============================================================================
## Corso:          Statistica computazionale 
## Cdl/Percorso:   Management e Informatica
## Docente:        Pietro Coretto (pcoretto@unisa.it)
##
## Argomenti:
##  + metodi  di  ricampionamento
##  + bootstrap  non  parametrico
##  + stima bootstrap del bias/standard error
##  + intervalli di confidenza bootstrap 
## =============================================================================




## Ricampionamento
##  + si intende  il riutilizzo dei dati osservati
##  + si basa sul principio che l'ECDF dei dati mima abbastanza bene la
##    distribuzione sottostante per n sufficientemente grande


## Prima di proviamo a verificare empiricamente la legge di Glivenko-Cantelli
set.seed(1234)
n <- 25
x <- sort(rchisq(n, df=5))
Fvera <- pchisq(x, df=5)
plot(ecdf(x))
lines(x, Fvera , t = "l", col = 2)

## aumentiamo n
n <- 100
x <- sort(rchisq(n, df=5))
Fvera <- pchisq(x, df=5)
plot(ecdf(x))
lines(x, Fvera , t = "l", col = 2)


## aumentiamo n
n <- 1000
x <- sort(rchisq(n, df=5))
Fvera <- pchisq(x, df=5)
plot(ecdf(x))
lines(x, Fvera , t = "l", col = 2)



## Dati:  http://www.decg.it/pcoretto/datasets/nls80_README.txt
load(url("http://www.decg.it/pcoretto/datasets/nls80.RData"))
attach(NLS80)


## Supponiamo di voler prendere un (ri)campione iid di dimensione m=10 dalla ECDF(iq)
m <- 10
x <- sample(iq, size = m , replace = TRUE)

plot(ecdf(iq))
lines(ecdf(x), col = 2)


## ma prendendo m=n
m <- length(iq)
x <- sample(iq, size = m , replace = TRUE)

plot(ecdf(iq))
lines(ecdf(x), col = 2)








## Usiamo il boostrap non parametrico per calcolare il bias e lo standard error
## per la media campionaria di iq
n       <- length(iq)
B       <- 5000
mun     <- mean(iq)   ## media campionaria 
mustar  <- rep(0, B)
for (b in 1:B){
    xstar     <- sample(iq, size = n , replace = TRUE)
    mustar[b] <- mean(xstar)
}

## Visualizziamo la distribuzione boostrap della media campionaria
hist(mustar)

## In questo caso (dal primo corso di statistica) sappiamo che la distribuzione
## della media campionaria è normale, infatti
qqnorm(mustar)
qqline(mustar, col = 2)

## Stima del bias
mean(mustar - mun)

## Varianza della media campionaria
var(mustar)

## Standard error
sd(mustar)








## Usiamo il package "boot"
library(boot)

## Prima di tutto dobbiamo costruire una funzione che calcola la statistica di
## interesse da passare alla funzione boot(). Questa deve calcolare la statistica
## di interesse su un singolo ricampione bootstrap. Deve avere due input:
##  * i dati osservati
##  * gli indici delle osservazioni che entrano nel b-esimo campione bootstrap

## Esempio 
data <- c(1,10,11,23,15)
n    <- length(data)

## Invece di ricampionare le osservazioni direttamente, immaginiamo di prendere gli
## indici delle osservazioni ricampionate
set.seed(123)
i  <- sample(1:length(data) , size = n , replace = TRUE)
i

## Il ricampione sarebbe
data[i]

## Ora per calcolare la media del ricampione
mean(data[i])

## Costruiamo una funzione
boot_mean <- function(data , i){
    mean(data[i] , na.rm = TRUE)
}
boot_mean(data, i)


## Calcoliamo la distribuzione boostrap usando boot
u1 <- boot(iq, statistic = boot_mean, R = 1000, stype="i")
u1

## Distribuzione bootstrap della statistica
plot(u1)

## Oggetti in u
names(u1)







## Calcoliamo il bias e lo standard error delle mediana
boot_med<- function(data , i){
    median(data[i], na.rm = TRUE)
}

u2 <- boot(iq, statistic = boot_med, R = 1000, stype="i")
u2

## ci sappiamo spiegare questi grafici?
plot(u2)







## Calcoliamo il bias e lo standard error delle media troncata al 20%
boot_truncmean <- function(data , i){
    mean(data[i] , trim = 0.2 , na.rm = TRUE)
}

u3 <- boot(iq, statistic = boot_truncmean, R = 1000, stype="i")
u3



## Intervallo di confidenza bootstrap sulla media 
boot.ci(u1)


## Intervallo di confidenza bootstrap sulla mediana
boot.ci(u2)


## Intervallo di confidenza bootstrap sulla media troncata
boot.ci(u3)


