## *****************************************************************************
## Course: Econometrics
## 
## LMEF/MEF - University of Naples "Federico II"
## (c) Pietro Coretto (pcoretto@unisa.it)
##
## Topics:
##   * algebra of ols
##   * cov matrix of the ols estimator and estimated stde under the CLRM
##   * lm() function for computing LS estimates
## *****************************************************************************


## Load the file directly from the url
load(file = url("http://www.decg.it/pcoretto/datasets/nls80.RData"))

## look at the documentation
## http://www.decg.it/pcoretto/datasets/nls80_README.txt

# or you can download the file from R and then you load it
# download.file(url="http://www.decg.it/pcoretto/datasets/nls80.RData",
#               destfile = "nls80.RData")
# load("nls80.RData")


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














