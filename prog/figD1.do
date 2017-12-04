// fig D1a
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

collapse (median) labinc [aw=wgt], by(agedum h2m_status im0100)
reshape wide labinc, i(agedum h2m_status) j(im0100)

local vars "labinc"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape wide labinc, i(agedum) j(h2m_status)
rename labinc1 Wh2m
rename labinc2 Ph2m
rename labinc3 Nh2m

cd ${rawdir}/output
line Wh2m Ph2m Nh2m agedum, clcolor(blue red*.75 dkgreen) ylabel(#5, grid) xlabel(,grid) ///
lpattern(dash_dot dash solid) xlabel(1(1)12, valuelabel) xtitle("Age") ///
legend(off) lwidth(thick thick thick)
//title("agedum profile of median income")
graph export figD1a.eps, replace
///////////////////////////////////////////////////////////////////////////////

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

collapse (median) labinc [aw=fwgt], by(agedum h2m_status)

replace labinc = labinc*(116.5/104.7)

reshape wide labinc, i(agedum) j(h2m_status)
rename labinc1 Wh2m
rename labinc2 Ph2m
rename labinc3 Nh2m

cd ${rawdir}/output
line Wh2m Ph2m Nh2m agedum, clcolor(blue red*.75 dkgreen) ylabel(#5, grid) xlabel(,grid) ///
lpattern(dash_dot dash solid) xlabel(1(1)12, valuelabel) xtitle("Age") ///
legend(off) lwidth(thick thick thick)
//title("agedum profile of median income")
graph export figD1b.eps, replace



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
collapse (median) labinc [aw=fwgt], by(agedum h2m_status)

reshape wide labinc, i(agedum) j(h2m_status)
rename labinc1 Wh2m
rename labinc2 Ph2m
rename labinc3 Nh2m

cd ${rawdir}/output
line Wh2m Ph2m Nh2m agedum, clcolor(blue red*.75 dkgreen) ysc(r(0(25000)100000)) ylabel(0(25000)100000,grid) xlabel(,grid) ///
lpattern(dash_dot dash solid) xlabel(1(1)12, valuelabel) xtitle("Age") ///
legend(off) lwidth(thick thick thick)
//title("agedum profile of median income")
graph export figD1c.eps, replace


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
collapse (median) labinc [aw=fwgt], by(agedum h2m_status)

reshape wide labinc, i(agedum) j(h2m_status)
rename labinc1 Wh2m
rename labinc2 Ph2m
rename labinc3 Nh2m

cd ${rawdir}/output
line Wh2m Ph2m Nh2m agedum, clcolor(blue red*.75 dkgreen) ylabel(#5, grid) xlabel(,grid) ///
lpattern(dash_dot dash solid) xlabel(5(1)16, valuelabel) xtitle("Age") ///
legend(off) lwidth(thick thick thick)
//title("agedum profile of median income")
graph export figD1d.eps, replace

//fig 10e-h
///////////////////////////////////////////////////////////////////////////////
// EU
local countries "DE FR IT ES"

foreach c of local countries {

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

collapse (median) labinc [aw=fwgt], by(agedum h2m_status im0100)
reshape wide labinc, i(agedum h2m_status) j(im0100)

local vars "labinc"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

reshape wide labinc, i(agedum) j(h2m_status)
rename labinc1 Wh2m
rename labinc2 Ph2m
rename labinc3 Nh2m

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
line Wh2m Ph2m Nh2m agedum, clcolor(blue red*.75 dkgreen) ysc(r(0 60000)) ylabel(#5, grid) xlabel(,grid) ///
lpattern(dash_dot dash solid) xlabel(1(1)12, valuelabel) xtitle("Age") ///
legend(off) lwidth(thick thick thick)

//title("agedum profile of median income")
graph export figD1`p'.eps, replace
}
///////////////////////////////////////////////////////////////////////////////
