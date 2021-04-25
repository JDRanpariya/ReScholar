import requests
from bs4 import BeautifulSoup
import json

def SemanticScholar(request):
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


    def SearchResultsScraper(request):
        default_query = "residual learning"
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



    def PaperDetailsScraper():

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
        
        print()

    PaperDetailsScraper()