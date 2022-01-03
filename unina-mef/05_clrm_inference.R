## *****************************************************************************
## Course: Econometrics
## LMEF/MEF - University of Naples "Federico II"
## (c) Pietro Coretto (pcoretto@unisa.it)
## *****************************************************************************


## dataset: https://pietro-coretto.github.io/datasets/nls80/readme.txt
load(file = url("https://pietro-coretto.github.io/datasets/nls80/nls80.RData"))



## data set structure
str(NLS80)

## Sample size
n  <- nrow(NLS80)


## OLS computing
## -------------

## Prepare the X matrix (with constant) and y vector, the following method
## gives names to the columns of X which is useful.
X  <- cbind(const   = 1,
            exper   = NLS80$exper,
            tenure  = NLS80$tenure,
            married = NLS80$married,
            south   = NLS80$south,
            urban   = NLS80$urban,
            black   = NLS80$black,
            educ    = NLS80$educ,
            iq      = NLS80$iq)
K  <- ncol(X)
y  <-  NLS80$lwage



## Compute estimates
## Remark: it's convenient to compute the inverse of (X'X) just once
invXpX <- solve( t(X) %*% X )

## OLS solution 
b      <- invXpX  %*% t(X) %*% y

## look at estimated coefficients
b

## predicted values (also known as 'fitted values')
yhat  <- X %*% b


## residual 
e   <- y - yhat

## scatter of residuals
plot(e)

## let's look at the distribution of residuals
plot(density(e))

## do they look normal? 
qqnorm(e)
qqline(e)


## estimated unbiased variance of error
s2     <- sum(e^2)/{n-K}

## estimated var-cov matrix of OSL estimator for beta
var_ols <- s2 * invXpX
var_ols


## we can obtain the estimated correlation matrix of betas
cov2cor(var_ols)


## let's round correlitions
round(cov2cor(var_ols) , 2)


## standard errors
sqrt(diag(var_ols))





## OLS with the lm() function 
## --------------------------

## redo the analysis with lm() function
## Note: if you don't know how to obtain '~' (tilde) on your keyboard
##       you may google: "how to tilde keyboard"
fit <- lm(lwage ~ 1 + exper + tenure + married + south + urban + black + educ + iq,
          data = NLS80)
str(fit)

## See the contect of 'fit'
names(fit)

## for example we can get residuals
fit$residuals

## predicted values (yhat)
fit$fitted.values

## summary of the lm object
sumfit <- summary(fit)
sumfit

## See the contect of fit and summary(fit)
names(sumfit)

## Do you want to extract OLS estimates? Look at the matrix sumfit$coefficients
sumfit$coefficients[,1]  ## coefficients
sumfit$coefficients[,2]  ## standard errors
sumfit$coefficients[,3]  ## t-stat


## estimated cov matrix of OLS estimator 
vcov(fit)
sqrt(diag(vcov(fit))) ## sqrt of the diagonal = standard erros










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





