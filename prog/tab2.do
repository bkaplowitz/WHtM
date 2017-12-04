///////////////////////////////////////////////////////////////////////////////
cd ${progdir}
do sub_tab2_med.do
cd ${progdir}
do sub_tab2_posfrac.do
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// tex up the table
cd ${progdir}

// overall table
local countries "US CA AU UK DE FR IT ES"
foreach c of local countries{
use `c'_med.dta, clear
set obs 14
replace varname = " " if varname == ""
replace overall = "Median" if overall == ""
rename overall `c'_med
merge 1:1 varname using `c'_posfrac.dta
replace overall = "Frac. Pos." if overall == ""
rename overall `c'_posfrac
drop _merge
save `c'.dta, replace
}

clear
// panel 1
use US.dta, clear
merge 1:1 varname using CA.dta, nogen
merge 1:1 varname using AU.dta, nogen
merge 1:1 varname using UK.dta, nogen

gen i = 1 if varname == "Income (age 22-59)"
replace i = 2 if varname == "Net Worth"
replace i = 3 if varname == "Net liquid wealth"
replace i = 4 if varname == "Cash, checking, saving, MM accounts"
replace i = 5 if varname == "Directly held stocks"
replace i = 6 if varname == "Directly held bonds"
replace i = 7 if varname == "Revolving credit card debt"
replace i = 8 if varname == "Net illiquid wealth"
replace i = 9 if varname == "Housing net of mortgages"
replace i = 10 if varname == "Retirement accounts"
replace i = 11 if varname == "Life insurance"
replace i = 12 if varname == "Certificates of deposit"
replace i = 13 if varname == "Savings bonds"
replace i = 0 if varname == " "
drop if i >= 12

sort i

replace UK_posfrac = UK_posfrac + " \\"
replace UK_posfrac = UK_posfrac + " \hline" if i == 0 | i == 1 | i == 2 | i == 7 | i == 11
drop i

outsheet varname US_med US_posfrac CA_med CA_posfrac AU_med AU_posfrac UK_med UK_posfrac ///
using ${rawdir}/output/tab2_panel1.tex, delim("&") nonames nolabel noquote replace

// panel 2
use DE.dta, clear
merge 1:1 varname using FR.dta, nogen
merge 1:1 varname using IT.dta, nogen
merge 1:1 varname using ES.dta, nogen

gen i = 1 if varname == "Income (age 22-59)"
replace i = 2 if varname == "Net Worth"
replace i = 3 if varname == "Net liquid wealth"
replace i = 4 if varname == "Cash, checking, saving, MM accounts"
replace i = 5 if varname == "Directly held stocks"
replace i = 6 if varname == "Directly held bonds"
replace i = 7 if varname == "Revolving credit card debt"
replace i = 8 if varname == "Net illiquid wealth"
replace i = 9 if varname == "Housing net of mortgages"
replace i = 10 if varname == "Retirement accounts"
replace i = 11 if varname == "Life insurance"
replace i = 12 if varname == "Certificates of deposit"
replace i = 13 if varname == "Savings bonds"
replace i = 0 if varname == " "
drop if i >= 12

sort i

replace ES_posfrac = ES_posfrac + " \\"
replace ES_posfrac = ES_posfrac + " \hline" if i == 0 | i == 1 | i == 2 | i == 7 | i == 11
drop i

outsheet varname DE_med DE_posfrac FR_med FR_posfrac IT_med IT_posfrac ES_med ES_posfrac ///
using ${rawdir}/output/tab2_panel2.tex, delim("&") nonames nolabel noquote replace

!rm US*
!rm CA*
!rm AU*
!rm UK*
!rm DE*
!rm FR*
!rm IT*
!rm ES*
///////////////////////////////////////////////////////////////////////////////
