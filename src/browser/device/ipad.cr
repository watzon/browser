module Browser
  class Device
    class Ipad < Base
      def id : String
        "ipad"
      end

      def name : String
        "iPad"
      end

      def match? : Bool
        ua.includes?("iPad")
      end
    end
  end
end
