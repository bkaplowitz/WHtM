// Table 3 (WHtM PHtM HtM NHtM NW-HtM for sensitivity analysis)
///////////////////////////////////////////////////////////////////////////////
// baseline
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
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

replace Wh2m5 = . if year == 1989
replace Ph2m5 = . if year == 1989
replace Nh2m5 = . if year == 1989
replace h2m5 = . if year == 1989
collapse (mean) Wh2m0=Wh2m Ph2m0=Ph2m Nh2m0=Nh2m h2m0=h2m h2mNW0=h2mNW Wh2m1 Ph2m1 Nh2m1 h2m1 Wh2m5 Ph2m5 Nh2m5 h2m5 [aw=wgt], by(im0100)

gen i = 1
reshape wide Wh2m0 Ph2m0 Nh2m0 h2m0 h2mNW0 Wh2m1 Ph2m1 Nh2m1 h2m1 Wh2m5 Ph2m5 Nh2m5 h2m5, i(i) j(im0100)

local vars "Wh2m0 Ph2m0 Nh2m0 h2m0 h2mNW0 Wh2m1 Ph2m1 Nh2m1 h2m1 Wh2m5 Ph2m5 Nh2m5 h2m5"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape long Wh2m Ph2m Nh2m h2m h2mNW, i(i) s

destring _j, replace
gen varname = "Baseline" if _j == 0
replace varname = "HtM1" if _j == 1
replace varname = "HtM5" if _j == 5
drop _j

// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
replace h2mNW = "---" if h2mNW == "."

order varname, first
drop i
save baseline.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// weekly pay period
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
// thorough explanation)
global paymfreq 8
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

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i

local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

gen varname = "Weekly pay period"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save weekly.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// monthly pay period
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
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

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Monthly pay period"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save monthly.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Comm. Cons. Beg.
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
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

global h2mtype commconsbeg1x
////////////////////////////////////////////////////////////////////////////////

do ${progdir}/aa_genHtM.do
collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Comm. cons. - beg."
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save commconsbeg.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Comm. Cons. End.
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
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

global h2mtype commconsend1x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Comm. cons. - end"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save commconsend.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Reported credit limit
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
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

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Reported credit limit"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save borrmaxcred.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// 12 months income as credit limit
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
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

global h2mtype borr12x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "1 year income credit limit"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save borr12x.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// higher limit for illiquid
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
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

global illiqvarlim 1000
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Higher illiquid wealth cutoff"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save higherilliq.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add Business wealth
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// sample selection
*AGE RESTRICTIONS
keep if age>=22 & age<=79

// drop if negative labor income
drop if labinc<0
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// specificy the baseline parameter constellation (See README for more 
// thorough explanation)
global paymfreq 4
gen paymfreq = $paymfreq

global incvar labincplus
gen monthlabinc = ${incvar}/12

global liqvar netbrliq
gen liqvar   = $liqvar

global illiqvar netbrilliqbusnc
gen illiqvar   = $illiqvar
gen nwvar    = networthbusnc

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Businesses as illiquid assets"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save business.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add stocks to illiquid
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
// thorough explanation)
global paymfreq 4
gen paymfreq = $paymfreq

global incvar labinc
gen monthlabinc = ${incvar}/12

global liqvar netbrliqnstocks
gen liqvar   = $liqvar

global illiqvar netbrilliqncstocks
gen illiqvar   = $illiqvar
gen nwvar    = networthnc

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Direct as illiquid assets"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save stocks.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// exclude ccpuzzle guys
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
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

gen ccpuzz = brliqpos > monthlabinc/paymfreq & ccdebt > 0
drop if ccpuzz == 1

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Excludes cc puzzle households"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save creditpuzz.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add helocs to liquid
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
// thorough explanation)
global paymfreq 4
gen paymfreq = $paymfreq

global incvar labinc
gen monthlabinc = ${incvar}/12

global liqvar netbrliqheloc
gen liqvar   = $liqvar

global illiqvar netbrilliqncheloc
gen illiqvar   = $illiqvar
gen nwvar    = networthnc

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "HELOCs as liquid debt"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save heloc.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add misc assets (collectibles, guns, etc) to illiquid
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
// thorough explanation)
global paymfreq 4
gen paymfreq = $paymfreq

global incvar labinc
gen monthlabinc = ${incvar}/12

global liqvar netbrliq
gen liqvar   = $liqvar

global illiqvar netbrilliqncmisc
gen illiqvar   = $illiqvar
gen nwvar    = networthncmisc

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Other valuables as illiquid assets"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save misc.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// usual income
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
// thorough explanation)
global paymfreq 4
gen paymfreq = $paymfreq

global incvar usuallabinc
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

keep if year >= 1995

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Usual income"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save usual.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// removes taxes from income: taxsim assumes everyone is single with no kids
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
// thorough explanation)
global paymfreq 4
gen paymfreq = $paymfreq

global incvar netlabinc1
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

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Disposable income - Single"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save taxes_sing.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// removes taxes from income: taxsim assumes files as reported
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
// thorough explanation)
global paymfreq 4
gen paymfreq = $paymfreq

global incvar netlabinc
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

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Disposable income - Reported"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save taxes_marr.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// financially fragile households
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
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

global h2mtype finfrag
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Financially fragile households"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save finfrag.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// retirement accounts as liquid for retirees
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
////////////////////////////////////////////////////////////////////////////////
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
// specificy the baseline parameter constellation (See README for more 
// thorough explanation)
global paymfreq 4
gen paymfreq = $paymfreq

global incvar labinc
gen monthlabinc = ${incvar}/12

global liqvar netbrliq_retirees
gen liqvar   = $liqvar

global illiqvar netbrilliqnc_retirees
gen illiqvar   = $illiqvar
gen nwvar    = networthnc

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do

collapse (mean) Wh2m Ph2m Nh2m h2m h2mNW [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m h2mNW, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m h2mNW"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Ret. acc. as liquid for 60+"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
replace h2m = round(h2m,.001)
replace h2mNW = round(h2mNW,.001)
tostring Wh2m Ph2m Nh2m h2m h2mNW, replace format("%9.3f") force
order varname, first
save retirees.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// appends data
clear
set obs 1
gen varname = " "
gen Wh2m = "W-HtM"
gen Ph2m = "P-HtM"
gen Nh2m = "N-HtM"
gen h2m = "HtM"
gen h2mNW = "HtM-NW"

append using baseline.dta
append using borrmaxcred.dta 
append using borr12x.dta
append using weekly.dta
append using monthly.dta
append using commconsbeg.dta
append using commconsend.dta 
append using higherilliq.dta 
append using business.dta
append using stocks.dta
append using misc.dta
append using creditpuzz.dta
append using heloc.dta
append using usual.dta
append using taxes_sing.dta
append using taxes_marr.dta
append using finfrag.dta
append using retirees.dta
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// cleanup
!rm baseline.dta
!rm weekly.dta
!rm monthly.dta
!rm commconsbeg.dta
!rm commconsend.dta
!rm borrmaxcred.dta
!rm borr12x.dta
!rm higherilliq.dta
!rm business.dta
!rm stocks.dta
!rm misc.dta
!rm creditpuzz.dta
!rm heloc.dta
!rm usual.dta
!rm taxes_sing.dta
!rm taxes_marr.dta
!rm finfrag.dta
!rm retirees.dta
///////////////////////////////////////////////////////////////////////////////

replace varname = "Usually, c $>$ y" if varname == "HtM1"
replace varname = "In past year, c $>$ y" if varname == "HtM5"
replace varname = "Comm. cons. - beg. of period" if varname == "Comm. cons. - beg."
replace varname = "Comm. cons. - end of period" if varname == "Comm. cons. - end"

gen i = 1 if varname == "Baseline"
replace i = 2 if varname == "In past year, c $>$ y"
replace i = 3 if varname == "Usually, c $>$ y"
replace i = 4 if varname == "Financially fragile households"
replace i = 5 if varname == "Reported credit limit"
replace i = 6 if varname == "1 year income credit limit"
replace i = 7 if varname == "Weekly pay period"
replace i = 8 if varname == "Monthly pay period"
replace i = 10 if varname == "Higher illiquid wealth cutoff"
replace i = 11 if varname == "Ret. acc. as liquid for 60+"
replace i = 12 if varname == "Businesses as illiquid assets"
replace i = 13 if varname == "Direct as illiquid assets"
replace i = 14 if varname == "Other valuables as illiquid assets"
replace i = 15 if varname == "Excludes cc puzzle households"
replace i = 16 if varname == "HELOCs as liquid debt"
replace i = 17 if varname == "Usual income"
replace i = 18 if varname == "Disposable income - Reported"
replace i = 19 if varname == "Disposable income - Single"
replace i = 20 if varname == "Comm. cons. - beg. of period"
replace i = 21 if varname == "Comm. cons. - end of period"

replace i = 0 if varname == " "
sort i

///////////////////////////////////////////////////////////////////////////////
// tex up the table
replace h2mNW = h2mNW + " \\"
replace h2mNW = h2mNW + " \hline" if i == 0 | i == 4 | i == 6 | i == 8 | i == 14 | i == 16 | i == 19 | i == 21

drop i

cd ${rawdir}/output

outsheet varname Ph2m Wh2m Nh2m h2m h2mNW ///
using tab3.tex, delim("&") nonames nolabel noquote replace
///////////////////////////////////////////////////////////////////////////////

