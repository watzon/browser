module Browser
  class Platform
    class BlackBerry < Base
      def match? : Bool
        ua.matches?(/BB10|BlackBerry/)
      end

      def name : String
        "BlackBerry"
      end

      def id : String
        "blackberry"
      end

      def version : String
        ua[%r{(?:Version|BlackBerry[\da-z]+)/([\d.]+)}, 1]
      end
    end
  end
end
