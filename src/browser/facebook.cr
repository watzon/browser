module Browser
  class Facebook < Base
    def id : String
      "facebook"
    end

    def name : String
      "Facebook"
    end

    def full_version : String
      ua[%r{FBAV/([\d.]+)}, 1]? ||
        ua[%r{AppleWebKit/([\d.]+)}, 0]? ||
        "0.0"
    end

    def match? : Bool
      !!(ua =~ /FBAV|FBAN/)
    end
  end
end
