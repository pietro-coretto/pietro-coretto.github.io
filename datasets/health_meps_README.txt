********************************************************************************
DATA SET DESCRIPTION: health_meps.csv
********************************************************************************

Summary
-------
Data from the  "Medical Expenditure Panel Survey" (MEPS) conducted by the American 
Agency for Healthcare Research and Quality (AHRQ). The MEPS is a set of large-scale
surveys of families and individuals, their medical providers, and employers across
the United States. MEPS is the most complete source of data on the cost and use
of health care and health insurance coverage. See  http://www.meps.ahrq.gov/mepsweb/.
The data considered here are those from panel 7,8 of 2003. The original sample contains
18735 sample points, here we report a random subsample of 2000 units. 
********************************************************************************


Sampling:..............cross-section (2003)
Units:.................US individuals using the health care system
Sample size:...........2000
Number of variables....
Format:................ASCII file, comma separated values (CSV)


Variables:
----------
AGE		age 
ANYLIMIT	=1 if physical limitations apply, =0 otherwise
COLLEGE 	=1 if attended college, = 0 otherwise
HIGHSCH		=1 if attended high school, =0 otherwise
GENDER  	=1 if female, =0 otherwise
MNHPOOR		=1 if self evaluation of mental health is negative, =0 otherwise
insure          =1 if he/she has health insurance, =0 otherwise
USC 		=1 if unsatisfied about the his/her current health care, =0 otherwise 
UNEMPLOY        =1 if jobseeker / gatekeeper, =0 otherwise
famsize		family size 
COUNTIP         number of visits in hospital 
EXPENDIP  	expenditure for hospital visits
COUNTOP		number of outpatiant visits  
EXPENDOP  	expenditure for outpatiant visits 
RACE 		ethnic origin (Asian, Black, Native, Whiteand, other)
RACE1           ethnic origin code (1 = Asian, 2 = Black, 3 = Native, 4 =  White,  0 = otherwise)
REGION          geographic region (WEST, NORTHEAST, MIDWEST, SOUTH)
REGION1		geographic region code (0=WEST, 1=NORTHEAST, 2=MIDWEST, 3=SOUTH)
EDUC		education (LHIGHSC, HIGHSCH and COLLEGE)
EDUC1 		education level code (0 if less than high school,  1 = high school , 2 = college)
MARISTAT        marital status (NEVMAR, MARRIED, WIDOWED and DIVSEP)
MARISTAT1       marital status code (0 = never married, 1 = married, 2 = widow , 3 = divorced or separated)
INCOME 		income relative to the poverty line (POOR < NPOOR < LINCOME < MINCOME < HINCOME)
INCOME1         income relative to the poverty line in codes (0 = poor , 1 = almost poor, 2 = low income , 3= medium income, 4 = high income)
PHSTAT          self evaluation of health conditions (EXCE,VGOO, GOOD, FAIR e POOR)
PHSTAT1:        self evaluation of health conditions in codes  (0 = excellent, 1 = very good, 2 = good,  3 = not bad, 4 = poor)
INDUSCLASS 	industry sector to which the patient belongs
