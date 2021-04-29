from bs4 import BeautifulSoup
import requests
import time
import json


def CiteSeerX(request):
    def SearchResultsScraper(request):
        def scrape_data_from_div(soup_div):
            paper = {}
            domain = "https://citeseerx.ist.psu.edu"

            paper["title"] = soup_div.find("a").text.strip()

            paper["authors"] = [i.strip() for i in soup_div.find("span", class_="authors").text[2:].strip().split(',')]
            try:
                paper["journal"] = soup_div.find("span", class_="pubvenue").text[1:].strip().title()
            except:
                paper["journal"] = "None"
            try:
                paper["year"] = soup_div.find("span", class_="pubyear").text[1:].strip()
            except:
                paper["year"] = "None"
                
            paper["snippet"] = soup_div.find("div", class_="snippet").text[4:-4].strip()

            try: 
                paper["citations"] = soup_div.find("a", class_="citation remove").text.split(' ')[2]
                paper["citationsLink"] = domain + soup_div.find("a", class_="citation remove")['href']
            except:
                paper["citations"] = "None"
                paper["citationsLink"] = "None"

            paper["detailsLink"] = domain + soup_div.find("a")['href']

            return paper

        default_query = "residual learning"
        query = request.args.get('q') if request.args.get('q')!=None else default_query
        paper_count = request.args.get('paper_count') if request.args.get('paper_count')!=None else 10
        paper_count = int(paper_count)

        url = f"https://citeseerx.ist.psu.edu/search?q={query}"

        if int(paper_count/10) == paper_count/10:
            no_of_pages = int(paper_count/10)
        else: 
            no_of_pages =  int(paper_count/10) + 1

        pages_url = [url+"&start="+str(i+1)+'0' for i in range(no_of_pages)]

        result = []

        for url in pages_url:
            # time.sleep(2)                 // Slow down scraping to precent IP block
            page = requests.get(url)
            soup = BeautifulSoup(page.content, 'html.parser')
            temp_soup = soup.find_all("div", class_="result")

            for div in temp_soup:
                paper = scrape_data_from_div(div)
                result.append(paper)
        
        return json.dumps(result[:paper_count])
        
    def PaperDetailsScraper(request):
        def getVersionsLink(url):
            domain = "https://citeseerx.ist.psu.edu"
            page = requests.get(url)
            soup = BeautifulSoup(page.content, 'html.parser')

            versionsLink = []
            for version in soup.find("div", id="versions", class_="block").find_all("a"):
                versionsLink.append(domain + version["href"])

            return versionsLink

        # Test URLs (Keep these here, might come in handy)
        # url = "https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.53.5438&rank=3&q=residual%20learning&osm=&ossid="
        # url = "https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.1090.7865"

        url = request.args.get('details_link')

        paper = {}
        domain = "https://citeseerx.ist.psu.edu"
        page = requests.get(url)
        soup = BeautifulSoup(page.content, 'html.parser')

        # paper["title"] = soup.find("h2").text
        # authors_string = soup.find("div", id="docAuthors").text
        # authors_list = authors_string.split(',')
        # authors_list[0] = authors_list[0][11:].strip()
        # paper["authors"] = [i.strip() for i in authors_list]
        # try:
        #     paper["journal"] = soup.find("tr", id="docVenue").find_all("td")[1].text.title()
        # except:
        #     paper["journal"] = "None" 
        # try:
        #     paper["year"] = str(int(soup.find("div", id="bibtex", class_="block").find("p").text[-6:-2]))
        # except:
        #     paper["year"] = "None"
        # try:
        #     paper["citations"] = str(int(soup.find("tr", id="docCites").find("a", title="number of citations").text.split()[0]))
        #     paper["citationsLink"] = domain + soup.find("div", id="docMenu", class_="submenu").find_all("a")[1]["href"]
        # except: 
        #     paper["citations"] = "None"
        #     paper["citationsLink"] = "None"
        # paper["detailsLink"] = "None"
        # paper["snippet"] = "None"
        
        paper["abstractText"] = soup.find("div", id="abstract").find("p").text
        
        pdfLinks = []
        for i in soup.find("ul", id="dlinks").find_all("li"):
            link = i.find("a")["href"]
            if link[0] == '/':
                link = domain + link
            pdfLinks.append(link)
        paper["pdfLinks"] = pdfLinks

        version_url = domain + soup.find("div", id="docMenu", class_="submenu").find_all("a")[5]["href"]
        versions_link = getVersionsLink(version_url)
        paper["versions"] = str(len(versions_link))
        paper["versionsLink"] = version_url

        try: 
            keywords = [i.strip() for i in soup.find("div", id="keywords").find('p').text.split('\n')]
            paper["relatedTopics"] = [i for i in keywords if i]
        except:
            paper["relatedTopics"] = ["None"]

        return json.dumps(paper)

    service = request.args.get('svc')
    if service == 'search_results':
        return SearchResultsScraper(request)
    elif service == 'paper_details':
        return PaperDetailsScraper(request)
    else: 
        return "ERROR: Service request invalid"