import requests
from bs4 import BeautifulSoup
import json

def scrape_data_from_div(soup_div):
    item = {}
    domain = "https://citeseerx.ist.psu.edu"

    item["title"] = soup_div.find("a").text.strip()
    item["link"] = domain + soup_div.find("a")['href']
    item["authors"] = soup_div.find("span", class_="authors").text[2:].strip()
    item["snippet"] = soup_div.find("div", class_="snippet").text[4:-4].strip()

    try: 
        item["citationLink"] = domain + soup_div.find("a", class_="citation remove")['href']
        item["citations"] = soup_div.find("a", class_="citation remove").text.split(' ')[2]
    except TypeError:
        item["citationLink"] = "None"
        item["citation"] = "None"
    
    return item


def CiteSeerX():
    default_query="residual learning"
    query = request.args.get('q') if request.args.get('q')!=None else default_query
    
    url = f"https://citeseerx.ist.psu.edu/search?q={query}"

    page = requests.get(url)

    soup = BeautifulSoup(page.content, 'html.parser')
    temp_soup = soup.find_all("div", class_="result")

    result = []

    for div in temp_soup:
        item = scrape_data_from_div(div)
        result.append(item)
    return json.dumps(result)

