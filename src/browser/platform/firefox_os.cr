module Browser
  class Platform
    class FirefoxOS < Base
      def version : String
        "0"
      end

      def name : String
        "Firefox OS"
      end

      def id : String
        "firefox_os"
      end

      def match? : Bool
        !!(ua !~ /(Android|Linux|BlackBerry|Windows|Mac)/ && ua =~ /Firefox/)
      end
    end
  end
end
