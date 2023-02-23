module Browser
  class Otter < Base
    def id : String
      "otter"
    end

    def name : String
      "Otter"
    end

    def full_version : String
      ua[%r{Otter/([\d.]+)}, 1]? || "0.0"
    end

    def match? : Bool
      ua.includes?("Otter")
    end
  end
end
