## *****************************************************************************
## Course: Econometrics
## 
## LMEF/MEF - University of Naples "Federico II"
## (c) Pietro Coretto (pcoretto@unisa.it)
##
## Topics:
##   * ols variance in large samples
##   * lm() and ols variance
##   * package to compute the White's robust covariance  
## *****************************************************************************






## Large Sample OLS and lm() function (homeworks)
## ----------------------------------------------

## Load the file directly from the url
load(file = url("http://www.decg.it/pcoretto/datasets/nls80.RData"))


## inspect data structure
str(NLS80)

## I hate to type NLS80 all the time...
dat <- NLS80


## Sample size
n  <- nrow(dat)

# gennerate  the interaction variable
dat$educ_iq  <-  dat$educ * dat$iq



## OLS computing using matrix calculations
## -----------------------------------------------------------------------------

## Prepare the X matrix (with constant) and y vector, the following method
## gives names to the columns of X which is useful.
X  <- cbind(const   = rep(1, n),
            exper   = dat$exper,
            tenure  = dat$tenure,
            married = dat$married,
            south   = dat$south,
            urban   = dat$urban,
            black   = dat$black,
            educ    = dat$educ,
            iq      = dat$iq,
            educ_iq = dat$educ_iq)
K  <- ncol(X)
y  <- dat$lwage

## Compute estimates
invXpX <- solve( t(X) %*% X )
b      <- invXpX  %*% t(X) %*% y
yhat   <- X %*% b
e      <- y - yhat
s2     <- sum(e^2)/{n-K}








## Asymptotic variance estimates: AVar(b) and  Var(b)
## --------------------------------------------------------------------------


## "Heteroskedasticity-Robust Asymptotic Variance" also known as the
## "Eicker-Huber-White" estimator 
B         <- matrix(0, ncol=n, nrow=n)
diag(B)   <- e^2
hatAvarb  <- n * { invXpX   %*%  {t(X) %*% B %*% X}   %*%   invXpX  }


## REMARK: Avar(b) is the asymptotic variance of sqrt(n)(b - beta)
## Compute the approximate var-cov matrix  of the ols estimator
hatVarb <- hatAvarb / n 


## The function cov2cor() transforms a cov matrix into a correlation matrix.
hatCorb <- cov2cor(hatVarb)
round( hatCorb , digits = 3)


## Extract the approximate standard errors se(b)
seb <- sqrt(diag(hatVarb))
seb
round(seb ,  4)






## Testing coefficients 
## --------------------

## Testing individual coefficients at 5% significance level
tstats <- b / seb

## Critical value at 5%
alpha <- 0.05
za    <- qnorm( 1 - alpha/2 )

## Do we reject H0?
abs(tstats) > za   ## Reject H0 if  TRUE

## The coefficient for the interaction does not pass the test  ==> marginal
## effect of the years of education on the expected log(wage) is not proportional
## to the ability level.






## Redo the analysis with lm() function
## ------------------------------------
olsfit <- lm(lwage ~ 1 + exper + tenure + married + south + urban
                     + black + educ + iq + educ_iq, data = dat)
sumols <- summary(olsfit)
sumols


## estimated variance matrix of  b
vcov(olsfit)
sqrt(diag(vcov(olsfit))) ## sqrt of the diagonal = standard erros


## compare with the se(b) computed before
seb - sumols$coefficients[,2]   ##... they do not match!!!

## Suppose we work with the sphericity assumption, that is A4 in CLRM, and recompute
## the standard erros
seb_spherical <- sqrt( diag( s2 * invXpX ) )


## Now compare with those computed by lm()
seb_spherical - sumols$coefficients[,2] ## now they match up to trunction error


## REMARK
## the comparison above shows that the lm() function does inference based
## on the spherical-error assumption










## Pkgs for approximate varcov matrices of the coeffients estimated with ols
## -------------------------------------------------------------------------

## ## Install some new pkg
## install.package("sandwich")
## install.packages("lmtest")

## Load pkgs
library(sandwich)
library(lmtest)


## The pkg "sandwich" is able to compute several appproximate estimators of Var(b)
## given an lm() object as input. For example the following command estimates
## Var[b] (not AVvar(b)). For example we can easily compute the var matrix
## corresponing to the "Heteroskedasticity-Robust Asymptotic Variance" as follows
hatVarb_2 <- vcovHC(olsfit, type = "HC1")

## now compare the difference with our own implementation before 
hatVarb - hatVarb_2  #... it's a mess

## better to check the max absolute value difference 
max(abs(hatVarb - hatVarb_2 ))


## The pkg "lmtest" has a function to run the t-ratio  default test on individual
## coefficients with a very general interface. Note this can be done with any
## estimator of Var[b]
coeftest(olsfit, vcov. = hatVarb_2)










## Linear restriction tests
## ------------------------
## We can do it with our own implementation of the Wn statistic. Or we can use
## the 'linearHypothesis' from the 'car' pkg.  Suppose  we want to test 
## 
##       Ho:  marginal effect of 'exper' = marginal effect of 'tenure'
##   
## Ho can be reformulated as a single equation: beta_exper - beta_tenure = 0
library(car)
Ho <- "exper - tenure = 0"
linearHypothesis(olsfit, Ho, vcov. = hatVarb_2,  test="Chisq")

## or even without precomputing the hatVarb_2
## linearHypothesis(olsfit, Ho , white.adjust = "hc1")







## Breusch-Godfrey Test: our own implementation 
## --------------------------------------------

## At some point we need to produce lagged version of residuals. R-base has
## the lag() function which requires that the input is a time-series object.
## There are other pkgs with better functions to lag variables.
## Let's take the chance to practice and  produce our own functionality
##
## I program a  custom function that returns a vector of the same size of 'x'
## shifted 'l' position back (when l<0), or 'l' positions ahead (when l>0)
## Elements of x lost during shift are replaced with NA. This is not the best
## way of doing it, but it's not bad
## 
lag_vector <- function(x , l = -1) {

    shift <- abs(l)
    n     <- length(x)

    ## check if we have enough measurements
    if (n-shift < 1) {
        stop("'x' does not contain enough measurements compared to 'l'")
    }
    ## add some more checks on 'x'  here

    if (l<0) {
        ## lag-back x when l<0
        y <-  c(rep(NA, times = shift) , x[1:{n-shift}])
    } else if (l>0){
        ## lag-ahead x when l>0
        y <-  c(x[{1+shift}:n], rep(NA, times = shift)) 
    }else {
        y <- x
    }

    return(y)
}


## Example
x <- 1:10
data.frame(curren_value     = x,
           back_1  = lag_vector(x,  l = -1),
           back_2  = lag_vector(x , l = -2),
           ahead_1 = lag_vector(x , l = 1),
           ahead_2 = lag_vector(x , l = 2)
           )




## Consider "gasoline expenditure data" from Johnston and DiNardo (1997)
file_dat <- url("http://www.decg.it/pcoretto/unina-mef/data_gasoline_expenditure.txt")
dat      <- read.table(file_dat, header = TRUE)

## see some data
head(dat)

## we want to model gas consumption at time t. We also want to create some new
## regressor 
dat$price2       <- dat$price^2
dat$price_income <- dat$price * dat$income 

## model
m1   <- "gas ~ 1 + income + price +  price2 + price_income"
fit  <- lm(m1, data = dat)
summary(fit)

## time-series plot of residuals
plot(fit$residuals , t="l")

## look at the acf
acf(fit$residuals)

## suppose we want to run Breusch-Godfrey test... just in case we still
## some doubts about serial correlation in residuals!
## Suppose we want to test the
## Ho: residuals are uncorrelated up to order p=4

## First we add lagged residuals to the original data
##
dat2 <- cbind(dat,
              e  = fit$residuals,
              e1 = lag_vector(fit$residuals, l = -1),
              e2 = lag_vector(fit$residuals, l = -2),
              e3 = lag_vector(fit$residuals, l = -3),
              e4 = lag_vector(fit$residuals, l = -4))

## let's see 
head(dat2)


## auxiliary regression model
maux    <- "e ~ 1 + income + price +  price2 + price_income + e1 + e2 + e3 + e4"
fit_aux <- lm(maux, data = dat2)

## get the R^2
Raux <- summary(fit_aux)$r.squared

## compute the Breusch-Godfrey test statistic
BGstat <- { nrow(dat) - 4 } * Raux
BGstat

## cutoff value
q_cut <- qchisq(0.95, df = 4)
q_cut

## BGstat > q_Cut  ===> we do not reject Ho







## Breusch-Godfrey Test: implementation from pkg "lmtest"
## -----------------------------------------------------
## install.packages("lmtest")
library("lmtest")

## replicate test
bgtest(fit, order = 4, type = "Chisq", fill = NA)


## try higher order
bgtest(fit, order = 10, type = "Chisq", fill = NA)
























