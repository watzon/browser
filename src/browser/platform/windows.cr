module Browser
  class Platform
    class Windows < Base
      def version : String
        ua[/Windows NT\s*([0-9_\.]+)?/, 1] || "0"
      end

      def name : String
        "Windows"
      end

      def id : String
        "windows"
      end

      def match? : Bool
        ua.includes?("Windows")
      end
    end
  end
end
