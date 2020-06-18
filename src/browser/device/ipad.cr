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
        !!(ua =~ /iPad/)
      end
    end
  end
end
