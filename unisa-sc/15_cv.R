## =============================================================================
## Corso:          Statistica computazionale 
## Cdl/Percorso:   Management e Informatica
## Docente:        Pietro Coretto (pcoretto@unisa.it)
##
## Argomenti:
##   + errore  di  previsione
##   + cross-validation  nella  regressione  lineare
##   + MonteCarlo cross-validation
##   + 10-fold cross-validation
## =============================================================================




## Dataset:  http://www.decg.it/pcoretto/datasets/nls80_README.txt
load(url("http://www.decg.it/pcoretto/datasets/nls80.RData"))
str(NLS80)

## Dividiamo il dataset in due parti (uguali)
n <- nrow(NLS80)
n
n1 <- round(n/2)
n1

## Prendiamo gli indici delle osservazioni che faranno parte della primo subsample 
idx_train <-  1:n1


## Stimiamo un modello lineare sulla prima metà del dataset 
A1 <- lm(wage ~ 1 + age + iq + educ + exper , data = NLS80[idx_train, ])

## Usiamo il modello stimato per prevedere la Y (wage) nell'altro campione
hatYtest <- predict(A1, newdata = NLS80[-idx_train, ])

## Quali sono le Y osservate sul test set?
Ytest <- NLS80[-idx_train, ]$wage

## Calcoliamo l'errore quadratico  di previsione
mean( {Ytest - hatYtest}^2 )





## Monte Carlo Cross-Validation 
## ****************************


## Modello A: wage ~ 1 + age + iq + educ + exper
set.seed(1)
R          <- 100
pred_error_mccv_A <- rep(0, R)
for (r in 1:R){

    message("Itereazione " , r , " di " , R)
    
    ## In ogni iterazione prendiamo a caso n1 osservazioni da inserire
    ## nel train data set
    idx_train <- sample(1:n , size = n1, replace = FALSE) 
    
    ## Stimiamo un modello lineare sul train set 
    fit <- lm(wage ~ 1 + age + iq + educ + exper , data = NLS80[idx_train, ])

    ## Usiamo il modello stimato per prevedere la Y (wage) nell'altro campione
    hatYtest <- predict(fit, newdata = NLS80[ -idx_train, ])

    ## Y osservate sul test set?
    Ytest <- NLS80[-idx_train, ]$wage

    ## Calcoliamo l'errore quadratico  di previsione e lo memorizziamo in pred_error 
    pred_error_mccv_A[r] <- mean( {Ytest - hatYtest}^2 )
}

## Errore di previsione quadratico medio
mean(pred_error_mccv_A)

sqrt(mean(pred_error_mccv_A))






## Modello B: wage ~ 1 + age + educ + exper
set.seed(2)
R            <- 100
pred_error_mccv_B <- rep(0, R)
for (r in 1:R){

    message("Itereazione " , r , " di " , R)
    
    ## In ogni iterazione prendiamo a caso n1 osservazioni da inserire
    ## nel train data set
    idx_train <- sample(1:n , size = n1, replace = FALSE) 
    
    ## Stimiamo un modello lineare sul train set 
    fit <- lm(wage ~ 1 + age  + educ + exper , data = NLS80[idx_train, ])

    ## Usiamo il modello stimato per prevedere la Y (wage) nell'altro campione
    hatYtest <- predict(fit, newdata = NLS80[ -idx_train, ])

    ## Y osservate sul test set?
    Ytest <- NLS80[-idx_train, ]$wage

    ## Calcoliamo l'errore quadratico  di previsione e lo memorizziamo in pred_error 
    pred_error_mccv_B[r] <- mean( {Ytest - hatYtest}^2 )
}

## Errore di previsione quadratico medio
mean(pred_error_mccv_B)


## Nota
mean(pred_error_mccv_A) < mean(pred_error_mccv_B)






## K-fold cross-validation
## ***********************


## Per ottenere le fold si può usare l'ottimo package "caret"
##
library(caret)
set.seed(77)
K <- 10
U <- createFolds(1:n, k = K , returnTrain = TRUE)


## Ad esempio U[[1]] contiene la lista degli indici delle osservazioni nel 
## primo TRAIN set
U[[1]]






## Modello A: wage ~ 1 + age + iq + educ + exper
pred_error_kfcv_A <- rep(0, K)
for (k in 1:K){

    message("Itereazione " , k , " di " , K)
    
    ## Indici del test data set 
    idx_train <- U[[k]]
    
    ## Stimiamo un modello lineare sul train set 
    fit <- lm(wage ~ 1 + age + iq + educ + exper , data = NLS80[idx_train, ])

    ## Usiamo il modello stimato per prevedere la Y (wage) nell'altro campione
    hatYtest <- predict(fit, newdata = NLS80[-idx_train, ])

    ## Y osservate sul test set?
    Ytest <- NLS80[-idx_train, ]$wage

    ## Calcoliamo l'errore quadratico  di previsione e lo memorizziamo in pred_error 
    pred_error_kfcv_A[k] <- mean( {Ytest - hatYtest}^2 )
}

## Errore di previsione quadratico medio
mean(pred_error_kfcv_A)





## Modello B: wage ~ 1 + age + educ + exper
pred_error_kfcv_B <- rep(0, K)
for (k in 1:K){

    message("Itereazione " , k , " di " , K)
    
    ## Indici del test data set 
    idx_train <- U[[k]]
    
    ## Stimiamo un modello lineare sul train set 
    fit <- lm(wage ~ 1 + age  + educ + exper , data = NLS80[idx_train, ])
    ## Usiamo il modello stimato per prevedere la Y (wage) nell'altro campione
    hatYtest <- predict(fit, newdata = NLS80[-idx_train, ])
    
    ## Y osservate sul test set?
    Ytest <- NLS80[-idx_train, ]$wage
    
    ## Calcoliamo l'errore quadratico  di previsione e lo memorizziamo in pred_error 
    pred_error_kfcv_B[k] <- mean( {Ytest - hatYtest}^2 )
}

## Errore di previsione quadratico medio
mean(pred_error_kfcv_B)




## Nota
mean(pred_error_kfcv_A) -  mean(pred_error_kfcv_B)

