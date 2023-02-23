module Browser
  class HuaweiBrowser < Base
    def id : String
      "huawei_browser"
    end

    def name : String
      "Huawei Browser"
    end

    def full_version : String
      ua[%r{(?:HuaweiBrowser)/([\d.]+)}i, 1]? || "0.0"
    end

    def match? : Bool
      ua.matches?(/HuaweiBrowser/i)
    end
  end
end
