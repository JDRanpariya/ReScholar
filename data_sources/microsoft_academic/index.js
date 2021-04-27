const puppeteer = require('puppeteer')

exports.MicrosoftAcademicTS = function MicrosoftAcademicTS(req, res) {

  console.log(req.query.q)

  MicrosoftAcademicTS(req, res);
  async function MicrosoftAcademicTS(req, res) {

    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    // svc == service 
    const svc = req.query.svc;
    svc == "search_results" ? await getSearchResults() : await getPaperDetails();

    function scrapeResults() {
      let items = [];
      const results = document.querySelectorAll(
        "#mainArea > router-view > ma-serp > div > div.results > div > compose > div > div.results > ma-card"
      );
      console.log(results);

      for (let result of results) {
        console.log(result.querySelector("span")?.innerText ?? "");
        items.push({
          title: result.querySelector("span")?.innerText ?? "",
          authors:
            result.querySelector("div.authors")?.innerText?.split(",") ?? "",
          journal:
            result
              .querySelector("a.publication")
              ?.innerText?.trim()
              .split(" ")
              .slice(1, -1)
              .join(" ")
              .trim() ?? "",
          year:
            result
              .querySelector("a.publication")
              ?.innerText?.trim()
              ?.split(" ")[0] ?? "",
          snippets:
            result.querySelector("div.text > span > span.au-target")
              ?.innerText ?? "",
          citations:
            result
              .querySelector("div > div.citation > a > span")
              ?.innerText?.split(" ")[0] ?? "",
          citationsLink:
            result.querySelector("div > div.citation > a")?.href ?? "",
          detailsLink: result.querySelector("a")?.href ?? "",
        })
      };
      return JSON.stringify(items);
    }

    const getResults = await page.evaluate(() => {
      return Promise.resolve( //<-- return the data to node.js from browser
        // scraping
        scrapeResults()
      );
    });

    function scrapeDetails() {
      const results = document.querySelectorAll(
        "#mainArea > router-view > ma-serp > div > div.results > div > compose > div > div.results > ma-card"
      );
      console.log(results);
      // const title =
      //   document.querySelector(
      //     "#mainArea > router-view > div > div > div > div > h1"
      //   )?.innerText ?? "";
      // const year =
      //   document.querySelector(
      //     "#mainArea > router-view > div > div > div > div > a.au-target.publication > span.year"
      //   )?.innerText ?? "";
      const references =
        document.querySelector(
          "#mainArea > router-view > div > div > div > div > div.stats > ma-statistics-item:nth-child(1) > div.ma-statistics-item.au-target > div.data > div.count"
        )?.innerText ?? "";
      // const citations =
      //   document.querySelector(
      //     "#mainArea > router-view > div > div > div > div > div.stats > ma-statistics-item:nth-child(2) > div.ma-statistics-item.au-target > div.data > div.count"
      //   )?.innerText ?? "";
      const doi = document
        .querySelector(
          "#mainArea > router-view > div > div > div > div > a.doiLink.au-target"
        )
        .innerText.split(" ")[2];
      // const journal =
      //   document.querySelector(
      //     "#mainArea > router-view > div > div > div > div > a.au-target.publication > span.pub-name.au-target"
      //   )?.innerText ??
      //   "" ??
      //   "";
      // get authors
      // let authors = [];
      // const authorsNodeList = document.querySelectorAll(
      //   "#mainArea > router-view > div > div > div > div > ma-author-string-collection > div > div > div"
      // );
      // for (let author of [...authorsNodeList]) {
      //   authors.push(author?.children[0]?.innerText) ?? "";
      // }
      // abstract
      const abstractText =
        document.querySelector(
          "#mainArea > router-view > div > div > div > div > p"
        )?.innerText ?? "";
      // references, cited by and related links
      const referencesLink = document?.URL ?? "";
      // const citationsLink =
      //   referencesLink?.replace("reference", "citedby") ?? "";
      const relatedLink = referencesLink?.replace("reference", "related") ?? "";
      // * TODO
      const links = [];
      const pdfLinks = [];
      // * TODO
      return {
        // title: title,
        // authors: authors,
        // journal: journal,
        // year: year,
        // citations: citations,
        // citationsLink: citationsLink,
        doi: doi,
        abstractText: abstractText,
        links: links,
        pdfLinks: pdfLinks,
        references: references,
        referencesLinks: referencesLink,
        relatedLink: relatedLink,
      }; // res.status(200).send(JSON.stringify({ items: items })); //JSON.stringify(getResults);

    }
    const getDetails = await page.evaluate(() => {
      return Promise.resolve( // <-- return the data to node.js from browser
        // scraping
        scrapeDetails()
      );
    });

    // get search results function

    async function getSearchResults() {
      const default_query = "residual_learning";
      const query = req.query.q ?? default_query;
      console.log(query);
      //const item_count = req.query("item_count") ?? 10;
      const sort_by = req.query.sort_by ?? 0;
      const url = `https://academic.microsoft.com/search?q=${query}&f=&orderBy=${sort_by}&skip=0&take=10`;
      console.log(url);
      await page.goto(url, { waitUntil: "domcontentloaded" });
      console.log("Page downloaded");
      let data = getResults;
      res.status(200).send(data);
      await browser.close();
    }


    // get paper details function

    async function getPaperDetails() {
      const parse_url = req.query.url;
      const url = parse_url;
      console.log(url);
      await page.goto(url, { waitUntil: "domcontentloaded" });
      console.log("page downloaded paper details")
      const data = getDetails;
      res.status(200).send(JSON.stringify(data));
      await browser.close();
    }
  }
}


