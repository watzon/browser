require "./matcher"

module Browser
  class Bot
    class EmptyUserAgentMatcher < Matcher
      def self.call(ua, _browser)
        ua == ""
      end
    end
  end
end
