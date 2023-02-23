module Browser
  class Platform
    class KaiOS < Base
      def version : String
        ua[%r{KAIOS/([\d.]+)}, 1]? || "0.0"
      end

      def name : String
        "KaiOS"
      end

      def id : String
        "kai_os"
      end

      def match? : Bool
        ua.includes?("KAIOS")
      end
    end
  end
end
