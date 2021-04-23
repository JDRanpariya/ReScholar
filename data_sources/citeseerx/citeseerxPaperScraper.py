import requests
from bs4 import BeautifulSoup
import json


    # * TODO: extract following
    # ? Common Attributes
    # title
    # authors <ListOfStrings>
    # journal
    # year
    # snippet
    # citations
    # citationsLink
    # deepLink <NoneString>
    # ? Extra Attributes
    # abstract
    # pdfLinks <ListOfStrings>
    # versions
    # versionsLink
    # relatedTopics

def CiteSeerXPaperScraper():

    domain = "https://citeseerx.ist.psu.edu"
    url = "https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.717.6419&rank=5&q=residual%20learning&osm=&ossid="
    # url = request.args.get('link')

    item = {}

    page = requests.get(url)
    soup = BeautifulSoup(page.content, 'html.parser')

    item["title"] = soup.find("h2").text

    authors_string = soup.find("div", id="docAuthors").text
    authors_list = authors_string.split()
    authors_list = ''.join(authors_list).split(',')
    authors_list[0] = authors_list[0][2:]
    
    item["authors"] = authors_list
    item["journal"] = soup.find("tr", id="docVenue").find_all("td")[1].text
    item["year"] = int(soup.find("div", id="bibtex", class_="block").find("p").text[-6:-2])
    item["snippet"] = soup.find("div", id="abstract").find("p").text
    item["citations"] = soup.find("tr", id="docCites").find("a", title="number of citations").text.split()[0]
    item["citationLink"] = domain + soup.find("div", id="docMenu", class_="submenu").find_all("a")[1]["href"]
    item["deepLink"] = "None"
    

    print()

CiteSeerXPaperScraper()