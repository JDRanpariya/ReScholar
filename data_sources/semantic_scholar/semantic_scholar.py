from scrapy import Spider
import scrapy
from urllib.parse import urlencode
from urllib.parse import urlparse
from selenium import webdriver
from scrapy.contracts import Contract
from scrapy_selenium import SeleniumRequest

base_uri = "https://www.semanticscholar.org"

# class WithSelenium(Contract):
#        """ Contract to set the request class to be SeleniumRequest for the current call back method to test
#        @with_selenium
#        """
#        name = 'with_selenium'
#        request_cls = SeleniumRequest


class SemanticScholarSpider(Spider):
    name = "SemanticScholarSpider"
    allowed_domains = ["semanticscholar.org"]
    custom_settings = {
        'USER_AGENT': 'googlebot',
        'DOWNLOADER_MIDDLEWARES':
            {
                'scrapy_selenium.SeleniumMiddleware': 400,
            }
    }

    def start_requests(self):
        queries = ['Residual learning']
        for query in queries:
            url = 'https://www.semanticscholar.org/search?' + \
                urlencode({'q': query})
            # print(url)
            yield SeleniumRequest(url=url, callback=self.parse)

    def parse(self, response):
        for i in range(1, 11):

            title = "".join(response.xpath(
                f"//div[@class='cl-paper-row serp-papers__paper-row paper-row-normal'][{i}]/a/div//text()").extract())
            link = response.xpath(
                f"//div[@class='cl-paper-row serp-papers__paper-row paper-row-normal'][{i}]/div[@class='cl-paper__bulleted-row cl-paper-controls']/div[2]/div[1]/a/@href").extract()[0]
            authors = "".join(response.xpath(
                f"//div[@class='cl-paper-row serp-papers__paper-row paper-row-normal'][{i}]/ul/li[1]//text()").extract())
            journal = response.xpath(
                f"//div[@class='cl-paper-row serp-papers__paper-row paper-row-normal'][{i}]/ul/li[3]//text()").extract()[0].replace("\u2026", "...")
            domains = "".join(response.xpath(
                f"//div[@class='cl-paper-row serp-papers__paper-row paper-row-normal'][{i}]/ul/li[2]//text()").extract())
            year = response.xpath(
                f"//div[@class='cl-paper-row serp-papers__paper-row paper-row-normal'][{i}]/ul/li[4]//text()").extract()[-1]
            snippet = "".join(response.xpath(
                f"//div[@class='cl-paper-row serp-papers__paper-row paper-row-normal'][{i}]/div/div/span[1]//text()").extract())
            citations = response.xpath(
                f"//div[@class='cl-paper-row serp-papers__paper-row paper-row-normal'][{i}]/div[@class='cl-paper__bulleted-row cl-paper-controls']/div[1]/ul/li[1]/div//text()").extract()[0]

            item = {
                'title': title,
                'link': link,
                'authors': authors,
                'journal': journal,
                'year': year,
                'domains ': domains,
                'citations': citations,
                'snippet': snippet,
            }

            yield item
