module Browser
  class GoogleSearchApp < Chrome
    def id : String
      "google_search_app"
    end

    def name : String
      "Google Search App"
    end

    def full_version : String
      ua[%r{GSA/([\d.]+\d)}, 1]? || super
    end

    def match? : Bool
      ua.includes?("GSA")
    end
  end
end
