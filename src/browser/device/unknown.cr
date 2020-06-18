module Browser
  class Device
    class Unknown < Base
      def id : String
        "unknown_device"
      end

      def name : String
        "Unknown"
      end

      def match? : Bool
        !!(true)
      end
    end
  end
end
