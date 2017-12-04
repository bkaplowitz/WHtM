///////////////////////////////////////////////////////////////////////////////
// AU
// baseline
///////////////////////////////////////////////////////////////////////////////
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

collapse (mean) Wh2m0=Wh2m Ph2m0=Ph2m Nh2m0=Nh2m Wh2m1 Ph2m1 Nh2m1 [aw=fwgt]

gen i = 1
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

order varname, first
drop i

cd $progdir
save AU_relevant.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// weekly
///////////////////////////////////////////////////////////////////////////////
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
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt]
gen varname = "Weekly pay period"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save AU_weekly.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// monthly
///////////////////////////////////////////////////////////////////////////////
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
cd $progdir
collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt]

gen varname = "Monthly pay period"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save AU_monthly.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Comm. Cons. Beg.
cd $AUdatadir
clear
set obs 1
gen varname = "Comm. cons. - beg."
gen Wh2m = "---"
gen Ph2m = "---"
gen Nh2m = "---"
order varname, first
cd $progdir
save AU_commconsbeg.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Comm. Cons. End.
cd $AUdatadir
clear
set obs 1
gen varname = "Comm. cons. - end"
gen Wh2m = "---"
gen Ph2m = "---"
gen Nh2m = "---"
order varname, first
cd $progdir
save AU_commconsend.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Borr 12x
///////////////////////////////////////////////////////////////////////////////
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

global h2mtype borr12x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt]

gen varname = "1 year income credit limit"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save AU_borr12x.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add cars
///////////////////////////////////////////////////////////////////////////////
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

global illiqvar netbrilliqcars
gen illiqvar   = $illiqvar
gen nwvar    = networthcars

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt]

gen varname = "Cars as illiquid assets"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save AU_cars.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add Business wealth
///////////////////////////////////////////////////////////////////////////////
cd $AUdir/cleandata
use HILDA_Wj_cleaned.dta, clear

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
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt]

gen varname = "Businesses as illiquid assets"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save AU_business.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add stocks to illiquid
///////////////////////////////////////////////////////////////////////////////
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
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt]

gen varname = "Direct as illiquid assets"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save AU_stocks.dta, replace
///////////////////////////////////////////////////////////////////////////////




///////////////////////////////////////////////////////////////////////////////
// add helocs to liquid
cd $AUdatadir
clear
set obs 1
gen varname = "HELOCs as liquid debt"
gen Wh2m = "---"
gen Ph2m = "---"
gen Nh2m = "---"
order varname, first
cd $progdir
save AU_heloc.dta, replace
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// add misc assets (collectibles, guns, etc) to illiquid
///////////////////////////////////////////////////////////////////////////////
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

global illiqvar netbrilliqncmisc
gen illiqvar   = $illiqvar
gen nwvar    = networthncmisc

global illiqvarlim 0
gen illiqvarlim = $illiqvarlim

global h2mtype borr1x
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt]

gen varname = "Other valuables as illiquid assets"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save AU_misc.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// financially fragile
///////////////////////////////////////////////////////////////////////////////
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

global h2mtype finfrag
////////////////////////////////////////////////////////////////////////////////
do ${progdir}/aa_genHtM.do
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt]

gen varname = "Financially fragile households"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save AU_finfrag.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// credit card puzzle
///////////////////////////////////////////////////////////////////////////////
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
gen ccpuzz = brliqpos > monthlabinc/paymfreq & ccdebt > 0
drop if ccpuzz == 1

cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt]

gen varname = "Excludes cc puzzle households"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)

tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save AU_creditpuzz.dta, replace
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// removes taxes from income
cd $AUdatadir
clear
set obs 1
gen varname = "Disposable income"
gen Wh2m = "---"
gen Ph2m = "---"
gen Nh2m = "---"
order varname, first
cd $progdir
save AU_taxes.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// retirement accounts as liquid for retirees
///////////////////////////////////////////////////////////////////////////////
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
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt]

gen varname = "Ret. acc. as liquid for 60+"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)

tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save AU_retirees, replace
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

append using AU_relevant.dta
append using AU_borr12x.dta
append using AU_weekly.dta
append using AU_monthly.dta
append using AU_commconsbeg.dta
append using AU_commconsend.dta 
append using AU_cars.dta
append using AU_business.dta
append using AU_stocks.dta
append using AU_misc.dta
append using AU_heloc.dta
append using AU_taxes.dta
append using AU_finfrag.dta
append using AU_creditpuzz.dta
append using AU_retirees.dta
save AU.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// cleanup
cd $progdir
!rm AU_relevant.dta
!rm AU_borr12x.dta
!rm AU_weekly.dta
!rm AU_monthly.dta
!rm AU_commconsbeg.dta
!rm AU_commconsend.dta 
!rm AU_cars.dta
!rm AU_business.dta
!rm AU_stocks.dta
!rm AU_misc.dta
!rm AU_heloc.dta
!rm AU_taxes.dta
!rm AU_finfrag.dta
!rm AU_creditpuzz.dta
!rm AU_retirees.dta
///////////////////////////////////////////////////////////////////////////////
