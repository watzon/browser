module Browser
  class Device
    class PlayStation4 < Base
      def id : String
        "ps4"
      end

      def name : String
        "PlayStation 4"
      end

      def match? : Bool
        !!(ua =~ /PLAYSTATION 4/i)
      end
    end
  end
end
