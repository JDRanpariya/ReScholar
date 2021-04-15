from multiprocessing import Process, Queue, Manager
import scrapy.spiders
from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings
from urllib.parse import urlencode
import re
import json


def GoogleScholar(request):
    def script(queue, output):
        try:           
            API_KEY = '2e2d79e9d8b5d22114ae3b4b4ba6b507'

            def get_url(url):
                payload = {'api_key': API_KEY, 'url': url, 'country_code': 'us'}
                proxy_url = 'http://api.scraperapi.com/?' + urlencode(payload)
                return proxy_url

            class GoogleScholarSpider(scrapy.Spider):
                name = 'GoogleScholarSpider'
                # allowed_domains = ['scholar.google.com']
                allowed_domains = ['api.scraperapi.com']
                
                def start_requests(self):
                    url = 'https://scholar.google.com/scholar?' + urlencode({'hl': 'en', 'q': self.query})
                    # yield scrapy.Request(url, callback=self.parse, meta={'position': 0})
                    yield scrapy.Request(get_url(url), callback=self.parse, meta={'position': 0})

                def parse(self, response):
                    print(response.url)
                    position = response.meta['position']
                    
                    for res in response.xpath('//*[@data-rp]'):
                        # Link
                        link = res.xpath('.//h3/a/@href').extract_first()
                        # Title
                        temp = res.xpath('.//h3/a//text()').extract()
                        if not temp:
                            title = "[C] " + "".join(res.xpath('.//h3/span[@id]//text()').extract())
                        else:
                            title = "".join(temp)
                        # Snippet 
                        snippet = "".join(res.xpath('.//*[@class="gs_rs"]//text()').extract()).replace("\u2026","...").replace("\u00a0","")
                        # Citations
                        if res.xpath('.//a[starts-with(text(),"Cited")]/text()').extract_first() is not None:
                            citations = res.xpath('.//a[starts-with(text(),"Cited")]/text()').extract_first().replace("Cited by ", "")
                        else:
                            citations = ""
                        # Citations Link
                        temp = res.xpath("//div[@class='gs_fl']/a[3]/@href").extract_first()
                        citations_link = "https://scholar.google.com" + temp if temp else ""
                        # Related Link
                        temp = res.xpath('.//a[starts-with(text(),"Related")]/@href').extract_first()
                        related_link = "https://scholar.google.com" + temp if temp else ""
                        # Version Link
                        temp = res.xpath(".//a[@class='gs_nph']/@href").extract_first()
                        versions_link = "https://scholar.google.com" + temp if temp else ""
                        # Version Count
                        if res.xpath('.//a[contains(text(),"version")]/text()').extract_first() is not None:
                            versions_count = res.xpath('.//a[contains(text(),"version")]/text()').extract_first().replace("All ", "").replace(" versions", "")
                        else:
                            versions_count = ""
                        # Publishing Data
                        publishers = "".join(res.xpath('.//div[@class="gs_a"]//text()').extract()).replace("\u2026","...").replace("\u00a0","")
                        year = re.search("\d+", publishers)[0]
                        journal = publishers.split("-")[1].split(",")[0].strip()
                        authors = publishers.split("-")[0]
                        publisher = publishers.split("-")[-1].strip()
                        
                        position += 1
                        item = {'position': position, 'title': title,  'authors': authors, 'journal':journal, 'year': year, 
                                'publisher': publisher, 'snippet': snippet, 'link': link, 'citations': citations, 'citationLink': citations_link,
                                'relatedLink': related_link, 'versionsCount': versions_count, 'versionsLink': versions_link,}
                        
                        output.append(item)
                        yield item
                        
                    next_page = response.xpath('//td[@align="left"]/a/@href').extract_first()
                    if next_page:
                        url = "https://scholar.google.com" + next_page
                        # yield scrapy.Request(url, callback=self.parse,meta={'position': position})
                        yield scrapy.Request(get_url(url), callback=self.parse,meta={'position': position})

            # Receive arguments from HTTP request
            default_query = ['Residual learning']
            query = request.args.get('q') if request.args.get('q')!=None else default_query
            item_count = request.args.get('item_count') if request.args.get('item_count')!=None else 10
            custom_settings = {'CLOSESPIDER_ITEMCOUNT':f'{item_count}',}
            
            # Instantiate and run spider
            process = CrawlerProcess(custom_settings)
            process.crawl(GoogleScholarSpider, query = query)
            process.start()
            
            queue.put(None)

        # Check for errors in process and add to queue
        except Exception as e:
            queue.put(e)         

    queue = Queue()
    manager = Manager()
    output = manager.list()

    # Wrapping the spider in a child process
    main_process = Process(target=script, args=(queue, output,))
    main_process.start()    
    main_process.join()     

    # Display error checking results
    result = queue.get()
    if result is not None:
        raise result

    return json.dumps(list(output))
    