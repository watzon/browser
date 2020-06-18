module Browser
  class Device
    class KindleFire < Base
      def id : String
        "kindle_fire"
      end

      def name : String
        "Kindle Fire"
      end

      def match? : Bool
        !!(ua =~ /Kindle Fire|KFTT/)
      end
    end
  end
end
