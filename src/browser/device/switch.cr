module Browser
  class Device
    class Switch < Base
      def id : String
        "switch"
      end

      def name : String
        "Nintendo Switch"
      end

      def match? : Bool
        !!(ua =~ /Nintendo Switch/i)
      end
    end
  end
end
