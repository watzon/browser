module Browser
  class BlackBerry < Base
    def id : String
      "blackberry"
    end

    def name : String
      "BlackBerry"
    end

    def full_version : String
      ua[%r{BlackBerry[\da-z]+/([\d.]+)}, 1]? ||
        ua[%r{Version/([\d.]+)}, 1]? ||
        "0.0"
    end

    def match? : Bool
      !!(ua =~ /BlackBerry|BB10/)
    end
  end
end
