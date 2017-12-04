// fig 10a
///////////////////////////////////////////////////////////////////////////////
// US
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
keep if year == 2010
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

do ${progdir}/aa_genHtM.do
collapse (mean) h2m (mean) Wh2m (mean) Ph2m (mean) Nh2m [aw=wgt], by(agedum im0100)
reshape wide h2m Wh2m Ph2m Nh2m, i(agedum) j(im0100)

local vars "h2m Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}


cd ${rawdir}/output

line Wh2m Ph2m agedum, clcolor(blue red*.75 dkgreen) ysc(r(0 .4)) ylabel(0(.1).4, grid) xlabel(,grid) ///
name(fig10a) legend(ring(0) pos(11) label(1 "W-HtM") label(2 "P-HtM") label(3 "N-HtM")) ///
lpattern(dash_dot dash solid) xtitle("Age") ///
xlabel(1(1)12, valuelabel) lwidth(thick thick thick)
//title("Age profile of fraction of HtM: US") 
graph export fig10a.eps, replace
window manage close graph "fig10a"

///////////////////////////////////////////////////////////////////////////////

//fig 10b
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


do ${progdir}/aa_genHtM.do
collapse (mean) h2m Wh2m Ph2m Nh2m [aw=fwgt], by(agedum)

cd ${rawdir}/output

line Wh2m Ph2m agedum, clcolor(blue red*.75 dkgreen) ysc(r(0 .4)) ylabel(0(.1).4, grid) xlabel(,grid) ///
name(fig10b) legend(off) xtitle("Age") ///
lpattern(dash_dot dash solid) xlabel(1(1)12, valuelabel) lwidth(thick thick thick)
//title("Age profile of fraction of HtM: CA") 
graph export fig10b.eps, replace
window manage close graph "fig10b"

///////////////////////////////////////////////////////////////////////////////

//fig 10c
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

do ${progdir}/aa_genHtM.do
collapse (mean) h2m Wh2m Ph2m Nh2m [aw=fwgt], by(agedum)

cd ${rawdir}/output

line Wh2m Ph2m agedum, clcolor(blue red*.75 dkgreen) ysc(r(0 .4)) ylabel(0(.1).4, grid) xlabel(,grid) ///
name(fig10c) legend(off) lpattern(dash_dot dash solid) xtitle("Age") ///
xlabel(1(1)12, valuelabel) lwidth(thick thick thick)
//title("Age profile of fraction of HtM: CA") 
graph export fig10c.eps, replace
window manage close graph "fig10c"

///////////////////////////////////////////////////////////////////////////////

//fig 10d
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

do ${progdir}/aa_genHtM.do
collapse (mean) h2m Wh2m Ph2m Nh2m [aw=fwgt], by(agedum)

cd ${rawdir}/output

line Wh2m Ph2m agedum, clcolor(blue red*.75 dkgreen) ysc(r(0 .4)) ylabel(0(.1).4, grid) xlabel(,grid) ///
name(fig10d) legend(off) lpattern(dash_dot dash solid) xtitle("Age") ///
xlabel(5(1)16, valuelabel) lwidth(thick thick thick)
//title("Age profile of fraction of HtM: UK") 
graph export fig10d.eps, replace
window manage close graph "fig10d"

///////////////////////////////////////////////////////////////////////////////

//fig 10e
///////////////////////////////////////////////////////////////////////////////
// DE
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

do ${progdir}/aa_genHtM.do

keep if sa0100 == "DE"
collapse (mean) h2m Wh2m Ph2m Nh2m [aw=fwgt], by(agedum im0100)
// averages over imputations
reshape wide h2m Wh2m Ph2m Nh2m, i(agedum) j(im0100)
local vars "h2m Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
label define l_age 1 "22-24", add
label define l_age 2 "25-29", add 
label define l_age 3 "30-34", add
label define l_age 4 "35-39", add
label define l_age 5 "40-44", add
label define l_age 6 "45-49", add
label define l_age 7 "50-54", add
label define l_age 8 "55-59", add
label define l_age 9 "60-64", add
label define l_age 10 "65-69", add
label define l_age 11 "70-74", add
label define l_age 12 "75-79", add
label values agedum l_age


cd ${rawdir}/output

line Wh2m Ph2m agedum, clcolor(blue red*.75 dkgreen) ysc(r(0 .4)) ylabel(0(.1).4, grid) xlabel(,grid) ///
name(fig10e) legend(off) lpattern(dash_dot dash solid) xtitle("Age") ///
xlabel(1(1)12, valuelabel) lwidth(thick thick thick)
//title("Age profile of fraction of HtM: DE") 
graph export fig10e.eps, replace
window manage close graph "fig10e"
///////////////////////////////////////////////////////////////////////////////


//fig 10f
///////////////////////////////////////////////////////////////////////////////
// FR
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

do ${progdir}/aa_genHtM.do
keep if sa0100 == "FR"
collapse (mean) h2m Wh2m Ph2m Nh2m [aw=fwgt], by(agedum im0100)
// averages over imputations
reshape wide h2m Wh2m Ph2m Nh2m, i(agedum) j(im0100)
local vars "h2m Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
label define l_age 1 "22-24", add
label define l_age 2 "25-29", add 
label define l_age 3 "30-34", add
label define l_age 4 "35-39", add
label define l_age 5 "40-44", add
label define l_age 6 "45-49", add
label define l_age 7 "50-54", add
label define l_age 8 "55-59", add
label define l_age 9 "60-64", add
label define l_age 10 "65-69", add
label define l_age 11 "70-74", add
label define l_age 12 "75-79", add
label values agedum l_age


cd ${rawdir}/output

line Wh2m Ph2m agedum, clcolor(blue red*.75 dkgreen) ysc(r(0 .4)) ylabel(0(.1).4, grid) xlabel(,grid) ///
name(fig10f) legend(off) lpattern(dash_dot dash solid) xtitle("Age") ///
xlabel(1(1)12, valuelabel) lwidth(thick thick thick)
//title("Age profile of fraction of HtM: FR")
graph export fig10f.eps, replace
window manage close graph "fig10f"
///////////////////////////////////////////////////////////////////////////////


//fig 10g
///////////////////////////////////////////////////////////////////////////////
// IT
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

do ${progdir}/aa_genHtM.do
keep if sa0100 == "IT"
collapse (mean) h2m Wh2m Ph2m Nh2m [aw=fwgt], by(agedum im0100)
// averages over imputations
reshape wide h2m Wh2m Ph2m Nh2m, i(agedum) j(im0100)
local vars "h2m Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
label define l_age 1 "22-24", add
label define l_age 2 "25-29", add 
label define l_age 3 "30-34", add
label define l_age 4 "35-39", add
label define l_age 5 "40-44", add
label define l_age 6 "45-49", add
label define l_age 7 "50-54", add
label define l_age 8 "55-59", add
label define l_age 9 "60-64", add
label define l_age 10 "65-69", add
label define l_age 11 "70-74", add
label define l_age 12 "75-79", add
label values agedum l_age


cd ${rawdir}/output

line Wh2m Ph2m agedum, clcolor(blue red*.75 dkgreen) ysc(r(0 .4)) ylabel(0(.1).4, grid) xlabel(,grid) ///
name(fig10g) legend(off) lpattern(dash_dot dash solid) xtitle("Age") ///
xlabel(1(1)12, valuelabel) lwidth(thick thick thick)
//title("Age profile of fraction of HtM: IT")
graph export fig10g.eps, replace
window manage close graph "fig10g"
///////////////////////////////////////////////////////////////////////////////


//fig 10h
///////////////////////////////////////////////////////////////////////////////
// ES
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

do ${progdir}/aa_genHtM.do
keep if sa0100 == "ES"
collapse (mean) h2m Wh2m Ph2m Nh2m [aw=fwgt], by(agedum im0100)
// averages over imputations
reshape wide h2m Wh2m Ph2m Nh2m, i(agedum) j(im0100)
local vars "h2m Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
label define l_age 1 "22-24", add
label define l_age 2 "25-29", add 
label define l_age 3 "30-34", add
label define l_age 4 "35-39", add
label define l_age 5 "40-44", add
label define l_age 6 "45-49", add
label define l_age 7 "50-54", add
label define l_age 8 "55-59", add
label define l_age 9 "60-64", add
label define l_age 10 "65-69", add
label define l_age 11 "70-74", add
label define l_age 12 "75-79", add
label values agedum l_age


cd ${rawdir}/output

line Wh2m Ph2m agedum, clcolor(blue red*.75 dkgreen) ysc(r(0 .4)) ylabel(0(.1).4, grid) xlabel(,grid) ///
name(fig10h) legend(off) lpattern(dash_dot dash solid) xtitle("Age") ///
xlabel(1(1)12, valuelabel) lwidth(thick thick thick)
//title("Age profile of fraction of HtM: ES")
graph export fig10h.eps, replace
window manage close graph "fig10h"
///////////////////////////////////////////////////////////////////////////////
