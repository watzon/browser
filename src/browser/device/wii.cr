module Browser
  class Device
    class Wii < Base
      def id : String
        "wii"
      end

      def name : String
        "Nintendo Wii"
      end

      def match? : Bool
        ua.matches?(/Nintendo Wii/i)
      end
    end
  end
end
