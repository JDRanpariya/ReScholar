import requests
from bs4 import BeautifulSoup
import json


def scrape_data_from_div(soup_div):
    item = {}
    domain = "https://citeseerx.ist.psu.edu"

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

    return item


def CiteSeerXPaperScraper():

    #  example url: https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.1090.7865&rank=1&q=residual%20learning&osm=&ossid=
    url = request.args.get('link')

    page = requests.get(url)

    soup = BeautifulSoup(page.content, 'html.parser')

    item = scrape_data_from_div(soup)

    return json.dumps(item)
