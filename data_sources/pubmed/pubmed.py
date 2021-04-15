# -*- coding: utf-8 -*-
import scrapy
from urllib.parse import urlencode
from urllib.parse import urlparse
import json
from datetime import datetime

class PubMedSpider(scrapy.Spider):
    name = 'PubMedSpider'
    allowed_domains = ['pubmed.ncbi.nlm.nih.gov']

    def start_requests(self):
        queries = ['weight loss']
        for query in queries:
            url = 'https://pubmed.ncbi.nlm.nih.gov/?' + urlencode({'term': query})
            yield scrapy.Request(url, callback=self.parse)

    def parse(self, response):

        for res in response.xpath("//div[@class='search-results-chunks']"):
            
            link = res.xpath('.//h3/a/@href').extract_first()
            
            temp = res.xpath('.//h3/a//text()').extract()
            if not temp:
                title = "[C] " + "".join(res.xpath('.//h3/span[@id]//text()').extract())
            else:
                title = "".join(temp)
                
            snippet = "".join(res.xpath('.//*[@class="gs_rs"]//text()').extract())
            cited = res.xpath('.//a[starts-with(text(),"Cited")]/text()').extract_first()
            temp = res.xpath('.//a[starts-with(text(),"Related")]/@href').extract_first()
            related = "https://scholar.google.com" + temp if temp else ""
            temp = res.xpath(".//a[@class='gs_nph']/@href").extract_first()
            num_versions_link = "https://scholar.google.com" + temp if temp else ""
            num_versions = res.xpath('.//a[contains(text(),"version")]/text()').extract_first()
            published_data = "".join(res.xpath('.//div[@class="gs_a"]//text()').extract())

            
            item = {
                'title': title,
                'link': link,
                'cited': cited,
                'relatedLink': related,
                'position': position,
                'numOfVersions': num_versions,
                'numOfVersionsLink': num_versions_link ,
                'publishedData': published_data,
                'snippet': snippet
            }
            
            yield item

