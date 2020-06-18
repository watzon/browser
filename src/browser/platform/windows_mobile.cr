module Browser
  class Platform
    class WindowsMobile < Base
      def version : String
        "0"
      end

      def name : String
        "Windows Mobile"
      end

      def id : String
        "windows_mobile"
      end

      def match? : Bool
        !!(ua =~ /Windows CE/)
      end
    end
  end
end
