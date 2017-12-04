// fig 6
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
collapse (mean) h2m (mean) Wh2m (mean) Ph2m (mean) Nh2m [aw=wgt], by(age im0100)
reshape wide h2m Wh2m Ph2m Nh2m, i(age) j(im0100)

local vars "h2m Wh2m Ph2m Nh2m"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

cd ${rawdir}/output

line Wh2m Ph2m age, clcolor(blue red*.75 dkgreen) ysc(r(0 .4)) ylabel(, grid) xlabel(,grid) ///
name(fig6) legend(ring(0) pos(11) label(1 "W-HtM") label(2 "P-HtM") label(3 "N-HtM")) ///
lpattern(dash_dot dash solid) lwidth(thick thick thick) xtitle("Age")

graph export fig6.eps, replace
window manage close graph "fig6"
///////////////////////////////////////////////////////////////////////////////
