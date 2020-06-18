module Browser
  class Device
    class Surface < Base
      @platform : Platform?

      def id : String
        "surface"
      end

      def name : String
        "Microsoft Surface"
      end

      def match? : Bool
        !!(platform.windows_rt? && ua =~ /Touch/)
      end

      private def platform
        @platform ||= Platform.new(ua)
      end
    end
  end
end
