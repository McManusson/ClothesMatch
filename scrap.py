import requests 
from bs4 import BeautifulSoup
import pandas as pd
from time import sleep
import json as js

with open('./data/clothes_uris.txt') as c:
    clothes = c.read().splitlines()

headers = {'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',}
json = [] # an empty list for the JSONs+
json2 = [] # for the following batch from N=5980

for cloth in clothes:
    r = requests.get(cloth, headers=headers, timeout=10)
    sleep(0.2)
    if r.status_code == 200:
        soup = BeautifulSoup(r.text,'lxml')
        piece = str(soup.findAll(attrs={"type" : "application/ld+json"})[0].string)
        soup.decompose() # optimization purposes
        json2.append(piece)
    else:
        json2.append("Sorry")

# saving this
with open('test.txt', 'w') as f:
    f.write(js.dumps(json))

# for load that:
# empty df
df = pd.read_json(json[0]).iloc[0]
df = df.to_frame().T # transpose
df = df.drop(columns='brand')
df = df.drop(0, axis=0)



price = []
url = []
name = []
image = []

# alternatives, men (from json 4061:, 4205:)
for item in json[4205:]:
    df = pd.read_json(item)
    price.append(df.offers[0]['price'])
    url.append(df.offers[0]['url'])
    name.append(df.name[0])

# data analysis
# df = pd.read_json(json)
# df.iloc[0]