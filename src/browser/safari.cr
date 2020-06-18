module Browser
  class Safari < Base
    def id : String
      "safari"
    end

    def name : String
      "Safari"
    end

    def full_version : String
      ua[%r{Version/([\d.]+)}, 1]? ||
        ua[%r{Safari/([\d.]+)}, 1]? ||
        ua[%r{AppleWebKit/([\d.]+)}, 1]? ||
        "0.0"
    end

    def match? : Bool
      !!(ua =~ /Safari/ &&
         ua !~ /PhantomJS|FxiOS/ &&
         !edge? &&
         !chrome? &&
         !samsung_browser? &&
         !duck_duck_go? &&
         !yandex? &&
         !sputnik?)
    end
  end
end
