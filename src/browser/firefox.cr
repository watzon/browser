module Browser
  class Firefox < Base
    def id : String
      "firefox"
    end

    def name : String
      "Firefox"
    end

    def full_version : String
      ua[%r{(?:Firefox|FxiOS)/([\d.]+)}, 1]? || "0.0"
    end

    def match? : Bool
      !!(ua =~ /Firefox|FxiOS/)
    end
  end
end
