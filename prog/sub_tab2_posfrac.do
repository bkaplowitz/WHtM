// pulls in country survey data, generates relevant variables, 
// collapses, saves as a temp file
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

replace labincwork = (labincwork > 0)
replace networthnc = (networthnc > 0)
replace netbrliq = (netbrliq > 0)
replace liqpos = (liqpos > 0)
replace stocks = (stocks > 0)
replace bond = (bond > 0)
replace ccdebt = (ccdebt > 0)
replace netbrilliqnc = (netbrilliqnc > 0)
replace nethouse = (nethouse > 0)
replace retacc = (retacc > 0)
replace cashli = (cashli > 0)
replace certdep = (certdep > 0)
replace savbnd = (savbnd > 0)

gen fwgt = round(wgt,1)

collapse (mean) labincwork networthnc netbrliq liqpos stocks bond ccdebt ///
netbrilliqnc nethouse retacc cashli certdep savbnd [aw=fwgt], by(im0100)

local vars "labincwork networthnc netbrliq liqpos stocks bond ccdebt netbrilliqnc nethouse retacc cashli certdep savbnd"
gen i = 1
// averages over imputations
reshape wide `vars', i(i) j(im0100)
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
drop i
xpose, clear var
rename _varname varname
rename v1 overall
tostring overall, replace format("%9.3f") force
order varname, first
do ${progdir}/sub_tab2.do
save ${progdir}/US_posfrac.dta, replace
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

replace labincwork = (labincwork > 0)
replace networthnc = (networthnc > 0)
replace netbrliq = (netbrliq > 0)
replace liqpos = (liqpos > 0)
replace stocks = (stocks > 0)
replace bond = (bond > 0)
replace ccdebt = (ccdebt > 0)
replace netbrilliqnc = (netbrilliqnc > 0)
replace nethouse = (nethouse > 0)
replace retacc = (retacc > 0)
replace cashli = (cashli > 0)
replace certdep = (certdep > 0)
replace savbnd = (savbnd > 0)
collapse (mean) labincwork networthnc netbrliq liqpos stocks bond ccdebt ///
netbrilliqnc nethouse retacc cashli certdep savbnd [aw=fwgt]
xpose, clear var
rename _varname varname
rename v1 overall
tostring overall, replace format("%9.3f") force
order varname, first
do ${progdir}/sub_tab2.do
save ${progdir}/CA_posfrac.dta, replace
///////////////////////////////////////////////////////////////////////////////

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

replace labincwork = (labincwork > 0)
replace networthnc = (networthnc > 0)
replace netbrliq = (netbrliq > 0)
replace liqpos = (liqpos > 0)
replace stocks = (stocks > 0)
replace bond = (bond > 0)
replace ccdebt = (ccdebt > 0)
replace netbrilliqnc = (netbrilliqnc > 0)
replace nethouse = (nethouse > 0)
replace retacc = (retacc > 0)
replace cashli = (cashli > 0)
replace certdep = (certdep > 0)
replace savbnd = (savbnd > 0)
collapse (mean) labincwork networthnc netbrliq liqpos stocks bond ccdebt ///
netbrilliqnc nethouse retacc cashli certdep savbnd [aw=fwgt]
xpose, clear var
rename _varname varname
rename v1 overall
tostring overall, replace format("%9.3f") force
order varname, first
do ${progdir}/sub_tab2.do
save ${progdir}/AU_posfrac.dta, replace
///////////////////////////////////////////////////////////////////////////////

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

replace labincwork = (labincwork > 0)
replace networthnc = (networthnc > 0)
replace netbrliq = (netbrliq > 0)
replace liqpos = (liqpos > 0)
replace stocks = (stocks > 0)
replace bond = (bond > 0)
replace ccdebt = (ccdebt > 0)
replace netbrilliqnc = (netbrilliqnc > 0)
replace nethouse = (nethouse > 0)
replace retacc = (retacc > 0)
replace cashli = (cashli > 0)
replace certdep = (certdep > 0)
replace savbnd = (savbnd > 0)
collapse (mean) labincwork networthnc netbrliq liqpos stocks bond ccdebt ///
netbrilliqnc nethouse retacc cashli certdep savbnd [aw=fwgt]
xpose, clear var
rename _varname varname
rename v1 overall
tostring overall, replace format("%9.3f") force
order varname, first
do ${progdir}/sub_tab2.do
save ${progdir}/UK_posfrac.dta, replace
///////////////////////////////////////////////////////////////////////////////

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

replace labincwork = (labincwork > 0)
replace networthnc = (networthnc > 0)
replace netbrliq = (netbrliq > 0)
replace liqpos = (liqpos > 0)
replace stocks = (stocks > 0)
replace bond = (bond > 0)
replace ccdebt = (ccdebt > 0)
replace netbrilliqnc = (netbrilliqnc > 0)
replace nethouse = (nethouse > 0)
replace retacc = (retacc > 0)
replace cashli = (cashli > 0)
replace certdep = (certdep > 0)
replace savbnd = (savbnd > 0)
keep if sa0100 == "`c'"
collapse (mean) labincwork networthnc netbrliq liqpos stocks bond ccdebt ///
netbrilliqnc nethouse retacc cashli certdep savbnd [aw=fwgt], by(im0100)

local vars "labincwork networthnc netbrliq liqpos stocks bond ccdebt netbrilliqnc nethouse retacc cashli certdep savbnd"
gen i = 1
// averages over imputations
reshape wide `vars', i(i) j(im0100)
foreach k of local vars {
gen `k' = (`k'1 + `k'2 + `k'3 +`k'4 + `k'5)/5   
drop `k'1 `k'2 `k'3 `k'4 `k'5
}
drop i

xpose, clear var
rename _varname varname
rename v1 overall
tostring overall, replace format("%9.3f") force
order varname, first

// renames some of the variables
do ${progdir}/sub_tab2.do
save ${progdir}/`c'_posfrac.dta, replace


}
///////////////////////////////////////////////////////////////////////////////
