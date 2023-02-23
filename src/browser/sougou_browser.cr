module Browser
  class SougouBrowser < Base
    def id : String
      "sougou_browser"
    end

    def name : String
      "Sougou Browser"
    end

    # We can't get the real version on desktop device from the ua string
    def full_version : String
      ua[%r{(?:SogouMobileBrowser)/([\d.]+)}, 1]? || "0.0"
    end

    # SogouMobileBrowser for mobile device
    # SE for desktop device
    def match? : Bool
      ua.matches?(/SogouMobileBrowser/i) || ua.matches?(/\bSE\b/)
    end
  end
end
