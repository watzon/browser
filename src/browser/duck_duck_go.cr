module Browser
  class DuckDuckGo < Base
    def id : String
      "duckduckgo"
    end

    def name : String
      "DuckDuckGo"
    end

    def full_version : String
      ua[%r{DuckDuckGo/([\d.]+)}, 1]? ||
        "0.0"
    end

    def match? : Bool
      !!(ua =~ /DuckDuckGo/)
    end
  end
end
