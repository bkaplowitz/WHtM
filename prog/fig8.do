// fig 8a
///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
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

do ${progdir}/aa_genHtM.do


collapse (median) netbrliq [aw=wgt], by(age h2m_status im0100)
reshape wide netbrliq, i(age h2m_status) j(im0100)

local vars "netbrliq"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape wide netbrliq, i(age) j(h2m_status)
rename netbrliq1 Wh2m
rename netbrliq2 Ph2m
rename netbrliq3 Nh2m

cd ${rawdir}/output

line Wh2m Ph2m Nh2m age, clcolor(blue red*.75 dkgreen) ysc(r(-2500 20000)) ylabel(0(5000)20000, grid) xlabel(,grid) ///
name(fig8a) legend(ring(0) pos(11) label(1 "W-HtM") label(2 "P-HtM") label(3 "N-HtM")) ///
lpattern(dash_dot dash solid) lwidth(thick thick thick) xtitle("Age")
graph export fig8a.eps, replace
window manage close graph "fig8a"
///////////////////////////////////////////////////////////////////////////////

// fig 8b
///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
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

do ${progdir}/aa_genHtM.do

collapse (median) netbrilliqnc [aw=wgt], by(age h2m_status im0100)
reshape wide netbrilliqnc, i(age h2m_status) j(im0100)

local vars "netbrilliqnc"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape wide netbrilliqnc, i(age) j(h2m_status)
rename netbrilliqnc1 Wh2m
rename netbrilliqnc2 Ph2m
rename netbrilliqnc3 Nh2m

cd ${rawdir}/output

line Wh2m Nh2m age, clcolor(blue dkgreen) ysc(r(0 300000)) ylabel(#5, grid) xlabel(,grid) ///
name(fig8b) xtitle("Age") ///
lpattern(dash_dot solid) legend(off) lwidth(thick thick thick)
//title("Age profile of median illiquid wealth") 
graph export fig8b.eps, replace
window manage close graph "fig8b"
///////////////////////////////////////////////////////////////////////////////

// fig 8c
///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
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

do ${progdir}/aa_genHtM.do

gen housefrac = nethouse/illiqvar

_pctile housefrac [aw = wgt], p(0.1 99.9)
drop if housefrac>= r(r2)
drop if housefrac<= r(r1)

collapse (mean) housefrac [aw=wgt], by(age h2m_status im0100)
reshape wide housefrac, i(age h2m_status) j(im0100)

local vars "housefrac"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape wide housefrac, i(age) j(h2m_status)
rename housefrac1 Wh2m
rename housefrac2 Ph2m
rename housefrac3 Nh2m
cd ${rawdir}/output

line Wh2m Nh2m age, clcolor(blue dkgreen) ysc(r(0 1)) ylabel(#5, grid) xlabel(,grid) ///
name(fig8c) xtitle("Age") ///
lpattern(dash_dot solid) legend(off) lwidth(thick thick thick)
// title("Age profile of average fraction of illiquid wealth in housing")
graph export fig8c.eps, replace
window manage close graph "fig8c"
///////////////////////////////////////////////////////////////////////////////


// fig 8d
///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
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

do ${progdir}/aa_genHtM.do

gen retirefrac = retacc/illiqvar

_pctile retirefrac [aw = wgt], p(0.1 99.9)
drop if retirefrac>= r(r2)
drop if retirefrac<= r(r1)

collapse (mean) retirefrac [aw=wgt], by(age h2m_status im0100)
reshape wide retirefrac, i(age h2m_status) j(im0100)

local vars "retirefrac"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape wide retirefrac, i(age) j(h2m_status)
rename retirefrac1 Wh2m
rename retirefrac2 Ph2m
rename retirefrac3 Nh2m

cd ${rawdir}/output

line Wh2m Nh2m age, clcolor(blue dkgreen) ysc(r(0 1)) ylabel(#5, grid) xlabel(,grid) ///
name(fig8d) xtitle("Age") ///
lpattern(dash_dot solid) legend(off) lwidth(thick thick thick)
//title("Average fraction of illiquid wealth in retirement accounts")
graph export fig8d.eps, replace
window manage close graph "fig8d"
///////////////////////////////////////////////////////////////////////////////
