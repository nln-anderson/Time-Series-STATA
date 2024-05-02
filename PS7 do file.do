* Creating new features that are adjusted for inflation
generate csales = (384.9)/(CPI)*(csales_orig)
generate isales = (384.9)/(CPI)*(isales_orig)

*Part 1
use "C:\Users\nolio\OneDrive\Documents\ECON370\PS7\sales.dta", clear

tsset t   
*very important, tells Stata we are using TIME SERIES data

reg  csales isales
**** Remember that in TIME SERIES DATA, we do NOT use    , robust

*Part 1.3.1
generate y=year
drop if y==.
	* drop if y==.				- drop if `y' is missing observations
reg csales isales 
predict res, resid
twoway line res year, yline(0) title("Part 1.3.1: Residuals Over Time") xtitle(Time) ytitle(Residuals)
graph export "C:\Users\nolio\OneDrive\Documents\ECON370\PS7\PS8_Part1_3_1.png", replace
*Part 1.4
*Using default tests in Stata
reg csales isales
gen trend=_n
tsset trend

***TEST 1
estat durbinalt
*dwatsonalt	- higher orders of serial correl. & lagged dependent variables allowed

***TEST 2

estat dwatson
*dwatson	- only for first order autocorrelation without lagged dependent var


***TEST 3
estat bgodfrey, lags(1)
*bgodfrey, lags(#)	- computes BG test serial corr. in residuals, need lag number 

prais csales  isales , corc
*NEWEY WEST  correction for serial correlation
newey csales isales , lag(1)
*HOW MANY LAGS OF A VARIABLE SHOULD I USE (IF ANY) - CORRELOGRAM
set more off
*Using default tests in Stata	
corrgram csales
outreg2 using "C:\Users\nolio\OneDrive\Documents\ECON370\PS7\Correlogram.doc"

* Creating lagged variable
sort year
gen csalesL1=csales[_n-1]

reg csales isales csalesL1
outreg2 using "C:\Users\nolio\OneDrive\Documents\ECON370\PS7\LagReg.doc"
estat durbinalt
*dwatsonalt	- higher orders of serial correl. & lagged dependent variables allowed

***TEST 2

estat dwatson
*dwatson	- only for first order autocorrelation without lagged dependent var


***TEST 3
estat bgodfrey, lags(1)

*bgodfrey, lags(#)	- computes BG test serial corr. in residuals, need lag number 
twoway line csales year, yline(0) title("Part 3.2: S Yearly csales " ///
     ", Over Time") xtitle(Year) ytitle(csales)
graph export "C:\Users\nolio\OneDrive\Documents\ECON370\PS7\csales.png", replace
* Part 3.3
dfuller csales, lags(2) trend regress
*dfuller				- performs augmented Dickey-Fuller test that var follows a unit root

outreg2 using "C:\Users\nolio\OneDrive\Documents\ECON370\PS7\DescStats.doc", replace sum(log) keep(csales isales year CPI) label

