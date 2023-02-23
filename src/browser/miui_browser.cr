module Browser
  class MiuiBrowser < Base
    def id : String
      "miui_browser"
    end

    def name : String
      "MiuiBrowser"
    end

    def full_version : String
      ua[%r{MiuiBrowser/([\d.]+)}, 1]? || "0.0"
    end

    def match? : Bool
      ua.includes?("MiuiBrowser")
    end
  end
end
