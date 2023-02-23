module Browser
  class Device
    class Xbox360 < Base
      def id : String
        "xbox_360"
      end

      def name : String
        "Xbox 360"
      end

      def match? : Bool
        ua.matches?(/Xbox/i)
      end
    end
  end
end
