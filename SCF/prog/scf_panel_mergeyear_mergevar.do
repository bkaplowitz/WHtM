cd ${USdir}/rawdata/extract

////////////////////////////////////////////////////////////////////////////////
//merges real extract data for all of the panel years
use rscfp2009panel.dta, clear
rename wilsh WILSH09

// drops diff and pct diff vars
drop assetdif assetpct bonddif bondpct busdif buspct bussefarmincdif bussefarmincpct ///
calldif callpct cashlidif cashlipct ccbaldif ccbalpct cdsdif cdspct checkingdif ///
checkingpct conspaydif conspaypct debtdif debtpct deqdif deqpct edninstdif edninstpct ///
equitydif equitypct findif finpct helocdif helocpct homeeqdif homeeqpct housesdif ///
housespct incomedif incomepct installdif installpct intdivincdif intdivincpct ///
irakhdif irakhpct kgincdif kgincpct leveragedif leveragepct liqdif liqpct mortpaydif ///
mortpaypct mrtheldif mrthelpct msavingdif msavingpct networthdif networthpct nfindif ///
nfinpct nhmortdif nhmortpct nmmfdif nmmfpct nnresredif nnresrepct normincdif ///
normincpct odebtdif odebtpct oresredif oresrepct othfindif othfinpct othinstdif ///
othinstpct othlocdif othlocpct othmadif othmapct othnfindif othnfinpct peneqdif ///
peneqpct psavingdif psavingpct race racecl resdbtdif resdbtpct reteqdif reteqpct ///
retqliqdif retqliqpct revpaydif revpaypct savbnddif savbndpct ssretincdif ///
ssretincpct stocksdif stockspct tpaydif tpaypct transfothincdif transfothincpct ///
vehicdif vehicpct vehinstdif vehinstpct vowndif vownpct wageincdif wageincpct i

reshape long ACTBUS ADJM1 ADJM2 AGE AGEALL AGECL AGEFT ANNUIT ANYPEN APPLIED ///
ASSET ASSETCAT BCALL BDONT BFINPLAN BFINPRO BFRIENDWORK BINTERNET BMAGZNEWS ///
BMAILADTV BOND BOTHER BPLANCJ BSELF BSHOPGRDL BSHOPMODR BSHOPNONE BUS BUSSEFARMINC ///
BUSVEH CALL CASHLI CCBAL CDS CHECKING CONSPAY DBPLANCJ DBPLANT DCPLANCJ DEBT ///
DENIED DEQ EDCL EDNINST EDUC EQUITINC EQUITY FAMSTRUCT FEARED FGUARANTEE FHA FIN ///
FULLAMT HABUS HASSET HBOND HBROK HBUS HCALL HCASHLI HCCBAL HCDS HCHECK HDEBT HEDNINST ///
HELOC HELOCYN HEQUITY HFIN HHEALTH HHELOC HHOUSES HINSTALL HIPIR HLIQ HMMA HMRTHEL ///
HNFIN HNHMORT HNMMF HNNRESRE HODEBT HOMEEQ HORESRE HOTHFIN HOTHINST HOTHLOC HOTHMA ///
HOTHNFIN HOUSECL HOUSES HPRIMMORT HRESDBT HRETQLIQ HSAVBND HSAVING HSECMORT HSTOCKS ///
HTRAD HVEHIC HVEHINST ICALL IDONT IFINPLAN IFINPRO IFRIENDWORK IINTERNET IMAGZNEWS ///
IMAILADTV INCCAT INCCL2 INCOME INDCAT INSTALL INTDIVINC IOTHER IRAKH ISELF ISHOPGRDL ///
ISHOPMODR ISHOPNONE KGINC KIDS LATE60 LEASE LEVERAGE LIFECL LIQ MARRIED MORTPAY ///
MRTHEL MSAVING NBUSVEH NETWORTH NFIN NHMORT NHNFIN NLEASE NMMF NNRESRE NOCHK ///
NONACTBUS NORMINC NOWN NSTOCKS NTRAD NVEHIC NWCAT OCCAT1 OCCAT2 ODEBT ONTIMEM1 ///
ONTIMEM2 ORESRE OTHFIN OTHINST OTHLOC OTHMA OTHNFIN OWN PENACCTWD PENEQ PIRCONS ///
PIRMORT PIRREV PIRTOTAL POSTRWORK PSAVING PURCH1 REFINEVER RESDBT RETEQ RETQLIQ ///
REVPAY RFULL RISK SAVBND SAVED SPENDMOR SPHEALTH SSRETINC STOCKS THRIFT TPAY ///
TRANSFOTHINC TRUSTS USPELL VEHIC VEHINST VOWN WAGEINC WILSH WSAVED, i(Y1) j(year 07 09)

replace year = year + 2000

keep if year == 2009

// generates a variable for the imputation number
tostring Y1, generate(str_Y1)
gen im0100 = substr(str_Y1,-1,.)
destring im0100, replace

replace im0100 = im0100

cd ${USdir}/rawdata
save SCF_panel_09.dta, replace
clear

cd ${USdir}/rawdata/full
//merges full data
use p09pi6.dta, clear
gen year = 2009

cd ${USdir}/rawdata
save SCF_extra_panel_09.dta, replace

clear
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//grabs relevant data from the full data set
//see codebook for explanation of variables
use year Y1 YY1 P432 P09202 P09203 P09206 P09207 ///
		P5702 P5704 P5716 P5718 P5720 P5722 P5725 P5724 P3015 P3016 P3017 ///
		P7510 P7509 P4112 P4113 P4712 P4713 P4131 P4132 P4731 P4732 P7508 ///
	    using SCF_extra_panel_09.dta

rename P432 payfreq
rename P09206 ccdebt

replace ccdebt = 0 if ccdebt == -1

rename P09207  maxcredit
rename P09202  turnedown
rename P09203  notapplied
replace maxcredit=0 if maxcredit==-1
gen credenied=0
replace credenied=1 if turnedown==1 |turnedown==3

rename P5702 hh_earnings
rename P5704 hh_selfy
rename P5716 uiben
rename P5718 childben
rename P5720 tanf
rename P5722 ssinc
rename P5725 source_othinc
rename P5724 othinc


replace othinc=0 if othinc==-1 | source_othinc ==11 | source_othinc ==14 | source_othinc ==30 | source_othinc ==36


gen labinc = hh_earnings+uiben+childben+tanf+ssinc+othinc
gen labincplus = hh_earnings+hh_selfy+uiben+childben+tanf+ssinc+othinc

rename P3015 nosavebor
rename P3016 nosavezero
rename P3017 savewhatta
gen htm1=0
replace htm1 = 1 if nosavebor==1 | nosavezero==1 

rename P7510 spendmorey
rename P7509 buyhome
 
gen htm5 = .
replace htm5 = 0 if spendmorey == 3
replace htm5 = 1 if (spendmorey==1 | spendmorey==2) & (buyhome==5 | buyhome == 0)
replace htm5 = 1 if (spendmorey==1 | spendmorey==2) & buyhome==1 & (P7508 == 1 | P7508 == 2)
replace htm5 = 0 if (spendmorey==1 | spendmorey==2) & buyhome==1 & (P7508 == 3 | P7508 == 0)
 
rename P4112 labearn1 
rename P4113 freqle1 
rename P4712 labearn2 
rename P4713 freqle2 
rename P4131 selfearn1
rename P4132 freqse1 
rename P4731 selfearn2
rename P4732 freqse2 
replace labearn1 = 0 if labearn1<=0
replace labearn2 = 0 if labearn2<=0
replace selfearn1 = 0 if selfearn1<=0
replace selfearn2 = 0 if selfearn2<=0
gen hh_earningsalt = labearn1+labearn2+selfearn1+selfearn2

// generates a variable for the imputation number
tostring Y1, generate(str_Y1)
gen im0100 = substr(str_Y1,-1,.)
destring im0100, replace

replace im0100 = im0100

////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////

// deflates relevant data into 2010 terms using the CPI-U-RS http://www.bls.gov/cpi/cpiursai1978_2010.pdf
//use September values for each year (around when the survey was done)
gen CPIADJ = 0
replace CPIADJ = 317.1/320.8 if year == 2009
replace CPIADJ = 306.2/320.8 if year == 2007

local z "ccdebt hh_earnings hh_selfy uiben childben tanf ssinc othinc labinc labincplus labearn1 labearn2 selfearn1 selfearn2 hh_earningsalt maxcredit"
foreach k of local z{
replace `k' = `k'*CPIADJ
}

//merges data with the extract data
merge 1:1 Y1 year im0100 using SCF_panel_09.dta
keep if _merge == 3
drop _merge

rename *, lower
rename y1 Y1
rename yy1 YY1

////////////////////////////////////////////////////////////////////////////////

replace married = 0 if married == 2

rename edcl educcat
label define edlab 1 "<HS" 2 "HS" 3 "some college" 4 "college"
label values educcat edlab

//rename lf working

label define famlab 1 "not married with kids" 2 "not married, no kids, under 55" 3 "not married, no kids, over 55" 4 "married with kids" 5 "married, no kids"
label values famstruct famlab

cd ${USdir}/rawdata
append using SCF_89_10.dta

keep if year == 2007 | year == 2009

// gets the weights for 09
replace wgt = wgt09 if wgt == .

save SCF_panel_07_09.dta, replace
