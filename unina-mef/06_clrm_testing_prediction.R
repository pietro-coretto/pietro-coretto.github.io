## *****************************************************************************
## Course: Econometrics
## 
## LMEF/MEF - University of Naples "Federico II"
## (c) Pietro Coretto (pcoretto@unisa.it)
##
## Topics:
##   * testing with CLRM-ols 
##   * linear restction tests
## *****************************************************************************

## Load the file directly from the url
load(file = url("http://www.decg.it/pcoretto/datasets/nls80.RData"))

## look at the documentation
## http://www.decg.it/pcoretto/datasets/nls80_README.txt





## lm() function and default individual t-tests
## --------------------------------------------

## a more professional way to use lm()
## first we write down the model in the R grammar: "output ~ inputs"
## 
m_1 <- "lwage ~ 1 + exper + tenure + married + south + urban + black + educ + iq"

## compute lm() object 
fit_1 <- lm(m_1,  data = NLS80)

## summary of the lm object
sum_m1 <- summary(fit_1)

## default individual t-tests
sum_m1

## confidence interval for coefficients
confint(m_1, level = 0.95)

## Default joint test statistic (F-statistics)
sum_m1$fstatistic












## Compute F-statistics as a Wald statistics using matrix algebra 
## --------------------------------------------------------------

## In order to compute the formula for the F-statistics we need the design 
## matrix (regressors) X. In order to do that you can build the matrix 'by hand'.
## However, you can get X from the fit object:
## 
X <- model.matrix(fit_1, data = NLS80)
View(X)


## first we need the b (ols estimates) vector
b <- coefficients(fit_1)
b


## we also need error variance
n  <- nrow(X)
K  <- ncol(X)
s2 <- sum(fit_1$residuals^2)/{n-K}



## For the 'default joint test' 
## 
##                 Ho: beta_2 = beta_2 =...= beta_K = 0
##                 
## We have K parameters and J= {K-1} restrictions (equations). 
J <- K-1

## we contruct the R matrix and the r vector (see my handnotes). There are several 
## possibilities, I do it my own way:

## obtain a zero matrix 
R <- matrix(0, ncol = K, nrow = J)

## except for the first column, the remaining matrix is like an identity
diag( R[,-1]) <- 1
R

## construct the r vector, this is just
r <- rep(0, times = J)
r


## Implement the F formula using the Wald-type formulation (see slide 15/22 
## in slideset 6)
Q      <- s2 * R %*% solve(t(X) %*% X) %*% t(R)
Fstat  <- 1/J * t(R%*%b - r) %*% solve(Q) %*% (R%*%b - r)

## check! 
Fstat
sum_m1$fstatistic












## Compute Wald-type linear restriction test using high-level functions 
## --------------------------------------------------------------------


## install 'car' library (you do it just once)
## install.packages("car")


## load library 
library(car)

## We pass R and r to the linearHypothesis() function 
linearHypothesis(fit_1, hypothesis.matrix = R, rhs = r)

## or we can write down the Ho using names of the variables
Hnull <- c("exper=0", "tenure=0", "married=0", 
           "south=0" , "urban=0" , "black=0", 
           "educ=0" , "iq=0")
linearHypothesis(fit_1, Hnull)



## supopse now we want to test 
## 
##       Ho:  marginal effect of 'exper' = marginal effect of 'tenure'
##   
## Ho can be reformulated as a single equation: beta_exper - beta_tenure = 0
## 
Hnull_2 <- c("exper - tenure = 0")
linearHypothesis(fit_1, Hnull_2)



## can you tell what am I testing here?
## 
Hnull_3 <- c("exper - tenure = 0", "urban - 0.5*south = 0")
linearHypothesis(fit_1, Hnull_2)












## END of script





