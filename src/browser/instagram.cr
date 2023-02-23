module Browser
  class Instagram < Base
    def id : String
      "instagram"
    end

    def name : String
      "Instagram"
    end

    def full_version : String
      ua[%r{Instagram[ \/]([\d.]+)}, 1]? || "0.0"
    end

    def match? : Bool
      ua.includes?("Instagram")
    end
  end
end
