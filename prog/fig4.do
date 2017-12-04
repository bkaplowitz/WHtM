// fig 4
///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_89_10_cleaned.dta, clear

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

gen has_house = housecl == 1

replace houseneg = -housepos if housepos < 0
replace housepos = 0 if housepos < 0

gen ltv = houseneg/housepos

gen binnum = 1 if ltv > 0 & ltv <= .1
replace binnum = 2 if ltv >.1 & ltv <= .2
replace binnum = 3 if ltv >.2 & ltv <= .3
replace binnum = 4 if ltv >.3 & ltv <= .4
replace binnum = 5 if ltv >.4 & ltv <= .5
replace binnum = 6 if ltv >.5 & ltv <= .6
replace binnum = 7 if ltv >.6 & ltv <= .7
replace binnum = 8 if ltv >.7 & ltv <= .8
replace binnum = 9 if ltv >.8 & ltv <= .9
replace binnum = 10 if ltv >.9 & ltv <= 1
replace binnum = 11 if ltv >1
replace binnum = 0 if ltv == 0

label define binl 0 "=0" 1 "0-.1" 2 ".1-.2" 3 ".2-.3" 4 ".3-.4" 5 ".4-.5" 6 ".5-.6" 7 ".6-.7" 8 ".7-.8" 9 ".8-.9" 10 ".9-1" 11 ">1"
label values binnum binl 

keep if has_house == 1
collapse Wh2m Ph2m Nh2m h2m [aw=wgt], by(binnum im0100)

reshape wide Wh2m Ph2m Nh2m h2m, i(binnum) j(im0100)

local vars "Wh2m Ph2m Nh2m h2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}


cd ${rawdir}/output

graph bar Wh2m Ph2m, stack over(binnum,label(labsize(small))) bar(1, color(blue*1)) ///
bar(2, color(red*.75)) ysc(r(0(.1).7)) ylab(0(.1).7,grid) ///
legend(ring(0) pos(12)  label(1 "W-HtM") label(2 "P-HtM") ) ///
ytitle("Share of HtM among Homeowners") title("Leverage Ratio", pos(6) size(medsmall)) ///
name(fig4) 

graph export fig4.eps, replace
window manage close graph "fig4"

