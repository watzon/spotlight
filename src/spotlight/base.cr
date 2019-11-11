require "uri"
require "halite"

module Spotlight
  abstract class Base
    abstract def build_url(query : String, page : Int32 = 1) : String

    abstract def parse(html : String) : Array(Spotlight::Result)

    def search(query : String, limit : Int32 = 10, page : Int32 = 1)
      url = build_url(query, page)

      headers = {
        "User-Agent" => "Mozilla/5.0 (X11; Linux x86_64; rv:70.0) Gecko/20100101 Firefox/70.0",
        "Cache-Control" => "no-cache",
        "Connection" => "keep-alive"
      }
      response = Halite.get(url, headers: headers)

      handle_errors(response)
      parse(response.body)
    end

    def handle_errors(response)

    end
  end
end

require "./engines/*"
