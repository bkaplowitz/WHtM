cd ${USdir}/rawdata
use SCF_panel_07_09.dta, clear

*-----------------
*DEFINITIONS
*-----------------
gen cashfrac    = 138/2500 //average cash holdings excluding large value holdings divided by median liquid assets in 2010
gen liqpos      = liq*(1+cashfrac) //adjusted by cash holdings
gen liqneg      = ccdebt
gen direct      = nmmf + stocks + bond
gen housepos    = houses + oresre + nnresre
gen houseneg    = mrthel + resdbt
gen nethouse    = housepos - houseneg
gen netcars     = vehic
gen sb          = savbnd
gen certdep     = cds
gen retacc      = retqliq
gen lifeins     = cashli
gen netbus      = bus

// baseline
gen brliqpos      = liqpos + direct
gen brliqneg      = ccdebt
gen netbrliq      = brliqpos - brliqneg
gen brilliqpos    = housepos + netcars + certdep + retacc + lifeins
gen brilliqneg    = houseneg
gen netbrilliq    = brilliqpos - brilliqneg
gen netbrilliqnc  = netbrilliq - netcars
gen networthnc  = netbrilliqnc + netbrliq

// adds cars as illiquid
gen netbrilliqcars = netbrilliqnc + netcars
gen networthcars = netbrilliqnc + netbrliq + netcars

// adds businesses as illiquid
gen netbrilliqbusnc = netbrilliqnc + netbus
gen networthbusnc  = netbrilliqbusnc + netbrliq

// adds other valuables as illiquid
gen netbrilliqncmisc = netbrilliqnc + misc_illiq
gen networthncmisc = networthnc + misc_illiq

// takes HELOCs out of illiquid debt and puts it in liquid debt
gen netbrliqheloc = netbrliq - heloc
gen netbrilliqncheloc = netbrilliqnc + heloc

// puts retirement accounts in liquid assets for retirees
gen netbrliq_retirees = netbrliq
replace netbrliq_retirees = netbrliq + retacc if age >= 60
gen netbrilliqnc_retirees = netbrilliqnc
replace netbrilliqnc_retirees = netbrilliqnc - retacc if age >= 60

// puts stocks into illiquid
gen netbrliqnstocks = netbrliq - direct
gen netbrilliqncstocks = netbrilliqnc + direct
////////////////////////////////////////////////////////////////////////////////

cd ${USdir}/cleandata

save SCF_panel_07_09_cleaned.dta, replace
