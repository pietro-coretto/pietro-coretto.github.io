## *****************************************************************************
## Course: Econometrics
## 
## LMEF/MEF - University of Naples "Federico II"
## (c) Pietro Coretto (pcoretto@unisa.it)
##
## Topics:
##   * data from Card (1993)
##   * endogenous regressors
##   * finding and checking IVs
##   * GMM/IV estimator
##   * compare LS vs IV estimator 
## *****************************************************************************



## See data description file at
## http://www.decg.it/pcoretto/datasets/card_README.txt

## Load data
load(url("http://www.decg.it/pcoretto/datasets/card.RData"))

str(card_dataset)

## I love to use 'dat' for the  data set!
dat <- card_dataset

## Sample size
n <- nrow(dat)









## ENDOGENEITY IN THE WAGE EQUATION (Card, 1993)
## -----------------------------------------------------------------------------

## Reproduce  Table 2, column (2) of Card (1993).
fit_1 <- lm(lwage ~ 1+ educ + exper + expersq + black + south + smsa +
                reg661 + reg662 + reg663  + reg664 + reg665 + reg666 +
                reg667 +  reg668 + smsa66, data = dat)

summary(fit_1)

## Card (1993) argued why 'educ' is endogenous.  In fact it is correlated with
## 'ability' which is not measured and goes into the error term of the
## regression above.  Then we know that the orhogonality between 'educ' and
## 'error' can't be supported. Therefore, the inference above is meaningless.
## 
## Card (1993) proposes to use 'nearc4' (a dummy) as an IV for 'educ'.  We assess
## whether 'nearc4' is a good instrument for 'enduc'.
## 
## * exogeneity: 'nearc4' is orthogonal to the error term in the wage
##   equation. This can't be veryfied on data. The approach is that we assume it
##   because there is no economic arguments against it
##
## * relevance: 'nearc4' must be correlated with educ', and corellated to 'lwage'
##   only indirectly through 'educ'. To check this we regress 'educ' on 'nearc4'
##   controlling for all the exogenous variables appearing in the equation.

fit_2 <- lm(educ ~ nearc4 + exper + expersq + black + south + smsa +
                reg661 + reg662 + reg663  + reg664 + reg665 + reg666 + reg667 +
                reg668 + smsa66, data = dat)

summary(fit_2)


## The coefficient of 'nearc4' means that in 1976, with all other factors kept constant
## (experience, race, region, and so on), an individual living  near a college in 1966
## had, on average, about 1/3 of a year more education compared to those that hadn't
## grown up near a college. Based on OLS inference (assuming spherical erros), here
## we reject the hypothesis that the coefficient of 'nearc4' is zero.  Therefore,
## 'nearc4' is correlated to 'educ' even if we consider all other factors that are 
## relevant for 'lwage'.
##
## Note: we would had better run the test using the non-spherical error approach
## (White's robuts covariance matrix). However, I want to replicate the famous
## Card's paper here

## Now check wether the effect of 'nearc4' on wages is only indirect.
fit_3 <- lm(lwage  ~ nearc4 + exper + expersq + black + south + smsa + reg661 + reg662
            + reg663  + reg664 + reg665 + reg666 + reg667 +  reg668 +
            smsa66, data = dat)

summary(fit_3)


## and now we control for  'educ'
fit_4 <- lm(lwage ~ nearc4 + educ + exper + expersq + black + south + smsa
            + reg661 + reg662 + reg663  + reg664 + reg665 + reg666 + reg667
            +  reg668 + smsa66, data = dat)

summary(fit_4)
## done! it seems that 'nearc4' is a good IV for 'educ'










## IV estimator (= GMM for a just-identified linear models) 
## -----------------------------------------------------------------------------

## There are a number of R pkgs that do  linear models with IVs, GMM and
## 2SLS. In this script we do it our own implementation to better fix concepts 


## We want to be consistent with slides' notation 
y <- dat$lwage

## Z =  design matrix of regressors
Z <- cbind(const   = 1,
           educ    = dat$educ,
           exper   = dat$exper,
           expersq = dat$expersq,
           black   = dat$black,
           south   = dat$south,
           smsa    = dat$smsa,
           reg661  = dat$reg661,
           reg662  = dat$reg662,
           reg663  = dat$reg663,
           reg664  = dat$reg664,
           reg665  = dat$reg665,
           reg666  = dat$reg666,
           reg667  = dat$reg667,
           reg668  = dat$reg668,
           smsa66  = dat$smsa66)

## number of regressors
L  <- ncol(Z)

## Let's have a look to the first few rows of Z in RStudio view
head(Z)


## Let's store the names of the regressor variables for the future
reg_names <- colnames(Z)

## X = matrix of exogenous variables
## nearc4 is used as an instrument for educ
X        <- Z           ## make a copy of Z in X
X[ , 2]  <- dat$nearc4  ## replace the endgenous with its IV


## number of exogenous variables
K  <- ncol(X)





## Estimate the IV estimator od 'delta'
## -----------------------------------------------------------------------

## The inverse of X'Z is needed several times. Therefore, we compute it once
## and we store it. Note that if the "rank condition" is not fulfilled on the
## data set, this is the place where we can get into numerical troubles
## 
invXpZ  <- solve( t(X)%*%Z )

## Ready to compute the IV estimator:
delta_iv  <- invXpZ  %*%  t(X) %*% y

## It's better to rename the elements of the parameter vector just in case
## the names of the instruments make some mess
names(delta_iv) <- reg_names

## This reproduces the coefficient on  'educ' reported in column 5 of Table 3
## in Card (1995).
delta_iv


## REMARK:
## the IV estimator does not depend on how we order column  of the
## X matrix. You can check if you like: redo the estimation changing the order
## of the column of X (see homeworks)


## get estimated coefficients and standard errors from 'fit_1'
coeff_fit_1  <- summary(fit_1)$coefficients[, 1]
se_fit_1     <- summary(fit_1)$coefficients[, 2]


## compare estimates and take the original as baseline
data.frame(ls_estimator   = coeff_fit_1,
           iv_estimator   = delta_iv,
           perc_variation = 100* {delta_iv - coeff_fit_1 } / abs(coeff_fit_1)
           )





## Approximate asymptotic Var of delta_iv (requires "sufficiently large n")
## -------------------------------------------------------------------------

## Compute predicted values
yhat   <- Z %*% delta_iv

## Compute residuals and error variance
e      <- y - yhat
s2     <- 1/{n-L} * sum(e^2)

## Construct the B matrix
B       <- matrix(0, ncol=n, nrow=n)
diag(B) <- e^2

## Estimated approximate asymptotic variance
hatVarIV <- invXpZ %*% {t(X) %*% B %*% X}  %*% invXpZ


## Heteroskedasticity-Robust standard errors
## -----------------------------------------
se_iv <- sqrt( diag(hatVarIV) )


## Now compare with original estimates
data.frame(ls_estimator   = se_fit_1,
           iv_estimator   = se_iv,
           perc_variation = 100 * {se_iv - se_fit_1 } / abs(se_fit_1)
           )


## REMARK
## In column 5 of Table 3, Card (1995)  reports a standrd errors for the
## IV estimator equal to 0.055 (66% larger than that above). This is because
## Card (1995) is based on 2SLS estimator which is equivalent to IV assuming 
## homoschedastic errors. 





## Compare 95%-confidence intervals
## ---------------------------------

## Both the OLS and the IV are asymptotically normal(0,1). Hence, for both of
## them confidence intervals can be obtained as
## 
##          estimate ± qnorm(1-alpha/2) * standard_error

alpha <- 0.95
za    <- qnorm(1-alpha/2)

## let's look at all intervals compared in a nice table
data.frame(LS_inf =  coeff_fit_1 - za * se_fit_1,
           IV_inf =  delta_iv    - za * se_iv,
           LS_sup =  coeff_fit_1 + za * se_fit_1,
           IV_sup =  delta_iv    + za * se_iv
           )



