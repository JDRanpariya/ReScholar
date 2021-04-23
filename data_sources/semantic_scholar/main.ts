const { request } = require("node:https");
const puppeteer = require("puppeteer");

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  const svc = request.args.get("svc");

  svc == "search_results" ? get_results(request) : get_paper_details(request);

  async function get_results(request) {
    const default_query: string = "residual_learning";
    const query: string = request.args.get("q") ?? default_query;
    const item_count: number = request.args.get("item_count") ?? 10;
    // const sort_by: number = request.args.get("sort_by") ?? 0;
    const url: string = `https://www.semanticscholar.org/search?q=${query}&sort=relevance`;

    await page.goto(url, { waitUntil: "domcontentloaded" });

    const getResults = page.evaluate(() => {
      // * TODO
    });
  }

  // get paper details function
  async function get_paper_details(request) {
    const parse_url: String = request.args.get("url");
    const url: String = parse_url;

    await page.goto(url, { waitUntil: "domcontentloaded" });

    const getDetail = await page.evaluate(() => {
      // get title
      const title = document.querySelector("#paper-header > h1").innerText;
      // get authors
      authors = [];
      const nodeListAuthors = document.querySelectorAll(
        "#paper-header > ul.flex-row-vcenter.paper-meta > li:nth-child(1) > span > span"
      );
      const authorsRawArray = [...nodeListAuthors];
      authorsRawArray.forEach((author) => {
        authors.push(author.innerText);
      });
      // get citations
      const citations = document
        .querySelector(
          "#main-content > div.fresh-paper-detail-page__above-the-fold > div > div > div.flex-item.flex-item--width-33.flex-item__right-column > div.scorecard > div > div > div > div > span > span"
        )
        .innerText.split(" ")[0];
      // get citations link
      const citationsLink = document.querySelector(
        "#main-content > div.paper-detail-page__paper-nav > div > div > nav > div > ul > li:nth-child(5) > a"
      ).href;
      // get doi
      const doi = document.querySelector(
        "#paper-header > ul.paper-meta.paper-detail__paper-meta-top > li > section > a"
      ).innerText;
      // get abstract
      const abstract = document.querySelector(
        "#paper-header > div.fresh-paper-detail-page__abstract > div"
      ).innerText;
      // get links
      const links = [
        document.querySelector(
          "#paper-header > div.flex-container.flex-wrap.flex-paper-actions-group.alternate-sources > div:nth-child(1) > div > div.flex-item.primary-paper-link-button > a"
        ).href,
      ];
      // get pdf links
      let pdfLinks = [];
      const pdflink = document.querySelector(
        "#paper-header > div.flex-container.flex-wrap.flex-paper-actions-group.alternate-sources > div:nth-child(1) > div > div.alternate-sources-dropdown-institutional-banner-wrapper > div > a"
      ).href;
      pdfLinks.push(pdflink);
      // open dropdown to get all links
      // document.querySelector("#paper-header > div.flex-container.flex-wrap.flex-paper-actions-group.alternate-sources > div:nth-child(1) > div > div.alternate-sources-dropdown-institutional-banner-wrapper > div > div > div").click()
      // const pdfLinksNodeList  = document.querySelectorAll("#paper-header > div.flex-container.flex-wrap.flex-paper-actions-group.alternate-sources > div:nth-child(1) > div > div.alternate-sources-dropdown-institutional-banner-wrapper > div > div > div > div > div > ul > li > a");
      // const pdfLinksList = [...pdfLinksNodeList];
      // pdfLinksList.forEach((pdflink) => {pdfLinks.push(pdflink.href)};
      // references
      const references = document
        .querySelector(
          "#main-content > div.paper-detail-page__paper-nav > div > div > nav > div > ul > li:nth-child(6) > a > span"
        )
        .innerText.split(" ")[0];
      const referencesLink = document.URL + "#references";
      const relatedLink = document.URL + "#related-papers";

      return {
        title: title,
        authors: authors,
        citations: citations,
        citationsLink: citationsLink,
        doi: doi,
        abstract: abstract,
        links: links,
        pdfLinks: pdfLinks,
        references: references,
        referencesLinks: referencesLink,
        relatedLink: relatedLink,
      };
    });

    return JSON.stringify(getDetail);
  }

  await browser.close();
})();
