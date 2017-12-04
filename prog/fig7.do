// fig 7a
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

collapse (mean) educ [aw=wgt], by(age h2m_status im0100)
reshape wide educ, i(age h2m_status) j(im0100)

local vars "educ"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape wide educ, i(age) j(h2m_status)
rename educ1 Wh2m
rename educ2 Ph2m
rename educ3 Nh2m

cd ${rawdir}/output

line Wh2m Ph2m Nh2m age, clcolor(blue red*.75 dkgreen) ysc(r(6 16)) ylabel(#5, grid) xlabel(,grid) ///
name(fig7a)  lpattern(dash_dot dash solid)  xtitle("Age") ///
legend(ring(0) pos(11) label(1 "W-HtM") label(2 "P-HtM") label(3 "N-HtM")) lwidth(thick thick thick)
graph export fig7a.eps, replace
window manage close graph "fig7a"
///////////////////////////////////////////////////////////////////////////////


// fig 7b married
// fig 7a
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

collapse (mean) married [aw=wgt], by(age h2m_status im0100)
reshape wide married, i(age h2m_status) j(im0100)

local vars "married"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape wide married, i(age) j(h2m_status)
rename married1 Wh2m
rename married2 Ph2m
rename married3 Nh2m

cd ${rawdir}/output

line Wh2m Ph2m Nh2m age, clcolor(blue red*.75 dkgreen) ysc(r(0 .8)) ylabel(#5, grid) xlabel(,grid) ///
name(fig7b) lpattern(dash_dot dash solid)  xtitle("Age") ///
legend(off) lwidth(thick thick thick)
//title("Age profile of fraction married") 
graph export fig7b.eps, replace
window manage close graph "fig7b"
///////////////////////////////////////////////////////////////////////////////


// fig 7c children
// fig 7a
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

collapse (mean) kids [aw=wgt], by(age h2m_status im0100)
reshape wide kids, i(age h2m_status) j(im0100)

local vars "kids"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape wide kids, i(age) j(h2m_status)
rename kids1 Wh2m
rename kids2 Ph2m
rename kids3 Nh2m

cd ${rawdir}/output

line Wh2m Ph2m Nh2m age, clcolor(blue red*.75 dkgreen) ysc(r(0 .8)) ylabel(#5, grid) xlabel(,grid) ///
name(fig7c) lpattern(dash_dot dash solid)  xtitle("Age") ///
legend(off) lwidth(thick thick thick)
//title("Age profile of number children") 
graph export fig7c.eps, replace
window manage close graph "fig7c"
///////////////////////////////////////////////////////////////////////////////


// fig 7d
// fig 7a
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

collapse (median) labinc [aw=wgt], by(age h2m_status im0100)
reshape wide labinc, i(age h2m_status) j(im0100)

local vars "labinc"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape wide labinc, i(age) j(h2m_status)
rename labinc1 Wh2m
rename labinc2 Ph2m
rename labinc3 Nh2m

cd ${rawdir}/output

line Wh2m Ph2m Nh2m age, clcolor(blue red*.75 dkgreen) ysc(r(0 80000)) ylabel(#5, grid) xlabel(,grid) ///
name(fig7d)  lpattern(dash_dot dash solid)  xtitle("Age") ///
legend(off) lwidth(thick thick thick)
//title("Age profile of median income")
graph export fig7d.eps, replace
window manage close graph "fig7d"
///////////////////////////////////////////////////////////////////////////////




// fig 7e unemp
// fig 7a
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

collapse (mean) unemp [aw=wgt], by(age h2m_status im0100)
reshape wide unemp, i(age h2m_status) j(im0100)

local vars "unemp"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape wide unemp, i(age) j(h2m_status)
rename unemp1 Wh2m
rename unemp2 Ph2m
rename unemp3 Nh2m

cd ${rawdir}/output

line Wh2m Ph2m Nh2m age, clcolor(blue red*.75 dkgreen) ysc(r(0 .3)) ylabel(#5, grid) xlabel(,grid) ///
name(fig7e) lpattern(dash_dot dash solid)  xtitle("Age") ///
legend(off) lwidth(thick thick thick)
//title("Age profile of fraction of HH with with unemployed member") 
graph export fig7e.eps, replace
window manage close graph "fig7e"
///////////////////////////////////////////////////////////////////////////////

// fig 7f frac of income from benefits
// fig 7a
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

gen govfrac = (uiben+childben+tanf+ssinc)/labinc

collapse (mean) govfrac [aw=wgt], by(age h2m_status im0100)
reshape wide govfrac, i(age h2m_status) j(im0100)

local vars "govfrac"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape wide govfrac, i(age) j(h2m_status)
rename govfrac1 Wh2m
rename govfrac2 Ph2m
rename govfrac3 Nh2m

cd ${rawdir}/output

line Wh2m Ph2m Nh2m age, clcolor(blue red*.75 dkgreen) ysc(r(0 .8)) ylabel(#5, grid) xlabel(,grid) ///
name(fig7f) lpattern(dash_dot dash solid)  xtitle("Age") ///
legend(off) lwidth(thick thick thick)
graph export fig7f.eps, replace
window manage close graph "fig7f"
///////////////////////////////////////////////////////////////////////////////
