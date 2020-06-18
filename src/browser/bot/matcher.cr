module Browser
  class Bot
    abstract class Matcher
      def self.call(ua : String, browser : Browser) : Bool
        raise "Not implemented"
      end
    end
  end
end
