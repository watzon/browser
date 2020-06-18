module Browser
  class Platform
    class WindowsPhone < Base
      def version : String
        ua[/Windows Phone ([\d.]+)/, 1]
      end

      def name : String
        "Windows Phone"
      end

      def id : String
        "windows_phone"
      end

      def match? : Bool
        !!(ua =~ /Windows Phone/)
      end
    end
  end
end
