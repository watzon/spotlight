require "xml"

module Spotlight
  class Result
    getter title, link, desc

    def initialize(@title : String, @link : String, @desc : String)
    end
  end
end
