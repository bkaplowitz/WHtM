// for a given set of parameters, income, liquid, and illiquid wealth category, 
//this determines if a household is HtM or not
// HtM is htm0_a = 1
// WHtM is htm0_a = 1 and htm0_b = 1
// PHtM is htm0_a = 1 and htm0_b = 0
// NHtM is htm0_a = 0
// HtM-NW is htm0_c = 1
// N-HtM-NW is htm0_c = 0

// 12 months borrowing limit
if strmatch("$h2mtype","borr12x")==1 {
gen m = 12*monthlabinc
gen htm0_a =0
replace htm0_a = 1 if (liqvar>=0 & liqvar<=monthlabinc/paymfreq) | (liqvar<0 & liqvar<=(monthlabinc/paymfreq - m) )
gen htm0_b =0
replace htm0_b = 1 if (liqvar>=0 & liqvar<=monthlabinc/paymfreq & illiqvar>${illiqvarlim}) | (liqvar<0 & liqvar<=(monthlabinc/paymfreq - m) & illiqvar>${illiqvarlim})
gen htm0_c =0
replace htm0_c = 1 if (nwvar>=0 & nwvar<=monthlabinc/paymfreq) | (nwvar<0 & nwvar<=(monthlabinc/paymfreq - m) )
}

// 1 month borrowing limit
if strmatch("$h2mtype","borr1x")==1 {
// if heloc is in liquid, extends credit limit by the heloc limit
if strmatch("$liqvar","netbrliqheloc")==1 {
gen m = 1*monthlabinc + heloc_lim
}
else {
gen m = 1*monthlabinc
}
gen htm0_a =0
replace htm0_a = 1 if (liqvar>=0 & liqvar<=monthlabinc/paymfreq) | (liqvar<0 & liqvar<=(monthlabinc/paymfreq - m) )
gen htm0_b =0
replace htm0_b = 1 if (liqvar>=0 & liqvar<=monthlabinc/paymfreq & illiqvar>${illiqvarlim}) | (liqvar<0 & liqvar<=(monthlabinc/paymfreq - m) & illiqvar>${illiqvarlim})
gen htm0_c =0
replace htm0_c = 1 if (nwvar>=0 & nwvar<=monthlabinc/paymfreq) | (nwvar<0 & nwvar<=(monthlabinc/paymfreq - m) )
}

// reported credit limit
if strmatch("$h2mtype","borrmaxcredit")==1 {
gen m = 1*maxcredit
gen htm0_a =0
replace htm0_a = 1 if (liqvar>=0 & liqvar<=monthlabinc/paymfreq) | (liqvar<0 & liqvar<=(monthlabinc/paymfreq - m) )
gen htm0_b =0
replace htm0_b = 1 if (liqvar>=0 & liqvar<=monthlabinc/paymfreq & illiqvar>${illiqvarlim}) | (liqvar<0 & liqvar<=(monthlabinc/paymfreq - m) & illiqvar>${illiqvarlim})
gen htm0_c =0
replace htm0_c = 1 if (nwvar>=0 & nwvar<=monthlabinc/paymfreq) | (nwvar<0 & nwvar<=(monthlabinc/paymfreq - m) )
}
////////////////////////////////////////////////////////////////////////////////

// committed consumption purchases at the beginning of the period
if strmatch("$h2mtype","commconsbegmaxcred")==1 {
gen m = 1*maxcredit
gen htm0_a =0
replace htm0_a = 1 if (liqvar>=0 & liqvar<=(monthlabinc-committed_cons)/paymfreq) | (liqvar<0 & liqvar<=((monthlabinc-committed_cons)/paymfreq - m) )
gen htm0_b =0
replace htm0_b = 1 if (liqvar>=0 & liqvar<=(monthlabinc-committed_cons)/paymfreq & illiqvar>${illiqvarlim}) | (liqvar<0 & liqvar<=((monthlabinc-committed_cons)/paymfreq - m) & illiqvar>${illiqvarlim})
gen htm0_c =0
replace htm0_c = 1 if (nwvar>=0 & nwvar<=(monthlabinc-committed_cons)/paymfreq) | (nwvar<0 & nwvar<=((monthlabinc-committed_cons)/paymfreq - m) )
}

// committed consumption purchases at the end of the period
if strmatch("$h2mtype","commconsendmaxcred")==1 {
gen m = 1*maxcredit
gen htm0_a =0
replace htm0_a = 1 if (liqvar>=0 & liqvar-committed_cons<=monthlabinc/paymfreq) | (liqvar<0 & liqvar-committed_cons<=(monthlabinc/paymfreq - m) )
gen htm0_b =0
replace htm0_b = 1 if (liqvar>=0 & liqvar-committed_cons<=monthlabinc/paymfreq & illiqvar>${illiqvarlim}) | (liqvar<0 & liqvar-committed_cons<=(monthlabinc/paymfreq - m) & illiqvar>${illiqvarlim})
gen htm0_c =0
replace htm0_c = 1 if (nwvar>=0 & nwvar-committed_cons<=monthlabinc/paymfreq) | (nwvar<0 & nwvar-committed_cons<=(monthlabinc/paymfreq - m) )
}

// committed consumption purchases at the beginning of the period
if strmatch("$h2mtype","commconsbeg1x")==1 {
gen m = 1*monthlabinc
gen htm0_a =0
replace htm0_a = 1 if (liqvar>=0 & liqvar<=(monthlabinc-committed_cons)/paymfreq) | (liqvar<0 & liqvar<=((monthlabinc-committed_cons)/paymfreq - m) )
gen htm0_b =0
replace htm0_b = 1 if (liqvar>=0 & liqvar<=(monthlabinc-committed_cons)/paymfreq & illiqvar>${illiqvarlim}) | (liqvar<0 & liqvar<=((monthlabinc-committed_cons)/paymfreq - m) & illiqvar>${illiqvarlim})
gen htm0_c =0
replace htm0_c = 1 if (nwvar>=0 & nwvar<=(monthlabinc-committed_cons)/paymfreq) | (nwvar<0 & nwvar<=((monthlabinc-committed_cons)/paymfreq - m) )
}

// committed consumption purchases at the end of the period
if strmatch("$h2mtype","commconsend1x")==1 {
gen m = 1*monthlabinc
gen htm0_a =0
replace htm0_a = 1 if (liqvar>=0 & liqvar-committed_cons<=monthlabinc/paymfreq) | (liqvar<0 & liqvar-committed_cons<=(monthlabinc/paymfreq - m) )
gen htm0_b =0
replace htm0_b = 1 if (liqvar>=0 & liqvar-committed_cons<=monthlabinc/paymfreq & illiqvar>${illiqvarlim}) | (liqvar<0 & liqvar-committed_cons<=(monthlabinc/paymfreq - m) & illiqvar>${illiqvarlim})
gen htm0_c =0
replace htm0_c = 1 if (nwvar>=0 & nwvar-committed_cons<=monthlabinc/paymfreq) | (nwvar<0 & nwvar-committed_cons<=(monthlabinc/paymfreq - m) )
}

// financially fragile households
if strmatch("$h2mtype","finfrag")==1 {
gen m = 1*monthlabinc
gen htm0_a =0
replace htm0_a = 1 if (liqvar>=0 & liqvar<=monthlabinc/paymfreq + 2000) | (liqvar<0 & liqvar<=(monthlabinc/paymfreq - m + 2000) )
gen htm0_b =0
replace htm0_b = 1 if (liqvar>=0 & liqvar<=monthlabinc/paymfreq + 2000 & illiqvar>${illiqvarlim}) | (liqvar<0 & liqvar<=(monthlabinc/paymfreq - m + 2000) & illiqvar>${illiqvarlim})
gen htm0_c =0
replace htm0_c = 1 if (nwvar>=0 & nwvar<=monthlabinc/paymfreq + 2000) | (nwvar<0 & nwvar<=(monthlabinc/paymfreq - m + 2000) )
}

*---------------------------
*ALTERNATIVE MEASURES OF HTM
*---------------------------
* HTM1: usually spend >=y, HTM3: past year spent >=y
gen h2m1 = (htm1 == 1)
gen Wh2m1 = (htm1 == 1 & netbrilliqnc>0)
gen Ph2m1 = (htm1 == 1 & netbrilliqnc<=0)
gen Nh2m1 = (htm1 == 0)

local dir `c(pwd)'
if strmatch("`dir'", "${USdir}/cleandata")==1 {
gen h2m5 = (htm5 == 1)
gen Wh2m5 = (htm5 == 1 & netbrilliqnc>0)
gen Ph2m5 = (htm5 == 1 & netbrilliqnc<=0)
gen Nh2m5 = (htm5 == 0)
}
////////////////////////////////////////////////////////////////////////////////
//Generate hand to mouth characterizations
gen h2m = (htm0_a == 1)
gen Wh2m = (htm0_b == 1)
gen Ph2m = (htm0_a == 1 & htm0_b == 0)
gen Nh2m = (htm0_a == 0)
gen h2mNW = (htm0_c == 1)

gen h2m_status = .
replace h2m_status = 1 if Wh2m == 1
replace h2m_status = 2 if Ph2m == 1
replace h2m_status = 3 if Nh2m == 1
////////////////////////////////////////////////////////////////////////////////
