module Browser
  class Device
    class Kindle < Base
      def id : String
        "kindle"
      end

      def name : String
        "Kindle"
      end

      def match? : Bool
        ua.includes?("Kindle")
      end
    end
  end
end
