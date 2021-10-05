********************************************************************************
DATA SET DESCRIPTION:  card.RData
********************************************************************************


card.RData contains a data.frame called  'card_dataset'. This is a sample of
of n=3010 working men aged between 24 and 34  who were part of the 1976 wave
of the US "National Longitudinal Survey" of Young Men. 

This data set was used to estimate earnings equations in the famous paper

Card, D. (1993). Using geographic variation in college proximity to estimate
the return to schooling (No. w4483), National Bureau of Economic Research.
url: http://www.nber.org/papers/w4483

Variable description
********************
 1. id                       person identifier
 2. nearc2                   =1 if near 2 yr college, 1966
 3. nearc4                   =1 if near 4 yr college, 1966
 4. educ                     years of schooling, 1976
 5. age                      in years
 6. fatheduc                 father's schooling
 7. motheduc                 mother's schooling
 8. weight                   NLS sampling weight, 1976
 9. momdad14                 =1 if live with mom, dad at 14
10. sinmom14                 =1 if with single mom at 14
11. step14                   =1 if with step parent at 14
12. reg661                   =1 for region 1, 1966
13. reg662                   =1 for region 2, 1966
14. reg663                   =1 for region 3, 1966
15. reg664                   =1 for region 4, 1966
16. reg665                   =1 for region 5, 1966
17. reg666                   =1 for region 6, 1966
18. reg667                   =1 for region 7, 1966
19. reg668                   =1 for region 8, 1966
20. reg669                   =1 for region 9, 1966
21. south66                  =1 if in south in 1966
22. black                    =1 if black
23. smsa                     =1 in in SMSA, 1976
24. south                    =1 if in south, 1976
25. smsa66                   =1 if in SMSA, 1966
26. wage                     hourly wage in cents, 1976
27. enroll                   =1 if enrolled in school, 1976
28. KWW                      knowledge world of work score
29. IQ                       IQ score
30. married                  =1 if married, 1976
31. libcrd14                 =1 if lib. card in home at 14
32. exper                    age - educ - 6
33. lwage                    log(wage)
34. expersq                  exper^2
