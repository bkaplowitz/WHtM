xpose, clear var
rename v1 Wh2m
rename v2 Ph2m
rename v3 Nh2m
tostring Wh2m Ph2m Nh2m, replace format("%9.3f") force
rename _varname varname
order varname, first

replace varname = "Liquid wealth / monthly income: p10" if varname == "p10liqincratio"
replace varname = "Liquid wealth / monthly income: p25" if varname == "p25liqincratio"
replace varname = "Liquid wealth / monthly income: p50" if varname == "p50liqincratio"
replace varname = "Liquid wealth / monthly income: p75" if varname == "p75liqincratio"
replace varname = "Liquid wealth / monthly income: p90" if varname == "p90liqincratio"
replace varname = "Liquid wealth / monthly income: mean" if varname == "avgliqincratio"

replace varname = "Housing fraction of illquid wealth: p10" if varname == "p10housefrac"
replace varname = "Housing fraction of illquid wealth: p25" if varname == "p25housefrac"
replace varname = "Housing fraction of illquid wealth: p50" if varname == "p50housefrac"
replace varname = "Housing fraction of illquid wealth: p75" if varname == "p75housefrac"
replace varname = "Housing fraction of illquid wealth: p90" if varname == "p90housefrac"
replace varname = "Housing fraction of illquid wealth: mean" if varname == "avghousefrac"

replace varname = "Retirement fraction of illquid wealth: p10" if varname == "p10retirefrac"
replace varname = "Retirement fraction of illquid wealth: p25" if varname == "p25retirefrac"
replace varname = "Retirement fraction of illquid wealth: p50" if varname == "p50retirefrac"
replace varname = "Retirement fraction of illquid wealth: p75" if varname == "p75retirefrac"
replace varname = "Retirement fraction of illquid wealth: p90" if varname == "p90retirefrac"
replace varname = "Retirement fraction of illquid wealth: mean" if varname == "avgretirefrac"

replace varname = "Fraction with negative liquid wealth" if varname == "neg_liq"
replace varname = "Fraction with positive equity in housing" if varname == "pos_house"
replace varname = "Fraction with positive retirement" if varname == "pos_retire"
replace varname = "Fraction with negative illiquid wealth" if varname == "neg_illiq"

replace varname = " " if varname == "h2m_status"
