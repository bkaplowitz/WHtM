local countries "DE FR IT ES"

///////////////////////////////////////////////////////////////////////////////
// EU
foreach c of local countries {

// baseline
///////////////////////////////////////////////////////////////////////////////
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
keep if sa0100 == "`c'"

collapse (mean) Wh2m0=Wh2m Ph2m0=Ph2m Nh2m0=Nh2m Wh2m1 Ph2m1 Nh2m1 [aw=fwgt], by(im0100)

gen i = 1
reshape wide Wh2m0 Ph2m0 Nh2m0 Wh2m1 Ph2m1 Nh2m1, i(i) j(im0100)

local vars "Wh2m0 Ph2m0 Nh2m0 Wh2m1 Ph2m1 Nh2m1"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape long Wh2m Ph2m Nh2m, i(i) s

destring _j, replace
gen varname = "relevant" if _j == 0
replace varname = "HtM5" if _j == 1
drop _j

// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)
tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force

if strmatch("`c'","FR")==1 {
replace Wh2m = "---" if varname == "HtM5"
replace Ph2m = "---" if varname == "HtM5"
replace Nh2m = "---" if varname == "HtM5"
}

order varname, first
drop i

cd $progdir
save `c'_relevant.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// weekly
///////////////////////////////////////////////////////////////////////////////
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

keep if sa0100 == "`c'"
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt], by(im0100)
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
save `c'_weekly.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// monthly
///////////////////////////////////////////////////////////////////////////////
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
keep if sa0100 == "`c'"
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt], by(im0100)
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
save `c'_monthly.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Comm. Cons. Beg.
///////////////////////////////////////////////////////////////////////////////
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

global h2mtype commconsbeg1x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do
keep if sa0100 == "`c'"
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt], by(im0100)
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
save `c'_commconsbeg.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Comm. Cons. End.
///////////////////////////////////////////////////////////////////////////////
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

global h2mtype commconsend1x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do
keep if sa0100 == "`c'"
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt], by(im0100)
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
save `c'_commconsend.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Borr 12x
///////////////////////////////////////////////////////////////////////////////
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

global h2mtype borr12x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do
keep if sa0100 == "`c'"
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt], by(im0100)
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
save `c'_borr12x.dta, replace
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// add cars
///////////////////////////////////////////////////////////////////////////////
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

global illiqvar netbrilliqcars
gen illiqvar   = $illiqvar
gen nwvar    = networthcars

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do
keep if sa0100 == "`c'"
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt], by(im0100)
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
save `c'_cars.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add Business wealth
///////////////////////////////////////////////////////////////////////////////
cd $EUdir/cleandata
use HFCS_cleaned.dta, clear

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
keep if sa0100 == "`c'"
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt], by(im0100)
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
save `c'_business.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add stocks to illiquid
///////////////////////////////////////////////////////////////////////////////
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
keep if sa0100 == "`c'"
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt], by(im0100)
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
save `c'_stocks.dta, replace
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// add helocs to liquid
///////////////////////////////////////////////////////////////////////////////
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
keep if sa0100 == "`c'"

cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt], by(im0100)
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
save `c'_heloc.dta, replace
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// add misc assets (collectibles, guns, etc) to illiquid
///////////////////////////////////////////////////////////////////////////////
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

global illiqvar netbrilliqncmisc
gen illiqvar   = $illiqvar
gen nwvar    = networthncmisc

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do
keep if sa0100 == "`c'"
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt], by(im0100)
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
save `c'_misc.dta, replace
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// removes taxes from income (parameters from guner verntura)
if strmatch("`c'","IT")==0 {
clear
set obs 1
gen varname = "Disposable income"
gen Wh2m = "---"
gen Ph2m = "---"
gen Nh2m = "---"
order varname, first
cd $progdir
save `c'_taxes.dta, replace
}
else {
///////////////////////////////////////////////////////////////////////////////
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
keep if sa0100 == "`c'"

cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt], by(im0100)
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
save `c'_taxes.dta, replace
}
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// financially fragile households
///////////////////////////////////////////////////////////////////////////////
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

global h2mtype finfrag
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do
keep if sa0100 == "`c'"

cd $progdir

collapse (mean) Wh2m Ph2m Nh2m h2m [aw=fwgt], by(im0100)
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
save `c'_finfrag.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// credit puzzle
///////////////////////////////////////////////////////////////////////////////
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
keep if sa0100 == "`c'"

gen ccpuzz = brliqpos > monthlabinc/paymfreq & ccdebt > 0
drop if ccpuzz == 1

cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt], by(im0100)
gen i = 1
reshape wide Wh2m Ph2m Nh2m, i(i) j(im0100)
drop i

local vars "Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

gen varname = "Excludes cc puzzle households"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save `c'_creditpuzz.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// retirement accounts as liquid for retirees
///////////////////////////////////////////////////////////////////////////////
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
keep if sa0100 == "`c'"

cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt], by(im0100)
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
save `c'_retirees.dta, replace
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

append using `c'_relevant.dta
append using `c'_borr12x.dta
append using `c'_weekly.dta
append using `c'_monthly.dta
append using `c'_commconsbeg.dta
append using `c'_commconsend.dta 
append using `c'_cars.dta
append using `c'_business.dta
append using `c'_stocks.dta
append using `c'_misc.dta
append using `c'_heloc.dta
append using `c'_taxes.dta
append using `c'_finfrag.dta
append using `c'_creditpuzz.dta
append using `c'_retirees.dta
save `c'.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// cleanup
cd $progdir
!rm `c'_relevant.dta
!rm `c'_borr12x.dta
!rm `c'_weekly.dta
!rm `c'_monthly.dta
!rm `c'_commconsbeg.dta
!rm `c'_commconsend.dta 
!rm `c'_cars.dta
!rm `c'_business.dta
!rm `c'_stocks.dta
!rm `c'_misc.dta
!rm `c'_heloc.dta
!rm `c'_taxes.dta
!rm `c'_finfrag.dta
!rm `c'_creditpuzz.dta
!rm `c'_retirees.dta
///////////////////////////////////////////////////////////////////////////////


}
