module Browser
  class Platform
    class AdobeAir < Base
      def match? : Bool
        ua.includes?("AdobeAIR")
      end

      def version : String
        ua[%r{AdobeAIR/([\d.]+)}, 1]
      end

      def name : String
        "Adobe AIR"
      end

      def id : String
        "adobe_air"
      end
    end
  end
end
