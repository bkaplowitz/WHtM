// fig 9
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

gen othernetbrlilliqnc = netbrilliqnc - nethouse
gen Wh2m_onlyret = (Wh2m == 1 & nethouse == 0 & othernetbrlilliqnc > 0)
gen Wh2m_onlyhouse = (Wh2m == 1 & nethouse != 0 & othernetbrlilliqnc == 0)
gen Wh2m_both = (Wh2m == 1 & nethouse != 0 & othernetbrlilliqnc > 0)

collapse (mean) Wh2m_onlyret (mean) Wh2m_onlyhouse (mean) Wh2m_both Ph2m (mean) Wh2m [aw=wgt], by(year im0100)
reshape wide Wh2m_onlyret Wh2m_onlyhouse Wh2m_both Wh2m Ph2m, i(year) j(im0100)

local vars "Wh2m_onlyret Wh2m_onlyhouse Wh2m_both Wh2m Ph2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
drop year

gen country = "US"
save ${progdir}/US.dta, replace

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

gen othernetbrlilliqnc = netbrilliqnc - nethouse
gen Wh2m_onlyret = (Wh2m == 1 & nethouse == 0 & othernetbrlilliqnc > 0)
gen Wh2m_onlyhouse = (Wh2m == 1 & nethouse != 0 & othernetbrlilliqnc == 0)
gen Wh2m_both = (Wh2m == 1 & nethouse != 0 & othernetbrlilliqnc > 0)


collapse (mean) Wh2m_onlyret (mean) Wh2m_onlyhouse (mean) Wh2m_both Ph2m (mean) Wh2m [aw=fwgt]
gen country = "UK"
save ${progdir}/UK.dta, replace


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

gen othernetbrlilliqnc = netbrilliqnc - nethouse
gen Wh2m_onlyret = (Wh2m == 1 & nethouse == 0 & othernetbrlilliqnc > 0)
gen Wh2m_onlyhouse = (Wh2m == 1 & nethouse != 0 & othernetbrlilliqnc == 0)
gen Wh2m_both = (Wh2m == 1 & nethouse != 0 & othernetbrlilliqnc > 0)

collapse (mean) Wh2m_onlyret (mean) Wh2m_onlyhouse (mean) Wh2m_both Ph2m (mean) Wh2m [aw=fwgt]
gen country = "CA"
save ${progdir}/CA.dta, replace


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

gen othernetbrlilliqnc = netbrilliqnc - nethouse
gen Wh2m_onlyret = (Wh2m == 1 & nethouse == 0 & othernetbrlilliqnc > 0)
gen Wh2m_onlyhouse = (Wh2m == 1 & nethouse != 0 & othernetbrlilliqnc == 0)
gen Wh2m_both = (Wh2m == 1 & nethouse != 0 & othernetbrlilliqnc > 0)


collapse (mean) Wh2m_onlyret (mean) Wh2m_onlyhouse (mean) Wh2m_both (mean) Ph2m (mean) Wh2m [aw=fwgt]
gen country = "AU"
save ${progdir}/AU.dta, replace



///////////////////////////////////////////////////////////////////////////////
// EU
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
gen othernetbrlilliqnc = netbrilliqnc - nethouse
gen Wh2m_onlyret = (Wh2m == 1 & nethouse == 0 & othernetbrlilliqnc > 0)
gen Wh2m_onlyhouse = (Wh2m == 1 & nethouse != 0 & othernetbrlilliqnc == 0)
gen Wh2m_both = (Wh2m == 1 & nethouse != 0 & othernetbrlilliqnc > 0)


collapse (mean) Wh2m_onlyret (mean) Wh2m_onlyhouse (mean) Wh2m_both Ph2m (mean) Wh2m [aw=fwgt], by(sa0100 im0100)
reshape wide Wh2m_onlyret Wh2m_onlyhouse Wh2m_both Wh2m Ph2m, i(sa0100) j(im0100)

local vars "Wh2m_onlyret Wh2m_onlyhouse Wh2m_both Wh2m Ph2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
rename sa0100 country
save ${progdir}/EU.dta, replace
///////////////////////////////////////////////////////////////////////////////

// appends all the data together
///////////////////////////////////////////////////////////////////////////////
cd ${progdir}
use US.dta, clear
append using CA.dta
append using AU.dta
append using UK.dta
append using EU.dta
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
cd $figdir
gen order = 1 if country == "US"
replace order = 2 if country == "CA"
replace order = 3 if country == "AU"
replace order = 4 if country == "UK"
replace order = 5 if country == "DE"
replace order = 6 if country == "FR"
replace order = 7 if country == "IT"
replace order = 8 if country == "ES"

gen order1 = 1 if country == "DE"
replace order1 = 2 if country == "FR"
replace order1 = 3 if country == "IT"
replace order1 = 4 if country == "ES"
replace order1 = 5 if country == "AT"
replace order1 = 6 if country == "BE"
replace order1 = 7 if country == "FI"
replace order1 = 8 if country == "GR"
replace order1 = 9 if country == "NL"
replace order1 = 10 if country == "PT"

cd ${rawdir}/output

graph bar Wh2m Ph2m if order <= 8, over(country, sort(order)) stack bar(1, color(blue)) bar(2, color(red*.75)) ///
legend(ring(0) pos(12)  label(1 "W-HtM") label(2 "P-HtM") ) ysc(r(0 .5)) ylabel(#5) name(fig9a)
//title("Fraction HtM by country: 1 month credit limit")
graph export fig9a.eps, replace
window manage close graph "fig9a"

graph bar Wh2m_onlyret Wh2m_onlyhouse Wh2m_both if order <= 8, over(country, sort(order)) ///
stack bar(1, color(blue*1)) bar(2, color(red*.75)) bar(3, color(dkgreen*1)) name(fig9b) ///
legend(cols(1) ring(0) pos(12) label(1 "Other illiquid but no housing wealth") ///
label(2 "Only housing wealth") label(3 "Both other and housing wealth")) ysc(r(0 .5)) ylabel(#5) 
graph export fig9b.eps, replace
window manage close graph "fig9b"
///////////////////////////////////////////////////////////////////////////////
cd ${progdir}
//cleanup
!rm US.dta
!rm AU.dta
!rm CA.dta
!rm UK.dta
!rm EU.dta
