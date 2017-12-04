///////////////////////////////////////////////////////////////////////////////
// US
// baseline
///////////////////////////////////////////////////////////////////////////////
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
// specificy the parameter constellation (See README for more 
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

collapse (mean) Wh2m0=Wh2m Ph2m0=Ph2m Nh2m0=Nh2m Wh2m5 Ph2m5 Nh2m5 [aw=wgt], by(im0100)

gen i = 1
reshape wide Wh2m0 Ph2m0 Nh2m0 Wh2m5 Ph2m5 Nh2m5, i(i) j(im0100)

local vars "Wh2m0 Ph2m0 Nh2m0 Wh2m5 Ph2m5 Nh2m5"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape long Wh2m Ph2m Nh2m, i(i) s

destring _j, replace
gen varname = "relevant" if _j == 0
replace varname = "HtM5" if _j == 5
drop _j

// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force

order varname, first
drop i

cd $progdir
save ${progdir}/US_relevant.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// weekly
///////////////////////////////////////////////////////////////////////////////
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
// specificy the parameter constellation (See README for more 
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
collapse (mean) Wh2m Ph2m Nh2m [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m, i(i) j(im0100)
drop i

local vars "Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

gen varname = "Weekly pay period"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save ${progdir}/US_weekly.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// monthly
///////////////////////////////////////////////////////////////////////////////
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
// specificy the parameter constellation (See README for more 
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
collapse (mean) Wh2m Ph2m Nh2m [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Monthly pay period"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save ${progdir}/US_monthly.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Comm. Cons. Beg.
///////////////////////////////////////////////////////////////////////////////
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
// specificy the parameter constellation (See README for more 
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
collapse (mean) Wh2m Ph2m Nh2m [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Comm. cons. - beg."
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save ${progdir}/US_commconsbeg.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Comm. Cons. End.
///////////////////////////////////////////////////////////////////////////////
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
// specificy the parameter constellation (See README for more 
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
collapse (mean) Wh2m Ph2m Nh2m [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Comm. cons. - end"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save ${progdir}/US_commconsend.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Borr 12x
///////////////////////////////////////////////////////////////////////////////
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
// specificy the parameter constellation (See README for more 
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
collapse (mean) Wh2m Ph2m Nh2m [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "1 year income credit limit"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save ${progdir}/US_borr12x.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add cars
///////////////////////////////////////////////////////////////////////////////
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
// specificy the parameter constellation (See README for more 
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
collapse (mean) Wh2m Ph2m Nh2m [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Cars as illiquid assets"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save ${progdir}/US_cars.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add Business wealth
///////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear
keep if year == 2010
////////////////////////////////////////////////////////////////////////////////
// sample selection
*AGE RESTRICTIONS
keep if age>=22 & age<=79

// drop if negative labor income
drop if labinc<0
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// specificy the parameter constellation (See README for more 
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
collapse (mean) Wh2m Ph2m Nh2m [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Businesses as illiquid assets"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save ${progdir}/US_business.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
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
// specificy the parameter constellation (See README for more 
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
collapse (mean) Wh2m Ph2m Nh2m [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Direct as illiquid assets"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save ${progdir}/US_stocks.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add helocs to liquid
///////////////////////////////////////////////////////////////////////////////
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
// specificy the parameter constellation (See README for more 
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
collapse (mean) Wh2m Ph2m Nh2m [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "HELOCs as liquid debt"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save ${progdir}/US_heloc.dta, replace
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// add misc assets (collectibles, guns, etc) to illiquid
///////////////////////////////////////////////////////////////////////////////
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
// specificy the parameter constellation (See README for more 
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
collapse (mean) Wh2m Ph2m Nh2m [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Other valuables as illiquid assets"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save ${progdir}/US_misc.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// removes taxes from income
///////////////////////////////////////////////////////////////////////////////
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
// specificy the parameter constellation (See README for more 
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
collapse (mean) Wh2m Ph2m Nh2m [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Disposable income"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save ${progdir}/US_taxes.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// financially fragile households
///////////////////////////////////////////////////////////////////////////////
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
// specificy the parameter constellation (See README for more 
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
collapse (mean) Wh2m Ph2m Nh2m h2m[aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m"
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

tostring Wh2m Ph2m Nh2m h2m, replace format("%9.3f") force
order varname, first
save ${progdir}/US_finfrag.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// cc puzzle
///////////////////////////////////////////////////////////////////////////////
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
// specificy the parameter constellation (See README for more 
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

collapse (mean) Wh2m Ph2m Nh2m h2m[aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m h2m, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m h2m"
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

tostring Wh2m Ph2m Nh2m h2m, replace format("%9.3f") force
order varname, first
save ${progdir}/US_creditpuzz.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// retirement accounts as liquid for retirees
///////////////////////////////////////////////////////////////////////////////
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
// specificy the parameter constellation (See README for more 
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
collapse (mean) Wh2m Ph2m Nh2m [aw=wgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m, i(i) j(im0100)
drop i
local vars "Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
gen varname = "Ret. acc. as liquid for 60+"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)

tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save ${progdir}/US_retirees.dta, replace
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// appends data
cd $progdir
clear
set obs 1
gen varname = " "
gen Wh2m = "W-HtM"
gen Ph2m = "P-HtM"
gen Nh2m = "N-HtM"

append using US_relevant.dta
append using US_borr12x.dta
append using US_weekly.dta
append using US_monthly.dta
append using US_commconsbeg.dta
append using US_commconsend.dta 
append using US_cars.dta
append using US_business.dta
append using US_stocks.dta
append using US_misc.dta
append using US_heloc.dta
append using US_taxes.dta
append using US_finfrag.dta
append using US_creditpuzz.dta
append using US_retirees.dta
save US.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// cleanup
cd $progdir
!rm US_relevant.dta
!rm US_borr12x.dta
!rm US_weekly.dta
!rm US_monthly.dta
!rm US_commconsbeg.dta
!rm US_commconsend.dta 
!rm US_cars.dta
!rm US_business.dta
!rm US_stocks.dta
!rm US_misc.dta
!rm US_heloc.dta
!rm US_taxes.dta
!rm US_finfrag.dta
!rm US_creditpuzz.dta
!rm US_retirees.dta
///////////////////////////////////////////////////////////////////////////////
