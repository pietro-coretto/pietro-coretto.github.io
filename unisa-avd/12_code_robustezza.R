## =============================================================================
## Corso         ::  Analisi e Visualizzazione dei Dati [0212800004] / Parte I
## Cdl/Percorso  ::  Statistica per i Big Data (L41)
## Docente       ::  Pietro Coretto (pcoretto@unisa.it)
##
##
##  Argomenti:
##   * impatto dellle code sulle rappresentazioni grafiche
##   * code normali  e "Normal QQ-plot"
##   * confronto di distribuzioni mediante QQ-plot
##   * procedure robuste per parametri di posizione/scala
##   * Identificazione di outliers
## =============================================================================





## Consideriamo il data set
## https://pietro-coretto.github.io/datasets/card/readme.txt
## 
load(url("https://pietro-coretto.github.io/datasets/card/card.RData"))
str(card_dataset)



## Consideriamo la variabile $wage
x <- card_dataset$wage
n <- length(x)
n

## Istrogramma
hist(x)
rug(x)


## Ecdf
plot(ecdf(x))


## Controlliamo con la normale
qqnorm(x)
qqline(x, col = 2)


## Trasformiamo i dati in log(wage), la trasformata logartimica comprime le code
## di una distribuzione
logx <- log(x)


## Istrogramma
hist(logx)
rug(logx)


## Ecdf
plot(ecdf(logx))


## Controlliamo con la normale
qqnorm(logx, main="log(wage)")
qqline(logx, col = 2)


## In conclusione i salari hanno una distribuzione che si comporta molto
## diversamente dalla normale, ma se guardiamo i log(salari) questi hanno una
## distribuzione che somiglia molto alla normale. La trasformata logartimica
## produce l'effetto di comprimere le code



## Controntiamo adesso la distribuzione dei salari degli Afroamericani contro
## il resto della popolazione
x_afro     <- x[card_dataset$black == 1]
x_not_afro <- x[card_dataset$black == 0]
qqplot(x_afro, x_not_afro, main="",
       xlab = "Salari Afroamericani",
       ylab = "Salari non Afroamericani")
abline(a=1, b=1, col=2)




## Controntiamo adesso la distribuzione dei salari degli Afroamericani contro
## il resto della popolazione
log_x_afro     <- log(x_afro)
log_x_not_afro <- log(x_not_afro)
qqplot(log_x_afro, log_x_not_afro, main="",
       xlab = "log(Salari) Afroamericani",
       ylab = "log(Salari) non Afroamericani")
abline(a=1, b=1, col=2)












## --> Slides











## Metodi  robusti per misure di posizione/dispersione
## ***************************************************

## Data set
## https://pietro-coretto.github.io/datasets/icecream/readme.txt
## 
Y <- read.csv(url("https://pietro-coretto.github.io/datasets/icecream/icecream.csv"),
              header = TRUE)

## consideriamo la variabile $price  nel data set precedente
y <- Y$price

## Istrogramma
hist(y)

## Peso delle Code
qqnorm(y, main="Prezzo")
qqline(y, col = 2)


## Calcoliamo posizione dispersione
A0 <- c(Media    =  mean(y),
        Med      =  median(y),
        Varianza =  var(y),
        DevStd   =  sd(y),
        IQR      =  IQR(y)
)
A0


## Ora supponiamo che al posto di del primo y[1]=0.270$ sia stato trascritto
## y=2.70,  ed al posto y[2]=0.282 sia stato trascritto 282
yy <- y
yy[1]  <- 2.70
yy[2]  <- 282

## Disastro...
hist(yy)

qqnorm(yy, main="Anni di istruzione")
qqline(yy, col = 2)

## Ricalcoliamo posizione dispersione
A1 <- c(Media    =  mean(yy),
        Med      =  median(yy),
        Varianza =  var(yy),
        DevStd   =  sd(yy),
        IQR      =  IQR(yy)
)

## Confrontiamo
A0
A1


## Calcoliamo Trimean, medie troncate, MAD
Q <-  quantile(yy, probs = c(0.25 , 0.5 , 0.75))
Q
TMyy <- 1/2 * Q[2]  + 1/4 * Q[1]  +1/4 * Q[3]
TMyy

## ricalcolo il trimean sui dati non contaminati
Q <-  quantile(y, probs = c(0.25 , 0.5 , 0.75))
TMy <- 1/2 * Q[2]  + 1/4 * Q[1]  +1/4 * Q[3]
TMy




## Calcoliamo la media troncata con diverse percentuali di troncamento

## dati non contaminati
mean(y)
mean(y , trim = 0.01)   ## alfa = trim  =  1%
mean(y , trim = 0.02)   ## alfa = trim  =  2%
mean(y , trim = 0.05)   ## alfa = trim  =  5%
mean(y , trim = 0.1)    ## alfa = trim  = 10%
mean(y , trim = 0.25)   ## alfa = trim  = 25%

## dati  contaminati
mean(yy)
mean(yy , trim = 0.01)   ## alfa = trim  =  1%
mean(yy , trim = 0.02)   ## alfa = trim  =  2%
mean(yy , trim = 0.05)   ## alfa = trim  =  5%
mean(yy , trim = 0.1)    ## alfa = trim  = 10%
mean(yy , trim = 0.25)   ## alfa = trim  = 25%




## Calcoliamo la dispersione 
disp_y  <- c(sd = sd(y),  iqr = IQR(y),  mad = mad(y))
disp_yy <- c(sd = sd(yy), iqr = IQR(yy), mad = mad(yy))
rbind(disp_y, disp_yy)




## Standardizziamo i dati non contaminati
zy <- scale(y , center = mean(y), scale = sd(y))
hist(zy)

## Standardizziamo i dati contaminati
zyy <- scale(yy , center = mean(yy), scale = sd(yy))
hist(zyy)

## Standardizziamo usando l'equivalente robusto
rob_zyy <- scale(yy , center = mean(yy , 0.2), scale = mad(yy))
hist(rob_zyy)






## --> Slides







## Identificazione degli outliers usando i Tukey fences
## ****************************************************

## Calcoliamo i quartili sulla distribuzione contaminata
Q <- quantile(yy, probs = c(0.25, 0.5, 0.75))


## Identifichiamo i sospetti outliers con k=1.5
k    <- 1.5
Hinf <- Q[1] - k * { Q[3] - Q[1]}
Hsup <- Q[3] + k * { Q[3] - Q[1]}

## Posizioni dei sospettati outliers 
idx_out <- { yy < Hinf |  yy > Hsup }
which(idx_out)

## Chi sono?
yy[ which(idx_out) ]



## Identifichiamo i sospetti gross-outliers con k=3
k    <- 3
Hinf <- Q[1] - k * { Q[3] - Q[1]}
Hsup <- Q[3] + k * { Q[3] - Q[1]}

## Posizioni degli outliers
idx_gross_out <- { yy < Hinf |  yy > Hsup }
which(idx_gross_out)

## Chi sono?
yy[ which(idx_gross_out) ]






## Standardizziamo usando l'equivalente robusto
yy_clean <- yy[-which(idx_gross_out)]
hist(yy_clean)


## distribuzione dei dati precedentemente standardizzati senza gli 
## outliers 
hist(rob_zyy[-which(idx_gross_out)])




