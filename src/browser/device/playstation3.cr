module Browser
  class Device
    class PlayStation3 < Base
      def id : String
        "ps3"
      end

      def name : String
        "PlayStation 3"
      end

      def match? : Bool
        !!(ua =~ /PLAYSTATION 3/i)
      end
    end
  end
end
