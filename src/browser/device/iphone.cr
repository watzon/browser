module Browser
  class Device
    class Iphone < Base
      def id : String
        "iphone"
      end

      def name : String
        "iPhone"
      end

      def match? : Bool
        ua.includes?("iPhone")
      end
    end
  end
end
