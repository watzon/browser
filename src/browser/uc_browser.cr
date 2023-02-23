module Browser
  class UCBrowser < Base
    def id : String
      "uc_browser"
    end

    def name : String
      "UCBrowser"
    end

    def full_version : String
      ua[%r{UCBrowser/([\d.]+)}, 1]? || "0.0"
    end

    def match? : Bool
      ua.includes?("UCBrowser")
    end
  end
end
