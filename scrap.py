import requests 
from bs4 import BeautifulSoup
import pandas as pd

with open('./data/clothes_uris.txt') as c:
    clothes = c.read().splitlines()

json = [] # an empty list for the JSON we extract

for cloth in clothes:
    r = requests.get(cloth)
    soup = BeautifulSoup(r.text,'lxml')
    json.append(soup.findAll(attrs={"type" : "application/ld+json"})[0].string)

# data analysis
# df = pd.read_json(json)
# df.iloc[0]