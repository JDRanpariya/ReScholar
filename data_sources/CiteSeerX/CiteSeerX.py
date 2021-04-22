import requests
from bs4 import BeautifulSoup
import json

def scrape_data_from_div(soup_div):
    result = {}
    domain = "https://citeseerx.ist.psu.edu"

    result["title"] = soup_div.find("a").text.strip()
    result["link"] = domain + soup_div.find("a")['href']
    result["authors"] = soup_div.find("span", class_="authors").text[2:].strip()
    result["snippet"] = soup_div.find("div", class_="snippet").text[4:-4].strip()

    try: 
        result["citationLink"] = domain + soup_div.find("a", class_="citation remove")['href']
        result["citations"] = soup_div.find("a", class_="citation remove").text.split(' ')[2]
    except TypeError:
        result["citationLink"] = "None"
        result["citation"] = "None"
    
    return result


def CiteSeerX(search_term):

    search_url = "https://citeseerx.ist.psu.edu/search?q=" + search_term.replace(" ", "+")

    page = requests.get(search_url)

    soup = BeautifulSoup(page.content, 'html.parser')
    temp_soup = soup.find_all("div", class_="result")

    final_result = []

    for div in temp_soup:
        div_data = scrape_data_from_div(div)
        final_result.append(div_data)
    return final_result


print(json.dumps(CiteSeerX("residual learning")))