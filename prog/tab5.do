// generates alternative measures for all countries. each country in its own
// subroutine that creates all of the numbers, then organizes it into a table

///////////////////////////////////////////////////////////////////////////////
do ${progdir}/sub_tab5_US.do
do ${progdir}/sub_tab5_CA.do
do ${progdir}/sub_tab5_AU.do
do ${progdir}/sub_tab5_UK.do
do ${progdir}/sub_tab5_EU.do
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// tex up the table
clear
cd ${progdir}

// splits the data up into the three subtables
local tabvars "Wh2m Ph2m"
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

replace varname = "In past year, c $>$ y" if varname == "HtM5"
replace varname = "Comm. cons. - beg. of period" if varname == "Comm. cons. - beg."
replace varname = "Comm. cons. - end of period" if varname == "Comm. cons. - end"
replace varname = "Vehicles as illiquid assets" if varname == "Cars as illiquid assets"


gen i = 1 if varname == "Baseline"
replace i = 2 if varname == "In past year, c $>$ y"
replace i = 3 if varname == "Financially fragile households"
replace i = 4 if varname == "1 year income credit limit"
replace i = 5 if varname == "Weekly pay period"
replace i = 6 if varname == "Monthly pay period"
replace i = 7 if varname == "Vehicles as illiquid assets"
replace i = 8 if varname == "Ret. acc. as liquid for 60+"
replace i = 9 if varname == "Businesses as illiquid assets"
replace i = 10 if varname == "Direct as illiquid assets"
replace i = 11 if varname == "Other valuables as illiquid assets"
replace i = 12 if varname == "Excludes cc puzzle households"
replace i = 13 if varname == "HELOCs as liquid debt"
replace i = 14 if varname == "Disposable income"
replace i = 15 if varname == "Comm. cons. - beg. of period"
replace i = 16 if varname == "Comm. cons. - end of period"
replace i = 0 if varname == " "
sort i

replace FR = "---" if varname == "Other valuables as illiquid assets"


replace ES = ES + " \\"
replace ES = ES + " \hline" if i == 0 | i == 3 | i == 4 | i == 6 | i == 11 | i == 13 | i == 14 | i == 16

drop i

outsheet varname US CA AU UK DE FR IT ES ///
using ${rawdir}/output/tab5_panel`v'.tex, delim("&") nonames nolabel noquote replace

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
