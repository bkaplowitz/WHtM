// fig 3a
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

// collapses means over year and imputation
collapse (mean) h2m (mean) Wh2m (mean) Ph2m (mean) Nh2m [aw=wgt], by(year im0100)
reshape wide h2m Wh2m Ph2m Nh2m, i(year) j(im0100)

// averages over imputations
local vars "h2m Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

cd ${rawdir}/output

graph bar Wh2m Ph2m, over(year) stack bar(1, color(blue*1)) bar(2, color(red*.75)) ///
legend(ring(0) pos(12)  label(1 "W-HtM") label(2 "P-HtM") ) ysc(r(0 .5)) ylabel(#5) name(fig3a) 

graph export fig3a.eps, replace
window manage close graph "fig3a"
///////////////////////////////////////////////////////////////////////////////

// fig 3b
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

gen othernetbrlilliqnc = netbrilliqnc - nethouse
gen Wh2m_onlyret = (Wh2m == 1 & nethouse == 0 & othernetbrlilliqnc > 0)
gen Wh2m_onlyhouse = (Wh2m == 1 & nethouse != 0 & othernetbrlilliqnc == 0)
gen Wh2m_both = (Wh2m == 1 & nethouse != 0 & othernetbrlilliqnc > 0)

collapse (mean) Wh2m_onlyret (mean) Wh2m_onlyhouse (mean) Wh2m_both [aw=wgt], by(year im0100)
reshape wide Wh2m_onlyret Wh2m_onlyhouse Wh2m_both, i(year) j(im0100)

local vars "Wh2m_onlyret Wh2m_onlyhouse Wh2m_both"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

cd ${rawdir}/output

graph bar Wh2m_onlyret Wh2m_onlyhouse Wh2m_both, over(year) stack bar(1, color(blue*1)) ///
bar(2, color(red*.75)) bar(3, color(dkgreen*1)) ///
legend(cols(1) ring(0) pos(12) label(1 "Other illiquid but no housing wealth") ///
label(2 "Only housing wealth") label(3 "Both other and housing wealth")) ///
ysc(r(0 .5)) ylabel(#5) name(fig3b) 

graph export fig3b.eps, replace
window manage close graph "fig3b"
///////////////////////////////////////////////////////////////////////////////


