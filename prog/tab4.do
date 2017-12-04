// Table 4 transition matrix
///////////////////////////////////////////////////////////////////////////////
// baseline
//////////////////////////////////////////////////////////////////////////////
cd $USdir/cleandata
use SCF_panel_07_09_cleaned.dta, clear
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

// keep id, weights, and htm status
keep Y1 YY1 wgt year Wh2m Ph2m Nh2m age labinc labearn1 selfearn1 labearn2 selfearn2

// reshapes to wide
reshape wide Wh2m Ph2m Nh2m age labinc labearn1 selfearn1 labearn2 selfearn2 wgt, i(Y1) j(year)

// restrictions on 2007 people
keep if age2007>=22 & age2007<=79
drop if labinc2007<0
// drop if have only self employment income
drop if (labearn12007 == 0 & selfearn12007>0) | (labearn22007 == 0 &  selfearn22007>0)

// generates indicator variable for each of the 9 possible transitions
gen W_W = (Wh2m2007 == 1 & Wh2m2009 == 1)
gen W_P = (Wh2m2007 == 1 & Ph2m2009 == 1)
gen W_N = (Wh2m2007 == 1 & Nh2m2009 == 1)
gen P_W = (Ph2m2007 == 1 & Wh2m2009 == 1)
gen P_P = (Ph2m2007 == 1 & Ph2m2009 == 1)
gen P_N = (Ph2m2007 == 1 & Nh2m2009 == 1)
gen N_W = (Nh2m2007 == 1 & Wh2m2009 == 1)
gen N_P = (Nh2m2007 == 1 & Ph2m2009 == 1)
gen N_N = (Nh2m2007 == 1 & Nh2m2009 == 1)

gen W_M = (Wh2m2007 == 1 & Wh2m2009 == .)
gen P_M = (Ph2m2007 == 1 & Wh2m2009 == .)
gen N_M = (Nh2m2007 == 1 & Wh2m2009 == .)

rename wgt2007 wgt
rename Y1 y1

keep W_W W_P W_N P_W P_P P_N N_W N_P N_N W_M P_M N_M y1 wgt

tostring y1, generate(str_Y1)
gen im0100 = substr(str_Y1,-1,.)
destring im0100, replace


// counts the households in each category
collapse (sum) W_W W_P W_N P_W P_P P_N N_W N_P N_N W_M P_M N_M [aw=wgt], by(im0100)
gen i = 1
reshape wide W_W W_P W_N P_W P_P P_N N_W N_P N_N W_M P_M N_M, i(i) j(im0100)

// replaces the counts by conditional probabilities
foreach m of numlist 1/5{
gen pr_W_W`m' = W_W`m'/(W_W`m' + W_P`m' + W_N`m' + W_M`m')
gen pr_W_P`m' = W_P`m'/(W_W`m' + W_P`m' + W_N`m' + W_M`m')
gen pr_W_N`m' = W_N`m'/(W_W`m' + W_P`m' + W_N`m' + W_M`m')
gen pr_W_M`m' = W_M`m'/(W_W`m' + W_P`m' + W_N`m' + W_M`m')
gen pr_P_W`m' = P_W`m'/(P_W`m' + P_P`m' + P_N`m' + P_M`m')
gen pr_P_P`m' = P_P`m'/(P_W`m' + P_P`m' + P_N`m' + P_M`m')
gen pr_P_N`m' = P_N`m'/(P_W`m' + P_P`m' + P_N`m' + P_M`m')
gen pr_P_M`m' = P_M`m'/(P_W`m' + P_P`m' + P_N`m' + P_M`m')
gen pr_N_W`m' = N_W`m'/(N_W`m' + N_P`m' + N_N`m' + N_M`m')
gen pr_N_P`m' = N_P`m'/(N_W`m' + N_P`m' + N_N`m' + N_M`m')
gen pr_N_N`m' = N_N`m'/(N_W`m' + N_P`m' + N_N`m' + N_M`m')
gen pr_N_M`m' = N_M`m'/(N_W`m' + N_P`m' + N_N`m' + N_M`m')

}
keep pr_*

// averages over the multiple imputations
local vars "pr_W_W pr_W_P pr_W_N pr_W_M pr_P_W pr_P_P pr_P_N pr_P_M pr_N_W pr_N_P pr_N_N pr_N_M"
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}

//reshapes to a transition matrix
gen i = 1
reshape long pr_W_ pr_P_ pr_N_, i(i) s
rename pr_W_ W
rename pr_P_ P
rename pr_N_ N

drop i _j

xpose, clear v

rename v1 M
rename v2 N
rename v3 P
rename v4 W

gen i = 1 if _varname == "P"
replace i = 2 if _varname == "W"
replace i = 3 if _varname == "N"
replace i = 4 if _varname == "M"
sort i
drop i
order _varname P W N M

// drops missing categories and rescales by the sum of the rows
drop M
gen foo = P + W + N
replace P = P/foo
replace N = N/foo
replace W = W/foodrop foo

// puts the transition matrix into mata and gets the ergodic distributionputmata A=(P W N)
mata
eigensystem(A',X=.,L=.)
B = X[.,1]/sum(X[.,1])
C = Re(B)endsave foo.dta, replace
clear
getmata Cxpose, clear v

rename v1 P
rename v2 W
rename v3 N

append using foo.dta
!rm foo.dta

// texs up the table
replace _varname = "Ergodic" if _varname == "C"
gen i = 1 if _varname == "P"
replace i = 2 if _varname == "W"
replace i = 3 if _varname == "N"
replace i = 4 if _varname == "Ergodic"

sort i
drop i

format P W N %9.3frename N foo
gen N = "0" + string(round(foo,.001)) + " \\"drop foocd ${rawdir}/outputoutsheet _varname P W N ///
using tab4.tex, delim("&") nonames nolabel noquote replace
