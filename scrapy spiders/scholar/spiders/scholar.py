# -*- coding: utf-8 -*-
import scrapy
from urllib.parse import urlencode
from urllib.parse import urlparse
import json
from datetime import datetime

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
            # TODO: Snippet and Publishers contain mangled UTF-8 encoding. Fix this using some form of UTF-8 unmangling. 
            snippet = "".join(res.xpath('.//*[@class="gs_rs"]//text()').extract())
            citations = res.xpath('.//a[starts-with(text(),"Cited")]/text()').extract_first().replace("Cited by ", "")
            # TODO: Implement CitationLink
            temp = res.xpath('.//a[starts-with(text(),"Related")]/@href').extract_first()
            related_link = "https://scholar.google.com" + temp if temp else ""
            temp = res.xpath(".//a[@class='gs_nph']/@href").extract_first()
            versions_link = "https://scholar.google.com" + temp if temp else ""
            versions_count = res.xpath('.//a[contains(text(),"version")]/text()').extract_first().replace("All ", "").replace(" versions", "")
            # TODO: Seperate Authors, Year, Publisher
            publishers = "".join(res.xpath('.//div[@class="gs_a"]//text()').extract())
            position += 1
            item = {'position': position, 'title': title, 'publishers': publishers, 'snippet': snippet, 'link': link, 
                    'citations': citations, 'relatedLink': related_link, 'versionsCount': versions_count,
                    'versionsLink': versions_link}
            yield item
        next_page = response.xpath('//td[@align="left"]/a/@href').extract_first()
        if next_page:
            url = "https://scholar.google.com" + next_page
            yield scrapy.Request(url, callback=self.parse,meta={'position': position})
