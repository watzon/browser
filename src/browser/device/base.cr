module Browser
  class Device
    abstract class Base
      getter ua : String

      def initialize(@ua)
      end

      abstract def match? : Bool
    end
  end
end
