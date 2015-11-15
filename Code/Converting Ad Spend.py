# -*- coding: utf-8 -*-
"""
Created on Sat Nov 14 16:52:12 2015

@author: Leon
"""

import pandas as pd
import us

adspend = pd.read_excel("..\data\AdSpending.xlsx",sheetname=None)

# convert abbreviations to names
adspend['2004']["State"] = adspend['2004']["State"].map(lambda x: str(us.states.lookup(x)))

# write out dist. of columbia
adspend['2012']['State'][adspend['2012']['State'] == 'Dist. of Columbia'] = 'District of Columbia'

# drop the totals row for 2012
adspend['2012'].drop(adspend['2012'].index[-1],inplace=True)

# add FIPS column
adspend['2004']['FIPS'] = adspend['2004']["State"].map(lambda x: us.states.mapping('name','fips')[x])
adspend['2008']['FIPS'] = adspend['2008']["State"].map(lambda x: us.states.mapping('name','fips')[x])
adspend['2012']['FIPS'] = adspend['2012']["State"].map(lambda x: us.states.mapping('name','fips')[x])

# concatenate all years
adspend_all_years = pd.concat([adspend['2004'],adspend['2008'],adspend['2012']])

# write to csv
adspend_all_years.to_csv("../data/adspend_all_years.csv",encoding='utf-8')