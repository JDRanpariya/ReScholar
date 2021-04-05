# -*- coding: utf-8 -*-
import scrapy
from urllib.parse import urlencode
from urllib.parse import urlparse
import json
from datetime import datetime
import os
from dotenv import load_dotenv

load_dotenv()


class microacadSpider(scrapy.Spider):
    name = 'microacad'
    allowed_domains = ['scholar.google.com']

    def start_requests(self):
        query = 'residual learning'
        api_key = os.getenv("MICROSOFT_RESEARCH_API_KEY")
        url = f'https://api.labs.cognitive.microsoft.com/academic/v1.0/interpret?query={query}&complete=0&count=10&model=latest'

        yield scrapy.Request(url, headers={'Ocp-Apim-Subscription-Key': api_key}, callback=self.parse)

    def parse(self, response):

        res = json.loads(response.body)
        api_key = os.getenv("MICROSOFT_RESEARCH_API_KEY")
        expr1 = str(res['interpretations'][0]['rules'][0]
                    ['output']['value']).replace("//", "")

        url = f'https://api.labs.cognitive.microsoft.com/academic/v1.0/evaluate?expr={expr1}&model=latest&count=10&offset=0&attributes=Ti,S,Y,CC,AA.AuN'

        yield scrapy.Request(url, headers={'Ocp-Apim-Subscription-Key': api_key}, callback=self.parse_expr)

    def parse_expr(self, response):

        res = json.loads(response.body)

        for i in res['entities']:

            links = []
            for link in i["S"]:
                links.append(link[""])
            link = links

            title = i["Ti"]

            cited = i["CC"]

            year = i["Y"]

            authors = []
            for author in i['AA']:
                authors.append(author["AuN"])
            published_data = authors

            item = {'title': title, 'link': link, 'cited': cited,
                    'publishedData': published_data, 'yearofpub': year}
            yield item
