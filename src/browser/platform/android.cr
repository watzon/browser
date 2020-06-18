module Browser
  class Platform
    class Android < Base
      def match? : Bool
        !!(ua =~ /Android/)
      end

      def name : String
        "Android"
      end

      def id : String
        "android"
      end

      def version : String
        ua[/Android ([\d.]+)/, 1]
      end
    end
  end
end
