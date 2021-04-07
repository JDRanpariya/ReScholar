# -*- coding: utf-8 -*-
import scrapy
from urllib.parse import urlencode
from urllib.parse import urlparse
import json
from datetime import datetime
import re

class ScholarSpider(scrapy.Spider):
    name = 'scholar'
    allowed_domains = ['scholar.google.com']

    def start_requests(self):
        queries = ['Residual learning']
        for query in queries:
            url = 'https://scholar.google.com/scholar?' + urlencode({'hl': 'en', 'q': query})
            yield scrapy.Request(url, callback=self.parse, meta={'position': 0})

    def parse(self, response):
        print(response.url)
        position = response.meta['position']
        for res in response.xpath('//*[@data-rp]'):
            link = res.xpath('.//h3/a/@href').extract_first()
            temp = res.xpath('.//h3/a//text()').extract()
            if not temp:
                title = "[C] " + "".join(res.xpath('.//h3/span[@id]//text()').extract())
            else:
                title = "".join(temp)

            # Review: Snippet and Publishers contain mangled UTF-8 encoding. Fix this using some form of UTF-8 unmangling. 
            snippet = "".join(res.xpath('.//*[@class="gs_rs"]//text()').extract()).replace("\u2026","...").replace("\u00a0","")
            citations = res.xpath('.//a[starts-with(text(),"Cited")]/text()').extract_first().replace("Cited by ", "")
            
            # Review: Implement CitationLink
            temp = res.xpath("//div[@class='gs_fl']/a[3]/@href").extract_first()
            citation_link = "https://scholar.google.com" + temp if temp else ""
            
            temp = res.xpath('.//a[starts-with(text(),"Related")]/@href').extract_first()
            related_link = "https://scholar.google.com" + temp if temp else ""
            
            temp = res.xpath(".//a[@class='gs_nph']/@href").extract_first()
            versions_link = "https://scholar.google.com" + temp if temp else ""
            
            versions_count = res.xpath('.//a[contains(text(),"version")]/text()').extract_first().replace("All ", "").replace(" versions", "")
            
            # Review: Seperate Authors, Year, Publisher
            publishers = "".join(res.xpath('.//div[@class="gs_a"]//text()').extract()).replace("\u2026","...").replace("\u00a0","")
            
            year = re.search("\d+", publishers)[0]
            journal = publishers.split("-")[1].split(",")[0].strip()
            authors = publishers.split("-")[0]
            publisher = publishers.split("-")[-1].strip()
            
            position += 1
            item = {'position': position, 'title': title,  'authors': authors, 'journal':journal, 'year': year, 
                    'publisher': publisher, 'snippet': snippet, 'link': link, 'citations': citations, 'citationLink': citation_link,
                    'relatedLink': related_link, 'versionsCount': versions_count, 'versionsLink': versions_link,}
            yield item
            
        next_page = response.xpath('//td[@align="left"]/a/@href').extract_first()
        if next_page:
            url = "https://scholar.google.com" + next_page
            yield scrapy.Request(url, callback=self.parse,meta={'position': position})
