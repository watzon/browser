module Browser
  class Sputnik < Base
    def id : String
      "sputnik"
    end

    def name : String
      "Sputnik"
    end

    def full_version : String
      ua[%r{SputnikBrowser/([\d.]+)}, 1]? || "0.0"
    end

    def match? : Bool
      ua.includes?("SputnikBrowser")
    end
  end
end
