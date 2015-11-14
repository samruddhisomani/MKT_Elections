import pandas as pd

turnout2012=pd.read_html("https://docs.google.com/spreadsheets/d/1EYjW8l4y-5xPbkTFjdjdpnxOCgVvB8rM_oqjtJhtQKY/pubhtml",header=2)
turnout2012[0].ix[:,[1,3,4]].to_csv('../data/turnout2012.csv')

turnout2008=pd.read_html("https://docs.google.com/spreadsheets/d/1deCSqgLqrzFgpUa_S8Gk-8mKrPq47pkx1eqKwZGtSqA/edit",header=2)
turnout2008[0].ix[:,[1,3,4]].to_csv('../data/turnout2008.csv')

turnout2004=pd.read_html("https://docs.google.com/spreadsheets/d/1eNAo1DjqtGqhc_vEHdPpIFd1TeoTxiCpV9ueA7eREMs/edit",header=2)

turnout2004[0].ix[:,[1,3,4]].to_csv('../data/turnout2004.csv')
