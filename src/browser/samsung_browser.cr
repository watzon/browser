module Browser
  class SamsungBrowser < Chrome
    def id : String
      "samsung_browser"
    end

    def name : String
      "Samsung Browser"
    end

    def full_version : String
      ua[%r{SamsungBrowser/([\d.]+)}, 1]? || super
    end

    def match? : Bool
      !!(ua =~ /SamsungBrowser/)
    end
  end
end
