require "./matcher"

module Browser
  class Bot
    class KeywordMatcher < Matcher
      def self.call(ua, _browser)
        ua.matches?(/crawl|fetch|search|monitoring|spider|bot/)
      end
    end
  end
end
