require "xml"

module Spotlight
  class Google < Base
    def build_url(query : String, page : Int32 = 1) : String
      query = URI.encode(query, space_to_plus: true)
      "https://www.google.com/search?q=#{query}&safeui=off&client=ubuntu&num=10&page=#{page}"
    end

    def parse(html : String) : Array(Spotlight::Result)
      parsed = XML.parse_html(html)
      results = parsed.xpath_nodes("//div[@class=\"g\"]")
      results.to_a.map { |res| parse_single_result(res) }.compact
    end

    def parse_single_result(result : XML::Node) : Result?
      r_elem = result.xpath_node(".//div[@class=\"r\"]")
      return unless r_elem

      link_tag = r_elem.xpath_node(".//a").not_nil!
      title = r_elem.xpath_node(".//h3").not_nil!
      desc = result.xpath_node(".//span[@class='st']").not_nil!

      Result.new(title.content, link_tag["href"], desc.content)
    end
  end
end
