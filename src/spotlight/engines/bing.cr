require "xml"

module Spotlight
  class Bing < Base
    def build_url(query : String, page : Int32 = 1) : String
      query = URI.encode(query, space_to_plus: true)
      offset = (page * 10) - 9

      "https://www.bing.com/search?q=#{query}&count=10&offset=0&first=#{offset}&FORM=PERE"
    end

    def parse(html : String) : Array(Spotlight::Result)
      parsed = XML.parse_html(html)
      results = parsed.xpath_nodes("//li[@class=\"b_algo\"]")
      results.to_a.map { |res| parse_single_result(res) }.compact
    end

    def parse_single_result(result : XML::Node) : Result?
      link_tag = result.xpath_node(".//h2/a").not_nil!
      desc = result.xpath_node(".//div[@class='b_caption']/p").not_nil!
      title = link_tag.content

      Result.new(title, link_tag["href"], desc.content)
    end
  end
end
