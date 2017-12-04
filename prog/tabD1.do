
// pulls in country survey data, generates relevant variables, 
// collapses, saves as a temp file
///////////////////////////////////////////////////////////////////////////////
// US
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

keep if year == 2010
gen liqincratio = liqvar/monthlabinc
gen neg_liq = (liqvar < 0)
gen neg_illiq = (illiqvar < 0)
gen housefrac = nethouse/illiqvar
gen retirefrac = retacc/illiqvar
gen pos_house = (nethouse > 0)
gen pos_stocksbonds = (stocks + bond > 0)
gen pos_retire = (retacc > 0)

_pctile retirefrac [aw = wgt], p(0.1 99.9)
replace retirefrac = . if retirefrac>= r(r2)
replace retirefrac = . if retirefrac<= r(r1)
_pctile housefrac [aw = wgt], p(0.1 99.9)
replace housefrac = . if housefrac>= r(r2)
replace housefrac = . if housefrac<= r(r1)
_pctile liqincratio [aw = wgt], p(0.1 99.9)
replace liqincratio = . if liqincratio>= r(r2)
replace liqincratio = . if liqincratio<= r(r1)

collapse (mean) avgliqincratio=liqincratio (p10) p10liqincratio=liqincratio  ///
(p25) p25liqincratio=liqincratio  (p50) p50liqincratio=liqincratio  ///
(p75) p75liqincratio=liqincratio  (p90) p90liqincratio=liqincratio  ///
(mean) avghousefrac=housefrac (p10) p10housefrac=housefrac  ///
(p25) p25housefrac=housefrac  (p50) p50housefrac=housefrac  ///
(p75) p75housefrac=housefrac  (p90) p90housefrac=housefrac  ///
(mean) avgretirefrac=retirefrac (p10) p10retirefrac=retirefrac  ///
(p25) p25retirefrac=retirefrac  (p50) p50retirefrac=retirefrac  ///
(p75) p75retirefrac=retirefrac  (p90) p90retirefrac=retirefrac  ///
(mean) neg_liq (mean) pos_house (mean) pos_retire (mean) neg_illiq [aw=wgt], by(h2m_status im0100)

reshape wide avgliqincratio p10liqincratio p25liqincratio p50liqincratio ///
p75liqincratio p90liqincratio avghousefrac p10housefrac p25housefrac /// 
p50housefrac p75housefrac p90housefrac avgretirefrac p10retirefrac p25retirefrac ///
p50retirefrac p75retirefrac p90retirefrac neg_liq pos_house pos_retire neg_illiq, i(h2m_status) j(im0100)

local vars "avgliqincratio p10liqincratio p25liqincratio p50liqincratio p75liqincratio p90liqincratio avghousefrac p10housefrac p25housefrac p50housefrac p75housefrac p90housefrac avgretirefrac p10retirefrac p25retirefrac p50retirefrac p75retirefrac p90retirefrac neg_liq pos_house pos_retire neg_illiq"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

do ${progdir}/sub_tabD1.do
save ${progdir}/US.dta, replace
///////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////
// CA
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

gen housefrac = nethouse/illiqvar
gen retirefrac = retacc/illiqvar
rename fwgt wgt
gen liqincratio = liqvar/monthlabinc
gen neg_liq = (liqvar < 0)
gen neg_illiq = (illiqvar < 0)
gen pos_house = (nethouse > 0)
gen pos_stocksbonds = (stocks + bond > 0)
gen pos_retire = (retacc > 0)

_pctile retirefrac [aw = wgt], p(0.1 99.9)
replace retirefrac = . if retirefrac>= r(r2)
replace retirefrac = . if retirefrac<= r(r1)
_pctile housefrac [aw = wgt], p(0.1 99.9)
replace housefrac = . if housefrac>= r(r2)
replace housefrac = . if housefrac<= r(r1)
_pctile liqincratio [aw = wgt], p(0.1 99.9)
replace liqincratio = . if liqincratio>= r(r2)
replace liqincratio = . if liqincratio<= r(r1)

collapse (mean) avgliqincratio=liqincratio (p10) p10liqincratio=liqincratio  ///
(p25) p25liqincratio=liqincratio  (p50) p50liqincratio=liqincratio  ///
(p75) p75liqincratio=liqincratio  (p90) p90liqincratio=liqincratio  ///
(mean) avghousefrac=housefrac (p10) p10housefrac=housefrac  ///
(p25) p25housefrac=housefrac  (p50) p50housefrac=housefrac  ///
(p75) p75housefrac=housefrac  (p90) p90housefrac=housefrac  ///
(mean) avgretirefrac=retirefrac (p10) p10retirefrac=retirefrac  ///
(p25) p25retirefrac=retirefrac  (p50) p50retirefrac=retirefrac  ///
(p75) p75retirefrac=retirefrac  (p90) p90retirefrac=retirefrac  ///
(mean) neg_liq (mean) pos_house (mean) pos_retire (mean) neg_illiq [aw=wgt], by(h2m_status)
do ${progdir}/sub_tabD1.do
save ${progdir}/CA.dta, replace
///////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////
// AU
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
gen housefrac = nethouse/illiqvar
gen retirefrac = retacc/illiqvar
rename fwgt wgt
gen liqincratio = liqvar/monthlabinc
gen neg_liq = (liqvar < 0)
gen neg_illiq = (illiqvar < 0)
gen pos_house = (nethouse > 0)
gen pos_stocksbonds = (stocks + bond > 0)
gen pos_retire = (retacc > 0)

_pctile retirefrac [aw = wgt], p(0.1 99.9)
replace retirefrac = . if retirefrac>= r(r2)
replace retirefrac = . if retirefrac<= r(r1)
_pctile housefrac [aw = wgt], p(0.1 99.9)
replace housefrac = . if housefrac>= r(r2)
replace housefrac = . if housefrac<= r(r1)
_pctile liqincratio [aw = wgt], p(0.1 99.9)
replace liqincratio = . if liqincratio>= r(r2)
replace liqincratio = . if liqincratio<= r(r1)

collapse (mean) avgliqincratio=liqincratio (p10) p10liqincratio=liqincratio  ///
(p25) p25liqincratio=liqincratio  (p50) p50liqincratio=liqincratio  ///
(p75) p75liqincratio=liqincratio  (p90) p90liqincratio=liqincratio  ///
(mean) avghousefrac=housefrac (p10) p10housefrac=housefrac  ///
(p25) p25housefrac=housefrac  (p50) p50housefrac=housefrac  ///
(p75) p75housefrac=housefrac  (p90) p90housefrac=housefrac  ///
(mean) avgretirefrac=retirefrac (p10) p10retirefrac=retirefrac  ///
(p25) p25retirefrac=retirefrac  (p50) p50retirefrac=retirefrac  ///
(p75) p75retirefrac=retirefrac  (p90) p90retirefrac=retirefrac  ///
(mean) neg_liq (mean) pos_house (mean) pos_retire (mean) neg_illiq [aw=wgt], by(h2m_status)
do ${progdir}/sub_tabD1.do
save ${progdir}/AU.dta, replace
///////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////
// UK
///////////////////////////////////////////////////////////////////////////////
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
gen housefrac = nethouse/illiqvar
gen retirefrac = retacc/illiqvar
rename fwgt wgt
gen liqincratio = liqvar/monthlabinc
gen neg_liq = (liqvar < 0)
gen neg_illiq = (illiqvar < 0)
gen pos_house = (nethouse > 0)
gen pos_stocksbonds = (stocks + bond > 0)
gen pos_retire = (retacc > 0)

_pctile retirefrac [aw = wgt], p(0.1 99.9)
replace retirefrac = . if retirefrac>= r(r2)
replace retirefrac = . if retirefrac<= r(r1)
_pctile housefrac [aw = wgt], p(0.1 99.9)
replace housefrac = . if housefrac>= r(r2)
replace housefrac = . if housefrac<= r(r1)
_pctile liqincratio [aw = wgt], p(0.1 99.9)
replace liqincratio = . if liqincratio>= r(r2)
replace liqincratio = . if liqincratio<= r(r1)


collapse (mean) avgliqincratio=liqincratio (p10) p10liqincratio=liqincratio  ///
(p25) p25liqincratio=liqincratio  (p50) p50liqincratio=liqincratio  ///
(p75) p75liqincratio=liqincratio  (p90) p90liqincratio=liqincratio  ///
(mean) avghousefrac=housefrac (p10) p10housefrac=housefrac  ///
(p25) p25housefrac=housefrac  (p50) p50housefrac=housefrac  ///
(p75) p75housefrac=housefrac  (p90) p90housefrac=housefrac  ///
(mean) avgretirefrac=retirefrac (p10) p10retirefrac=retirefrac  ///
(p25) p25retirefrac=retirefrac  (p50) p50retirefrac=retirefrac  ///
(p75) p75retirefrac=retirefrac  (p90) p90retirefrac=retirefrac  ///
(mean) neg_liq (mean) pos_house (mean) pos_retire (mean) neg_illiq [aw=wgt], by(h2m_status)
do ${progdir}/sub_tabD1.do
save ${progdir}/UK.dta, replace
///////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////
// EU
local countries "DE FR IT ES"
foreach c of local countries {
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

keep if sa0100 == "`c'"

gen housefrac = nethouse/illiqvar
gen retirefrac = retacc/illiqvar
rename fwgt wgt
gen liqincratio = liqvar/monthlabinc
gen neg_liq = (liqvar < 0)
gen neg_illiq = (illiqvar < 0)
gen pos_house = (nethouse > 0)
gen pos_stocksbonds = (stocks + bond > 0)
gen pos_retire = (retacc > 0)

_pctile retirefrac [aw = wgt], p(0.1 99.9)
replace retirefrac = . if retirefrac>= r(r2)
replace retirefrac = . if retirefrac<= r(r1)
_pctile housefrac [aw = wgt], p(0.1 99.9)
replace housefrac = . if housefrac>= r(r2)
replace housefrac = . if housefrac<= r(r1)
_pctile liqincratio [aw = wgt], p(0.1 99.9)
replace liqincratio = . if liqincratio>= r(r2)
replace liqincratio = . if liqincratio<= r(r1)

collapse (mean) avgliqincratio=liqincratio (p10) p10liqincratio=liqincratio  ///
(p25) p25liqincratio=liqincratio  (p50) p50liqincratio=liqincratio  ///
(p75) p75liqincratio=liqincratio  (p90) p90liqincratio=liqincratio  ///
(mean) avghousefrac=housefrac (p10) p10housefrac=housefrac  ///
(p25) p25housefrac=housefrac  (p50) p50housefrac=housefrac  ///
(p75) p75housefrac=housefrac  (p90) p90housefrac=housefrac  ///
(mean) avgretirefrac=retirefrac (p10) p10retirefrac=retirefrac  ///
(p25) p25retirefrac=retirefrac  (p50) p50retirefrac=retirefrac  ///
(p75) p75retirefrac=retirefrac  (p90) p90retirefrac=retirefrac  ///
(mean) neg_liq (mean) pos_house (mean) pos_retire (mean) neg_illiq [aw=wgt], by(h2m_status im0100)

local vars "avgliqincratio p10liqincratio p25liqincratio p50liqincratio p75liqincratio p90liqincratio avghousefrac p10housefrac p25housefrac p50housefrac p75housefrac p90housefrac avgretirefrac p10retirefrac p25retirefrac p50retirefrac p75retirefrac p90retirefrac neg_liq pos_house pos_retire neg_illiq"

// averages over imputations
reshape wide `vars', i(h2m_status) j(im0100)
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

do ${progdir}/sub_tabD1.do
save ${progdir}/`c'.dta, replace

}
///////////////////////////////////////////////////////////////////////////////




///////////////////////////////////////////////////////////////////////////////
// tex up the table
cd ${progdir}
// splits the data up into the three subtables
local tabvars "Wh2m Ph2m Nh2m"
local countries "US CA AU UK DE FR IT ES"
foreach v of local tabvars{
foreach c of local countries{
use `c'.dta, clear
keep varname `v'
rename `v' `c'
replace `c' = "`c'" if varname == " "
save `c'_`v'.dta, replace
}

clear
use US_`v'.dta, clear
merge 1:1 varname using CA_`v'.dta, nogen
merge 1:1 varname using AU_`v'.dta, nogen
merge 1:1 varname using UK_`v'.dta, nogen
merge 1:1 varname using DE_`v'.dta, nogen
merge 1:1 varname using FR_`v'.dta, nogen
merge 1:1 varname using IT_`v'.dta, nogen
merge 1:1 varname using ES_`v'.dta, nogen

gen i = 1 if varname == "Liquid wealth / monthly income: p10"
replace i = 2 if varname == "Liquid wealth / monthly income: p25"
replace i = 3 if varname == "Liquid wealth / monthly income: p50"
replace i = 4 if varname == "Liquid wealth / monthly income: p75"
replace i = 5 if varname == "Liquid wealth / monthly income: p90"
replace i = 6 if varname == "Liquid wealth / monthly income: mean"
replace i = 7 if varname == "Fraction with negative liquid wealth"
replace i = 8 if varname == "Housing fraction of illquid wealth: p10"
replace i = 9 if varname == "Housing fraction of illquid wealth: p25"
replace i = 10 if varname == "Housing fraction of illquid wealth: p50"
replace i = 11 if varname == "Housing fraction of illquid wealth: p75"
replace i = 12 if varname == "Housing fraction of illquid wealth: p90"
replace i = 13 if varname == "Housing fraction of illquid wealth: mean"
replace i = 14 if varname == "Fraction with positive equity in housing"
replace i = 15 if varname == "Retirement fraction of illquid wealth: p10"
replace i = 16 if varname == "Retirement fraction of illquid wealth: p25"
replace i = 17 if varname == "Retirement fraction of illquid wealth: p50"
replace i = 18 if varname == "Retirement fraction of illquid wealth: p75"
replace i = 19 if varname == "Retirement fraction of illquid wealth: p90"
replace i = 20 if varname == "Retirement fraction of illquid wealth: mean"
replace i = 21 if varname == "Fraction with positive retirement"
replace i = 22 if varname == "Fraction with negative illiquid wealth"
replace i = 0 if varname == " "

replace varname = substr(varname, -3, .) if (i >=2 & i <=5) | (i >=9 & i <=12) | (i >=16 & i <=19)
replace varname = substr(varname, -4, .) if i == 6 | i == 13 | i == 20 

replace varname = "Median liquid wealth / income" if i == 3
replace varname = "Median housing / illiquid wealth" if i == 10
replace varname = "Median retire / illiquid wealth" if i == 17
replace varname = "Mean liquid wealth / income" if i == 6
replace varname = "Mean housing / illiquid wealth" if i == 13
replace varname = "Mean retire / illiquid wealth" if i == 20
replace varname = "Frac. neg. liquid wealth" if i == 7
replace varname = "Frac. pos. housing equity" if i == 14
replace varname = "Frac. pos. retirement account" if i == 21
replace varname = "Frac. neg. illiquid wealth" if i == 22
drop if varname == "p10" | varname == "p25" | varname == "p75" | varname == "p90" | i == 1 | i == 8 | i == 15

replace i = 8 if i == 22

replace ES = ES + " \\"
replace ES = ES + " \hline" if i == 0 | i == 8 | i == 14 | i == 21

gen name = "`v'"
drop if name == "Ph2m" & (i == 10 | i == 13 | i == 14 | i == 17 | i == 20 | i == 21)

sort i
drop name
drop i

outsheet varname US CA AU UK DE FR IT ES ///
using ${rawdir}/output/tabD1_panel`v'.tex, delim("&") nonames nolabel noquote replace

}

!rm US*
!rm CA*
!rm AU*
!rm UK*
!rm DE*
!rm FR*
!rm IT*
!rm ES*


///////////////////////////////////////////////////////////////////////////////
