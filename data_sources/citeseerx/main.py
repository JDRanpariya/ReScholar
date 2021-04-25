'''
The commented lines are there from old version, It is commented out in this file because it's already been scraped in the SearchResultsScraper. and it's redundant to scrape it again
I just left it there cause if in case we refactor the code in future it might come in handy. 
-theUnrealSamurai
'''

import request
from bs4 import BeautifulSoup
import json


def CiteSeerX(request):
    
    def getVersionLinks(url):
    domain = "https://citeseerx.ist.psu.edu"
    page = requests.get(url)
    soup = BeautifulSoup(page.content, 'html.parser')

    versionLinks = []
    for version in soup.find("div", id="versions", class_="block").find_all("a"):
        versionLinks.append(domain + version["href"])

    return versionLinks


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
        # test urls, just keep it here it'll come in handy
        # url = "https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.53.5438&rank=3&q=residual%20learning&osm=&ossid="
        # url = "https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.1090.7865"

        url = request.args.get('link')

        item = {}
        domain = "https://citeseerx.ist.psu.edu"
        page = requests.get(url)
        soup = BeautifulSoup(page.content, 'html.parser')


        #COMMON ATTRIBUTES
        # item["title"] = soup.find("h2").text

        # authors_string = soup.find("div", id="docAuthors").text
        # authors_list = authors_string.split(',')
        # authors_list[0] = authors_list[0][11:].strip()
        # item["authors"] = [i.strip() for i in authors_list]

        try:
            item["journal"] = soup.find("tr", id="docVenue").find_all("td")[1].text.title()
        except:
            item["journal"] = "None" 
        try:
            item["year"] = str(int(soup.find("div", id="bibtex", class_="block").find("p").text[-6:-2]))
        except:
            item["year"] = "None"
        # try:
        #     item["citations"] = str(int(soup.find("tr", id="docCites").find("a", title="number of citations").text.split()[0]))
        #     item["citationsLink"] = domain + soup.find("div", id="docMenu", class_="submenu").find_all("a")[1]["href"]
        # except: 
        #     item["citations"] = "None"
        #     item["citationsLink"] = "None"

        item["detailsLink"] = "None"
        # item["snippet"] = "None"
        

        #EXTRA ATTRIBUTES
        item["abstractText"] = soup.find("div", id="abstract").find("p").text
        
        pdfLinks = []
        for i in soup.find("ul", id="dlinks").find_all("li"):
            link = i.find("a")["href"]
            if link[0] == '/':
                link = domain + link
            pdfLinks.append(link)
        item["pdfLinks"] = pdfLinks

        version_url = domain + soup.find("div", id="docMenu", class_="submenu").find_all("a")[5]["href"]
        item["versionsLinks"] = getVersionLinks(version_url)

        item["versions"] = [str(i) for i in list(range(len(item["versionLinks"])))]

        try: 
            keywords = [i.strip() for i in soup.find("div", id="keywords").find('p').text.split('\n')]
            item["related"] = [i for i in keywords if i]
        except:
            item["related"] = "None"

        return json.dumps(item)

    PaperDetailsScraper()