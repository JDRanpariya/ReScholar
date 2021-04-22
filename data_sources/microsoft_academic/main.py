# -*- coding: utf-8 -*-
import scrapy
import json
from multiprocessing import Process, Queue, Manager
import scrapy.spiders
from scrapy.crawler import CrawlerProcess
from urllib.parse import urlencode


def MicrosoftAcademic(request):
    def script(queue, output):
        try:
            class MicrosoftAcademicSpider(scrapy.Spider):            
                name = 'MicrosoftAcademicSpider'
                allowed_domains = ['api.labs.cognitive.microsoft.com']
                

                def start_requests(self):
                    api_key = '334c28ff994144c2a87b76d135f30970'
                    url = f'https://api.labs.cognitive.microsoft.com/academic/v1.0/interpret?query={self.query}&complete=0&count=10&model=latest'

                    yield scrapy.Request(url, headers={'Ocp-Apim-Subscription-Key': api_key}, callback=self.parse)

                def parse(self, response):

                    res = json.loads(response.body)
                    api_key = '334c28ff994144c2a87b76d135f30970'
                    expr1 = str(res['interpretations'][0]['rules'][0]
                                ['output']['value']).replace("//", "")

                    url = f'https://api.labs.cognitive.microsoft.com/academic/v1.0/evaluate?expr={expr1}&model=latest&count=10&offset=0&attributes=Ti,S,Y,CC,AA.AuN'

                    yield scrapy.Request(url, headers={'Ocp-Apim-Subscription-Key': api_key}, callback=self.parse_expr)

                def parse_expr(self, response):

                    res = json.loads(response.body)

                    for i in res['entities']:

                        links = []
                        for link in i["S"]:
                            links.append(link["U"])
                        link = links

                        title = i["Ti"]

                        cited = i["CC"]

                        year = i["Y"]

                        authors = []
                        for author in i['AA']:
                            authors.append(author["AuN"])
                        published_data = authors

                        item = {
                            'title': title,
                            'link': link,
                            'cited': cited,
                            'authors': authors,
                            'year': year
                        }
                        output.append(item)
                        yield item

            # Receive arguments from HTTP request
            default_query = ['Residual learning']
            query = request.args.get('q') if request.args.get('q')!=None else default_query
            
            
            # Instantiate and run spider
            process = CrawlerProcess()
            process.crawl(MicrosoftAcademicSpider, query = query)
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