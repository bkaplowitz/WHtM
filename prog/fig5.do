// fig 5a
///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_16_cleaned.dta, clear

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

gen wgtnew = wgt*labinc
collapse (mean) Wh2m Nh2m Ph2m [aw=wgtnew], by(year im0100)
reshape wide Wh2m Nh2m Ph2m, i(year) j(im0100)

local vars "Wh2m Nh2m Ph2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

cd ${rawdir}/output

graph bar Wh2m Ph2m, over(year) stack bar(1, color(blue*1)) bar(2, color(red*.75)) ///
legend(ring(0) pos(12)  label(1 "W-HtM") label(2 "P-HtM") ) ysc(r(0 .5)) ylabel(#5) name(fig5a) 
//title("Time series of fraction HtM: 1 month credit limit")
graph export fig5a.eps, replace
window manage close graph "fig5a"
///////////////////////////////////////////////////////////////////////////////


// fig 5b
///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_16_cleaned.dta, clear

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
global paymfreq 2
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

collapse (mean) h2m (mean) Wh2m (mean) Ph2m (mean) Nh2m [aw=wgt], by(year im0100)
reshape wide h2m Wh2m Ph2m Nh2m, i(year) j(im0100)

local vars "h2m Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

cd ${rawdir}/output

graph bar Wh2m Ph2m, over(year) stack bar(1, color(blue*1)) bar(2, color(red*.75)) ///
legend(off) ysc(r(0 .5)) ylabel(#5) name(fig5b)
//title("Monthly pay period")
graph export fig5b.eps, replace
window manage close graph "fig5b"

///////////////////////////////////////////////////////////////////////////////



// fig 5c
///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_16_cleaned.dta, clear

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

global h2mtype borrmaxcredit
////////////////////////////////////////////////////////////////////////////////

do ${progdir}/aa_genHtM.do

collapse (mean) h2m (mean) Wh2m (mean) Ph2m (mean) Nh2m [aw=wgt], by(year im0100)
reshape wide h2m Wh2m Ph2m Nh2m, i(year) j(im0100)

local vars "h2m Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

cd ${rawdir}/output

graph bar Wh2m Ph2m, over(year) stack bar(1, color(blue*1)) bar(2, color(red*.75)) ///
legend(off) ysc(r(0 .5)) ylabel(#5) name(fig5c) 
graph export fig5c.eps, replace
window manage close graph "fig5c"

///////////////////////////////////////////////////////////////////////////////




// fig 5d
///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_16_cleaned.dta, clear

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

global illiqvar netbrilliqcars
gen illiqvar   = $illiqvar
gen nwvar    = networthcars

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////

do ${progdir}/aa_genHtM.do

collapse (mean) h2m (mean) Wh2m (mean) Ph2m (mean) Nh2m [aw=wgt], by(year im0100)
reshape wide h2m Wh2m Ph2m Nh2m, i(year) j(im0100)

local vars "h2m Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

cd ${rawdir}/output

graph bar Wh2m Ph2m, over(year) stack bar(1, color(blue*1)) bar(2, color(red*.75)) ///
legend(off) ysc(r(0 .5)) ylabel(#5) name(fig5d)
graph export fig5d.eps, replace
window manage close graph "fig5d"

///////////////////////////////////////////////////////////////////////////////


