module Browser
  class Device
    class IpodTouch < Base
      def id : String
        "ipod_touch"
      end

      def name : String
        "iPod Touch"
      end

      def match? : Bool
        ua.includes?("iPod")
      end
    end
  end
end
