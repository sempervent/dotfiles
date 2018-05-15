#!/usr/bin/env python2.7

import urllib  # basic url handling
import re      # use regex

# create url and some other nifty variables
url = "http://www.usinflationcalculator.com/inflation/"

def retrieve_link(url):
  connection = urllib.urlopen(url)  # open the connection to the site
  siteLinks = connection.read().split("</a>")  # split at end of links
  for link in siteLinks:
    if "Historical Inflation Rates: 1914-2018" in link:
      parseLink = re.search(r"href=\"(.*)\"", link)
      if parseLink:
        inflationLink = parseLink.group(1)
        return inflationLink

def retrieve_inflation(url):
  connection = urllib.urlopen(url)
  

inflationLink = retrieve_link(url)  
print inflationLink
  

