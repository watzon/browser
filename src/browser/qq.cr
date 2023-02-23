module Browser
  class QQ < Base
    def id : String
      "qq"
    end

    def name : String
      "QQ Browser"
    end

    def full_version : String
      ua[%r{(?:Mobile MQQBrowser)/([\d.]+)}i, 1]? ||
        ua[%r{(?:QQBrowserLite)/([\d.]+)}i, 1]? ||
        ua[%r{(?:QQBrowser)/([\d.]+)}i, 1]? ||
        ua[%r{(?:QQ)/([\d.]+)}i, 1]? ||
        "0.0"
    end

    def match? : Bool
      ua.matches?(%r{QQ/|QQBrowser}i)
    end
  end
end
