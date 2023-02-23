module Browser
  class Nokia < Base
    def id : String
      "nokia"
    end

    def name : String
      "Nokia S40 Ovi Browser"
    end

    def full_version : String
      ua[%r{S40OviBrowser/([\d.]+)}, 1]? || "0.0"
    end

    def match? : Bool
      ua.includes?("S40OviBrowser")
    end
  end
end
