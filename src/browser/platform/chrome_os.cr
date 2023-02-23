module Browser
  class Platform
    class ChromeOS < Base
      def match? : Bool
        ua.includes?("CrOS")
      end

      def name : String
        "Chrome OS"
      end

      def id : String
        "chrome_os"
      end

      def version : String
        ua[/CrOS(?: x86_64)? ([\d.]+)/, 1]
      end
    end
  end
end
