module Browser
  class Chrome < Base
    def id : String
      "chrome"
    end

    def name : String
      "Chrome"
    end

    def full_version : String
      # Each regex on its own line to enforce precedence.
      ua[%r{Chrome/([\d.]+)}, 1]? ||
      ua[%r{CriOS/([\d.]+)}, 1]? ||
      ua[%r{Safari/([\d.]+)}, 1]? ||
      ua[%r{AppleWebKit/([\d.]+)}, 1]? ||
      "0.0"
    end

    def match? : Bool
      !!(ua =~ /Chrome|CriOS/ &&
         ua !~ /PhantomJS|FxiOS|ArchiveBot/ &&
         !opera? &&
         !edge? &&
         !duck_duck_go? &&
         !yandex? &&
         !sputnik? &&
         !samsung_browser?)
    end
  end
end
