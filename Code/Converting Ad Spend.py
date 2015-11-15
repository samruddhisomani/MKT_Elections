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

# fix 2004 by adding missing states
states = pd.DataFrame(adspend['2008']['State'])
ad2004 = states.merge(adspend['2004'],how='left',on='State')
ad2004.fillna({'TotalMoney':0,'PercentMoney':0,'Year':2004},inplace=True)

# add FIPS column
ad2004['FIPS'] = ad2004['State'].map(lambda x: us.states.mapping('name','fips')[x])
adspend['2008']['FIPS'] = adspend['2008']["State"].map(lambda x: us.states.mapping('name','fips')[x])
adspend['2012']['FIPS'] = adspend['2012']["State"].map(lambda x: us.states.mapping('name','fips')[x])

# concatenate all years
adspend_all_years = pd.concat([ad2004,adspend['2008'],adspend['2012']])


# write to csv
adspend_all_years.to_csv("../data/adspend_all_years.csv",encoding='utf-8')

