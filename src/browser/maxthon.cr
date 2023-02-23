module Browser
  class Maxthon < Base
    def id : String
      "maxthon"
    end

    def name : String
      "Maxthon"
    end

    def full_version : String
      ua[%r{(?:Maxthon)/([\d.]+)}i, 1]? || "0.0"
    end

    def match? : Bool
      ua.matches?(/Maxthon/i)
    end
  end
end
