const puppeteer = require('puppeteer')

async function SemanticScholarTS() {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  const svc = req.query("svc");

  svc == "search_results" ? get_results(request) : get_paper_details(request);

  async function get_results() {
    const default_query = "residual_learning";
    const query = req.query("q") ?? default_query;
    const item_count = req.query("item_count") ?? 10;
    // const sort_by = req.query("sort_by") ?? 0;
    const url = `https://www.semanticscholar.org/search?q=${query}&sort=relevance`;

    await page.goto(url, { waitUntil: "domcontentloaded" });

    const getResults = page.evaluate(() => {
      // * TODO
      let items = [];
      const results = document.querySelectorAll(
        "#main-content > div.flex-item.flex-item--width-66.flex-item__left-column > div.result-page > div"
      );

      for (let result of results) {
        items.push({
          title: result.querySelector("a > div")?.innerText ?? "",
          authors: result.querySelector("ul > li")?.innerText?.split(",") ?? "",
          journal:
            result.querySelector("ul > li:nth-child(3)")?.innerText ?? "",
          topic: result.querySelector("ul > li:nth-child(2)")?.innerText ?? "",
          year:
            result
              .querySelector("ul > li:last-child")
              ?.innerText?.split(" ")[2] ?? "",
          snippets:
            result
              .querySelector("div > div")
              ?.innerText.replace("TLDR", "")
              .replace("Expand", "")
              .trim() ?? "",
          citations:
            result.querySelector("li.cl-paper-stats__item > div")?.innerText ??
            "",
          citationsLink: "",
          detailsLink: result.querySelector("a")?.href ?? "",
        });
      }

      return JSON.stringify({ items: items }); //JSON.stringify(getResults);
    });

    return getResults;
  }

  // get paper details function
  async function get_paper_details() {
    const parse_url = req.query("url");
    const url = parse_url;

    await page.goto(url, { waitUntil: "domcontentloaded" });

    const getDetail = await page.evaluate(() => {
      // get title
      const title =
        document.querySelector("#paper-header > h1")?.innerText ?? "";
      // get authors
      let authors = [];
      const nodeListAuthors = document.querySelectorAll(
        "#paper-header > ul.flex-row-vcenter.paper-meta > li:nth-child(1) > span > span"
      );
      const authorsRawArray = [...nodeListAuthors];
      authorsRawArray.forEach((author) => {
        authors.push(author?.innerText);
      });
      // get citations
      const citations =
        document
          .querySelector(
            "#main-content > div.fresh-paper-detail-page__above-the-fold > div > div > div.flex-item.flex-item--width-33.flex-item__right-column > div.scorecard > div > div > div > div > span > span"
          )
          ?.innerText?.split(" ")[0] ?? "";
      // get citations link
      const citationsLink =
        document.querySelector(
          "#main-content > div.paper-detail-page__paper-nav > div > div > nav > div > ul > li:nth-child(5) > a"
        )?.href ?? "";
      // get doi
      const doi =
        document.querySelector(
          "#paper-header > ul.paper-meta.paper-detail__paper-meta-top > li > section > a"
        )?.innerText ?? "";
      // get abstract
      const abstract =
        document.querySelector(
          "#paper-header > div.fresh-paper-detail-page__abstract > div"
        )?.innerText ?? "";
      // get links
      const links = [
        document.querySelector(
          "#paper-header > div.flex-container.flex-wrap.flex-paper-actions-group.alternate-sources > div:nth-child(1) > div > div.flex-item.primary-paper-link-button > a"
        )?.href ?? "",
      ];
      // get pdf links
      let pdfLinks = [];
      const pdflink =
        document.querySelector(
          "#paper-header > div.flex-container.flex-wrap.flex-paper-actions-group.alternate-sources > div:nth-child(1) > div > div.alternate-sources-dropdown-institutional-banner-wrapper > div > a"
        )?.href ?? "";
      pdfLinks.push(pdflink);
      // open dropdown to get all links
      // document.querySelector("#paper-header > div.flex-container.flex-wrap.flex-paper-actions-group.alternate-sources > div:nth-child(1) > div > div.alternate-sources-dropdown-institutional-banner-wrapper > div > div > div").click()
      // const pdfLinksNodeList  = document.querySelectorAll("#paper-header > div.flex-container.flex-wrap.flex-paper-actions-group.alternate-sources > div:nth-child(1) > div > div.alternate-sources-dropdown-institutional-banner-wrapper > div > div > div > div > div > ul > li > a");
      // const pdfLinksList = [...pdfLinksNodeList];
      // pdfLinksList.forEach((pdflink) => {pdfLinks.push(pdflink.href)};
      // references
      const references =
        document
          .querySelector(
            "#main-content > div.paper-detail-page__paper-nav > div > div > nav > div > ul > li:nth-child(6) > a > span"
          )
          ?.innerText?.split(" ")[0] ?? "";
      const referencesLink = document?.URL + "#references";
      const relatedLink = document?.URL + "#related-papers";

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
}
