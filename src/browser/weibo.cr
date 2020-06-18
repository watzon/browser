module Browser
  class Weibo < Base
    def id : String
      "weibo"
    end

    def name : String
      "Weibo"
    end

    def full_version : String
      ua[/(?:__weibo__)([\d.]+)/i, 1]? || "0.0"
    end

    def match? : Bool
      !!(ua =~ /__weibo__/i)
    end
  end
end
