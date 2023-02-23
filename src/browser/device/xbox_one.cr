module Browser
  class Device
    class XboxOne < Base
      def id : String
        "xbox_one"
      end

      def name : String
        "Xbox One"
      end

      def match? : Bool
        ua.matches?(/Xbox One/i)
      end
    end
  end
end
