module Browser
  class InternetExplorer < Base
    # https://msdn.microsoft.com/en-us/library/ms537503(v=vs.85).aspx#TriToken
    TRIDENT_MAPPING = {
      "4.0" => "8",
      "5.0" => "9",
      "6.0" => "10",
      "7.0" => "11",
      "8.0" => "12"
    }

    def id : String
      "ie"
    end

    def name : String
      "Internet Explorer"
    end

    def full_version : String
      "#{ie_version}.0"
    end

    def msie_full_version
      if match = ua.match(%r{MSIE ([\d.]+)|Trident/.*?; rv:([\d.]+)})
        $1? || $2? || "0.0"
      else
        "0.0"
      end
    end

    def msie_version
      msie_full_version.split(".").first
    end

    def match? : Bool
      msie? || modern_ie?
    end

    # Detect if IE is running in compatibility mode.
    def compatibility_view?
      trident_version && msie_version.to_i < (trident_version.to_i + 4)
    end

    private def ie_version
      TRIDENT_MAPPING[trident_version]? || msie_version
    end

    # Return the trident version.
    private def trident_version
      ua[%r{Trident/([0-9.]+)}, 1]?
    end

    private def msie?
      !!(ua =~ /MSIE/ && ua !~ /Opera/)
    end

    private def modern_ie?
      !!(ua =~ %r{Trident/.*?; rv:(.*?)})
    end
  end
end
