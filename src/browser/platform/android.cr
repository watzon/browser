module Browser
  class Platform
    class Android < Base
      def match? : Bool
        ua.includes?("Android") && !ua.includes?("KAIOS")
      end

      def name : String
        "Android"
      end

      def id : String
        "android"
      end

      def version : String
        ua[/Android ([\d.]+)/, 1]? || "0.0"
      end
    end
  end
end
