// pulls in country survey data, collapses, and creates figure

//fig 2a
///////////////////////////////////////////////////////////////////////////////
// US
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear

////////////////////////////////////////////////////////////////////////////////
// sample selection
*AGE RESTRICTIONS
keep if age>=22 & age<=79

// drop if negative labor income
drop if labinc<0

// drop if have only self employment income
drop if (labearn1 == 0 & selfearn1>0) | (labearn2 == 0 &  selfearn2>0)
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// specificy the relevant parameter constellation (See README for more 
// thorough explanation)
global paymfreq 4
gen paymfreq = $paymfreq

global incvar labinc
gen monthlabinc = ${incvar}/12

global liqvar netbrliq
gen liqvar   = $liqvar

global illiqvar netbrilliqnc
gen illiqvar   = $illiqvar
gen nwvar    = networthnc

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
keep if year == 2010

gen liqincratio = liqvar/monthlabinc

replace liqincratio = 10 if liqincratio > 10
replace liqincratio = -10 if liqincratio < -10

gen fwgt = round(wgt,1)

collapse (mean) liqincratio (mean) fwgt (mean) year [aw=fwgt], by(YY1)

cd ${rawdir}/output
gen wgt = round(fwgt,1)
hist liqincratio[fw=wgt], xlabel(-10(5)10) name(ratUS) color(black) ///
ytitle("Fraction of households") xtitle("Net liquid wealth to monthly labor income ratio") ysc(r(0(.05).3)) ylabel(0(.05).3) fraction
graph export fig2a.eps, replace
window manage close graph "ratUS"
///////////////////////////////////////////////////////////////////////////////

//fig 2b
///////////////////////////////////////////////////////////////////////////////
// CA
cd $CAdir/cleandata
use SFS2005_cleaned.dta, clear

////////////////////////////////////////////////////////////////////////////////
// sample selection
*AGE RESTRICTIONS
keep if age>=22 & age<=79

// drop if negative labor income
drop if labinc<0
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// specificy the relevant parameter constellation (See README for more 
// thorough explanation)
global paymfreq 4
gen paymfreq = $paymfreq

global incvar labinc
gen monthlabinc = ${incvar}/12

global liqvar netbrliq
gen liqvar   = $liqvar

global illiqvar netbrilliqnc
gen illiqvar   = $illiqvar
gen nwvar    = networthnc

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
gen liqincratio = liqvar/monthlabinc

replace liqincratio = 10 if liqincratio > 10
replace liqincratio = -10 if liqincratio < -10

cd ${rawdir}/output
gen wgt = round(fwgt,1)
hist liqincratio [fw=wgt], xlabel(-10(5)10) name(ratCA) color(black) ///
ytitle("Fraction of households") xtitle("Net liquid wealth to monthly labor income ratio") ysc(r(0(.05).3)) ylabel(0(.05).3) fraction
graph export fig2b.eps, replace
window manage close graph "ratCA"

///////////////////////////////////////////////////////////////////////////////

//fig 2c
///////////////////////////////////////////////////////////////////////////////
// AU
cd $AUdir/cleandata
use HILDA_Wj_cleaned.dta, clear

////////////////////////////////////////////////////////////////////////////////
// sample selection
*AGE RESTRICTIONS
keep if age>=22 & age<=79

// drop if negative labor income
drop if labinc<0

// drop if have only self employment income
drop if (hh_earnings == 0 & hh_selfy>0)
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// specificy the relevant parameter constellation (See README for more 
// thorough explanation)
global paymfreq 4
gen paymfreq = $paymfreq

global incvar labinc
gen monthlabinc = ${incvar}/12

global liqvar netbrliq
gen liqvar   = $liqvar

global illiqvar netbrilliqnc
gen illiqvar   = $illiqvar
gen nwvar    = networthnc

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
gen liqincratio = liqvar/monthlabinc

replace liqincratio = 10 if liqincratio > 10
replace liqincratio = -10 if liqincratio < -10
cd ${rawdir}/output
gen wgt = round(fwgt,1)
hist liqincratio [fw=wgt], xlabel(-10(5)10) name(ratAU) color(black) ///
ytitle("Fraction of households") xtitle("Net liquid wealth to monthly labor income ratio") ysc(r(0(.05).3)) ylabel(0(.05).3) fraction
graph export fig2c.eps, replace
window manage close graph "ratAU"

///////////////////////////////////////////////////////////////////////////////

//fig 2d
///////////////////////////////////////////////////////////////////////////////
// UK
cd $UKdir/cleandata
use WAS_W2_cleaned.dta, clear

////////////////////////////////////////////////////////////////////////////////
// sample selection
*AGE RESTRICTIONS
keep if agedum>=5 & agedum<=16

// drop if negative labor income
drop if labinc<0

// drop if have only self employment income
drop if (hh_earnings == 0 & hh_selfy>0)
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// specificy the relevant parameter constellation (See README for more 
// thorough explanation)
global paymfreq 4
gen paymfreq = $paymfreq

global incvar labinc
gen monthlabinc = ${incvar}/12

global liqvar netbrliq
gen liqvar   = $liqvar

global illiqvar netbrilliqnc
gen illiqvar   = $illiqvar
gen nwvar    = networthnc

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
gen liqincratio = liqvar/monthlabinc

replace liqincratio = 10 if liqincratio > 10
replace liqincratio = -10 if liqincratio < -10

cd ${rawdir}/output
gen wgt = round(fwgt,1)
hist liqincratio [fw=wgt], xlabel(-10(5)10) name(ratUK) color(black) ///
ytitle("Fraction of households") xtitle("Net liquid wealth to monthly labor income ratio") ysc(r(0(.05).3)) ylabel(0(.05).3) fraction
graph export fig2d.eps, replace
window manage close graph "ratUK"

///////////////////////////////////////////////////////////////////////////////

//fig 2e-h
///////////////////////////////////////////////////////////////////////////////
// EU
local countries "DE FR IT ES"
cd $EUdir/cleandata
use HFCS_cleaned.dta, clear

////////////////////////////////////////////////////////////////////////////////
// sample selection
*AGE RESTRICTIONS
keep if age>=22 & age<=79

// drop if negative labor income
drop if labinc<0

// drop if have only self employment income
drop if (hh_earnings == 0 & hh_selfy>0)
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// specificy the relevant parameter constellation (See README for more 
// thorough explanation)
global paymfreq 4
gen paymfreq = $paymfreq

global incvar labinc
gen monthlabinc = ${incvar}/12

global liqvar netbrliq
gen liqvar   = $liqvar

global illiqvar netbrilliqnc
gen illiqvar   = $illiqvar
gen nwvar    = networthnc

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
gen liqincratio = liqvar/monthlabinc

replace liqincratio = 10 if liqincratio > 10
replace liqincratio = -10 if liqincratio < -10


collapse (mean) liqincratio (mean) fwgt [aw=fwgt], by(sa0010 sa0100)

keep if sa0100 == "DE" | sa0100 == "FR" | sa0100 == "IT" | sa0100 == "ES"

gen wgt = round(fwgt,1)

foreach c of local countries{
cd ${figdir}

if strmatch("`c'", "DE") == 1 {
local p e
}
if strmatch("`c'", "FR") == 1 {
local p f
}
if strmatch("`c'", "IT") == 1 {
local p g
}
if strmatch("`c'", "ES") == 1 {
local p h
}
cd ${rawdir}/output
hist liqincratio if sa0100 == "`c'" [fw=wgt], xlabel(-10(5)10) name(rat`c') color(black) ///
ytitle("Fraction of households") xtitle("Net liquid wealth to monthly labor income ratio") ysc(r(0(.05).3)) ylabel(0(.05).3) fraction
graph export fig2`p'.eps, replace
window manage close graph "rat`c'"
}






