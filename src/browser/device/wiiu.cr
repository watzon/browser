module Browser
  class Device
    class WiiU < Base
      def id : String
        "wiiu"
      end

      def name : String
        "Nintendo WiiU"
      end

      def match? : Bool
        ua.matches?(/Nintendo WiiU/i)
      end
    end
  end
end
