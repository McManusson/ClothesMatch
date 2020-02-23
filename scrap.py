import requests 
from bs4 import BeautifulSoup
import pandas as pd
from time import sleep

with open('./data/clothes_uris.txt') as c:
    clothes = c.read().splitlines()

headers = {'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',}
json = [] # an empty list for the JSONs

for cloth in clothes:
    r = requests.get(cloth, headers=headers, timeout=10)
    sleep(1)
    if r.status_code == 200:
        soup = BeautifulSoup(r.text,'lxml')
        json.append(soup.findAll(attrs={"type" : "application/ld+json"})[0].string)
    else:
        json.append("Sorry")

# writing file
with open('./data/jsonclothes.txt', 'w') as f:
    for item in json:
        f.write('%s\n' % json)

# data analysis
# df = pd.read_json(json)
# df.iloc[0]