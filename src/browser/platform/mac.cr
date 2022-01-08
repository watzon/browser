module Browser
  class Platform
    class Mac < Base
      def version : String
        (ua[/Mac OS X\s*([0-9_\.]+)?/, 1] || "0").tr("_", ".")
      end

      def name : String
        return "macOS" if platform.try(&.mac?(">= 10.12"))

        "Mac OS X"
      end

      def id : String
        "mac"
      end

      def match? : Bool
        !!(ua =~ /Mac/)
      end
    end
  end
end
