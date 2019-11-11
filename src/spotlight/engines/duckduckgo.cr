require "xml"

module Spotlight
  class DuckDuckGo < Base
    def build_url(query : String, page : Int32 = 1) : String
      query = URI.encode(query, space_to_plus: true)
      offset = (page * 10) - 9
      start = (page < 2) ? 0 : (((page-1) * 50) - 20)

      "https://duckduckgo.com/html/?q=#{query}&s=#{start}&dc=#{offset}&v=l&o=json&api=/d.js"
    end

    def parse(html : String) : Array(Spotlight::Result)
      parsed = XML.parse_html(html)
      results = parsed.xpath_nodes("//*[@class='result results_links results_links_deep web-result ']")
      results.to_a.map { |res| parse_single_result(res) }.compact
    end

    def parse_single_result(result : XML::Node) : Result?
      title = result.xpath_node(".//h2[@class='result__title']").not_nil!
      link_tag = result.xpath_node(".//a[@class='result__url']").not_nil!
      desc = result.xpath_node(".//*[@class='result__snippet']").not_nil!

      Result.new(title.content.strip, link_tag["href"], desc.content)
    end
  end
end
