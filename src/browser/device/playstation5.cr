module Browser
  class Device
    class PlayStation5 < Base
      def id : String
        "ps5"
      end

      def name : String
        "PlayStation 5"
      end

      def match? : Bool
        ua.matches?(/PLAYSTATION 5/i)
      end
    end
  end
end
