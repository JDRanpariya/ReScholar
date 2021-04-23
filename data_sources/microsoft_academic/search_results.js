const browser = await puppeteer.launch();

const page = await browser.newPage();
await page.goto(https://www.semanticscholar.org/search?q=residual%20learning&sort=relevance',{
    waitUntil: 'domcontentloaded',
  });

const getItem = await page.evaluate(() => {
  items = []
  resultNodeList = document.querySelectorAll("#main-content > div.flex-item.flex-item--width-66.flex-item__left-column > div.result-page > div");
  resultList = [...resultNodeList];
  resultList.forEach((div) => {
    
  });
  // get title
  const title = document.querySelector("#paper-header > h1").innerText;
  
  return {
    'title':title,
    'authors': authors,
    'citations':citations,
    'citationsLink':citationsLink,
    'doi':doi,
    'abstract':abstract,
    'links':links,
    'pdfLinks':pdfLinks,
    'references':references,
    'referencesLinks':referencesLink,
    'relatedLink':relatedLink,
    };
})
console.log(JSON.stringify(getItem));
await browser.close();
