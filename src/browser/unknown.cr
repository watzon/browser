module Browser
  class Unknown < Base
    NAMES = {
      "QuickTime" => "QuickTime",
      "CoreMedia" => "Apple CoreMedia"
    }

    def id : String
      "unknown_browser"
    end

    def name : String
      infer_name || "Unknown Browser"
    end

    def full_version : String
      ua[%r{(?:QuickTime)/([\d.]+)}, 1]? ||
        ua[/CoreMedia v([\d.]+)/, 1]? ||
        "0.0"
    end

    def match? : Bool
      true
    end

    private def infer_name
      (NAMES.find { |key, _| ua.includes?(key) } || [] of String).last?
    end
  end
end
