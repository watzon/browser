require "./matcher"

module Browser
  class Bot
    class KnownBotsMatcher < Matcher
      def self.call(ua, _browser)
        Browser::Bot.bots.any? {|key, _| ua.include?(key) }
      end
    end
  end
end
