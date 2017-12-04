///////////////////////////////////////////////////////////////////////////////
// CA
// baseline
///////////////////////////////////////////////////////////////////////////////
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
save CA_relevant.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// weekly
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
save CA_weekly.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// monthly
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
save CA_monthly.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Comm. Cons. Beg.
cd $CAdatadir
clear
set obs 1
gen varname = "Comm. cons. - beg."
gen Wh2m = "---"
gen Ph2m = "---"
gen Nh2m = "---"
order varname, first
cd $progdir
save CA_commconsbeg.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Comm. Cons. End.
cd $CAdatadir
clear
set obs 1
gen varname = "Comm. cons. - end"
gen Wh2m = "---"
gen Ph2m = "---"
gen Nh2m = "---"
order varname, first
cd $progdir
save CA_commconsend.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Borr 12x
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
save CA_borr12x.dta, replace
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// add cars
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
save CA_cars.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add Business wealth
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
save CA_business.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add stocks to illiquid
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
save CA_stocks.dta, replace
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// add helocs to liquid
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
cd $progdir

collapse (mean) Wh2m Ph2m Nh2m [aw=fwgt]

gen varname = "HELOCs as liquid debt"
// rounds and turns to a string
replace Wh2m = round(Wh2m,.001)
replace Ph2m = round(Ph2m,.001)
replace Nh2m = round(Nh2m,.001)


tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
order varname, first
save CA_heloc.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// add misc assets (collectibles, guns, etc) to illiquid
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
save CA_misc.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// removes taxes from income (parameters from guner verntura)
cd $CAdatadir
clear
set obs 1
gen varname = "Disposable income"
gen Wh2m = "---"
gen Ph2m = "---"
gen Nh2m = "---"
order varname, first
cd $progdir
save CA_taxes.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// financially fragile
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
save CA_finfrag.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// credit card puzzle
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
save CA_creditpuzz.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// retirement accounts as liquid for retirees
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
save CA_retirees, replace
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

append using CA_relevant.dta
append using CA_borr12x.dta
append using CA_weekly.dta
append using CA_monthly.dta
append using CA_commconsbeg.dta
append using CA_commconsend.dta 
append using CA_cars.dta
append using CA_business.dta
append using CA_stocks.dta
append using CA_misc.dta
append using CA_heloc.dta
append using CA_taxes.dta
append using CA_finfrag.dta
append using CA_creditpuzz.dta
append using CA_retirees.dta
save CA.dta, replace
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// cleanup
cd $progdir
!rm CA_relevant.dta
!rm CA_borr12x.dta
!rm CA_weekly.dta
!rm CA_monthly.dta
!rm CA_commconsbeg.dta
!rm CA_commconsend.dta 
!rm CA_cars.dta
!rm CA_business.dta
!rm CA_stocks.dta
!rm CA_misc.dta
!rm CA_heloc.dta
!rm CA_taxes.dta
!rm CA_finfrag.dta
!rm CA_creditpuzz.dta
!rm CA_retirees.dta
///////////////////////////////////////////////////////////////////////////////
