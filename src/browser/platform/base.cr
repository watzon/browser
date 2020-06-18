module Browser
  class Platform
    abstract class Base
      getter ua : String
      getter platform : Platform?

      def initialize(@ua, @platform = nil)
      end

      abstract def id : String
      abstract def name : String
      abstract def version : String
      abstract def match? : Bool
    end
  end
end
