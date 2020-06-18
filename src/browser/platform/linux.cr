module Browser
  class Platform
    class Linux < Base
      def version : String
        "0"
      end

      def name : String
        "Generic Linux"
      end

      def id : String
        "linux"
      end

      def match? : Bool
        !!(ua =~ /Linux/)
      end
    end
  end
end
