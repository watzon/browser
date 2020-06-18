module Browser
  class Device
    class Android < Base
      def id : String
        "unknown"
      end

      def name : String
        ua[/\(Linux.*?; Android.*?; ([-_a-z0-9 ]+) Build[^)]+\)/i, 1] ||
          "Unknown"
      end

      def match? : Bool
        !!(ua =~ /Android/)
      end
    end
  end
end
