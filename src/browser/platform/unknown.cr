module Browser
  class Platform
    class Unknown < Base
      def version : String
        "0"
      end

      def name : String
        "Unknown"
      end

      def id : String
        "unknown_platform"
      end

      def match? : Bool
        true
      end
    end
  end
end
