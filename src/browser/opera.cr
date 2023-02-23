module Browser
  class Opera < Base
    def id : String
      "opera"
    end

    def name : String
      "Opera"
    end

    def full_version : String
      ua[%r{OPR/([\d.]+)}, 1]? || ua[%r{Version/([\d.]+)}, 1]? || "0.0"
    end

    def match? : Bool
      ua.matches?(%r{(Opera|OPR/)})
    end
  end
end
