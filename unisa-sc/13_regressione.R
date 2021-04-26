## =============================================================================
## Corso:          Statistica computazionale 
## Cdl/Percorso:   Management e Informatica
## Docente:        Pietro Coretto (pcoretto@unisa.it)
##
## Argomenti:
##  + modello di regressione lineare multiplo
##  + stima ols
##  + tests sui coefficienti
##  + diagnostica grafica e numerica sul modello di regressione
##  + previsione
##  + modello logit (stima, inferenza e previsione)
## =============================================================================


## Dataset:  http://www.decg.it/pcoretto/datasets/nls80_README.txt
load(url("http://www.decg.it/pcoretto/datasets/nls80.RData"))
attach(NLS80)


## Vogliamo stimare il modello
## wage = cost + beta1 * age + beta2 * iq + beta3 * educ + beta4 * exper + errore
m1 <- lm(wage ~ 1 + age + iq + educ + exper)
m1

## Vediamo cosa restituisce la funzione lm()
typeof(m1)
class(m1)
names(m1)

## Sime OLS
m1$coefficients


## Inferenza sul modello
## ! Attenzione !
## standard error e pvalue sono derivati sotto l'ipotesi di errori omoschedastici 
## 
inf_m1 <- summary(m1)
inf_m1

## nota il summary produce elementi non presenti nell'oggetto lm()
names(inf_m1)

## diagnostica grafica default di R
plot(m1)


## ovviamente possiamo guardare ad altri apsetti
plot(density(m1$residuals))
rug(m1$residuals)


## Oppure possiamo guardare ai valori previsti vs i valori osservati
plot(wage , m1$fitted)
abline(coef = c(0,1), col=2)


## Utilizzo delle stime: effetti marginali e variazioni previste
## *************************************************************

## Es 1: quale è l'incremento medio previsto di salario mensile  a fronte di 
## un incremento di IQ di 1 un punto (mantenendo tutti gli altri regressori
## costanti) ? 
##
m1$coefficients[3]


## Es 2: quale è l'incremento medio previsto di salario mensile  a fronte di
## un incremento di IQ di 5 punti (mantenendo tutti gli altri regressori
## costanti) ? 
##
5 * m1$coefficients[3]


## Es 2: quale è l'incremento medio previsto di salario mensile a fronte
## di una riduzione della frequenza scolastica di 3 anni (mantenendo tutti gli
## altri regressori costanti) ? 
##
-3 * m1$coefficients[4]


## Proviamo a stimare un modello simile aggiungendo una variabile nominale
## (dicotomica)
black <- as.factor(black)
m2    <- lm(wage ~ 1 + age + iq + educ + exper + black)

summary(m2)


## Quale è la differenza di salarimo medio mensile tra i black e i non black
m2$coefficients[6]

## Attenzioni a calcolare le variazioni previste in media quando ci sono variabili
## dicotomiche!

## Es: quale è l'incremento medio previsto di salario mensile a fronte
## di un incremento  della frequenza scolastica di 3 anni
## (mantenendo tutti gli altri regressori costanti) ? 

## Se black = 1
3 * m2$coefficients[4] + m2$coefficients[6]

## Se black = 0
3 * m2$coefficients[4]


## previsione in-sample
y_cappello <- predict(m2)
y_cappello[1:10]


## Previsione out-of-sample
## supponiamo di voler il reddito mensile di due nuovi casi non osservati 
##              age  iq    educ  exper   black
## Giuseppe     38   100   13    12      0
## Shanice      39   106   13    14      1
##
data2   <- data.frame(age   = c(38,39),
                      iq    = c(100,106),
                      educ  = c(13, 13),
                      exper = c(12,14),
                      black = as.factor(c(0,1))
                      )
rownames(data2) <- c("Giuseppe", "Shanice")
data2

## La funzione di metodo predict è molto potente
predict(m2, newdata = data2)







## Variabile risposta (indipendente) dicotomica: modello logit 
## ***********************************************************

## Carichiamo il dataset "UCLA Admissions"
## descrizione: http://www.decg.it/pcoretto/datasets/ucla_admissions_README.txt
##
load(url("http://www.decg.it/pcoretto/datasets/ucla_admissions.RData"))
str(dat)
attach(dat)


## statistiche descrittive
summary(dat)


## Stimiamo un modello logit per "admit" con il metodo della Massima Verosimiglianza (ML)
##
## p = Pr{admit = 1 | regressori}
## log(p/{1-p}) = logit(p)
## logit( p | X) = cost + beta_1 * gre + beta_2 *gpa + beta_3 * rank
m3  <- glm( admit ~ 1 + gre + gpa , data=dat ,  family="binomial")
m3

## Esploriamo il contenitore restituito dal glm
names(m3)
class(m3)

## Inferenza sui parametri del modello
summary(m3)


## Interpretazioni del summary
## ***************************
##
## * una variazione unitaria nello score GRE aumenta il "log-odds di essere ammesso"
##   di 0.002. Il pvalue rigetta l'ipotesi nulla che il GRE non ha impatto, quindi
##   concludiamo che GRE ha un impatto sulla probabilità di ammissione
##
## * una variazione unitaria di GPA aumenta il "log-odds di essere ammesso" di 0.75.
##   Anche in questo caso, sulla base del p-value,  l'impatto è statisticamente
##   significativo per valori ragionevoli del livello di significatività. 
##   
## * Si può dimostrare che se b è il coefficiente beta di X allora
## 
##   100*{exp(b)-1} 
##   
##   misura il tasso di variazione percentuale dell'odds in favore di Y=1 quando 
##   X varia di una unità.
##   
##   Ad esempio dalle stime otteniamo che il coefficiente di GPA è 0.754687, 
##   quindi una variazione di 1 punto di GPA aumenta l'odds in favore di 'admit' 
##   di
##   
##   100*{exp(0.754687)-1} =   112.7%
##
##   si tratta di un impatto enorme,  ma cosa significa 1 punto di GPA? Il GPA 
##   americano corrisponde alla media esami su scala [0, 4], quindi 1 punto di 
##   GPA significa aumentare la media esami di uno studente italiano di 3/30 che
##   corrisponde ad un aumento di 8.5 (su 110) in termini di voto di laurea
##
## * La differenza tra devianza Null e devianza residua ci dice che il modello con le
##   due variabili esplicative (gre e gpa) spiega meglio del modello con la sola
##   costante


## Calcoliamo le variazioni attese percentuali degli odds in favore di admit per
## tutte le fetures
100 * { exp(coef(m3)) - 1 }


## calcoliamo gli intervalli di confidenza al 95% sui parametri del modello (i beta)
confint(m3, level = 0.95)


## Stima il log-odds di 'admit' per il campione osservato, in pratica stima 
## log(eta/{1-eta}) per ognuna delle osservazioni nel campione
logodds_admit <- predict(m3)
logodds_admit


## Stima Pr{Y = 1 | X} = eta = Pr{admit = 1 | X} sul campione osservato
pr_admit <- predict(m3, type = "response")
pr_admit



## Prevvisione di Pr{admit = 1 | X} out-of-sample. Supponiamo uno studente modello
## che sta quasi al massino in termini di GRE e GPA
xnew <- data.frame( gre = 799  , gpa=3.99)
xnew

## La previsione del  "log-odds di essere ammesso" per il nuovo caso è 
-4.949378  + 0.002691 * 799  +  0.754687 * 3.99


## Possiamo usare il metodo predict per "prevedere" il suo log-odds in favore di 
## admit
predict(m3 , xnew)

## oppure "prevediamo" direttamente la Pr{admit = 1 | X}
predict(m3 , xnew ,  type = "response")


