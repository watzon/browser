module Browser
  class Bot
    GENERIC_NAME = "Generic Bot"

    private getter ua : String
    private getter browser : Browser::Base

    def initialize(ua)
      @ua = ua.downcase.strip
      @browser = Browser.new(@ua)
    end

    @@matchers : Array(Bot::Matcher.class)?

    def self.matchers
      @@matchers ||= default_matchers
    end

    def self.default_matchers
      [
        EmptyUserAgentMatcher,
        KnownBotsMatcher,
        KeywordMatcher,
      ]
    end

    @@bots : Hash(String, String)?

    def self.bots
      @@bots ||= YAML.parse({{ read_file "data/bots.yml" }})
        .as_h
        .transform_keys(&.as_s)
        .transform_values(&.as_s)
    end

    @@bot_exceptions : Array(String)?

    def self.bot_exceptions
      @@bot_exceptions ||= YAML.parse({{ read_file "data/bot_exceptions.yml" }})
        .as_a.map(&.as_s)
    end

    @@search_engines : Hash(String, String)?

    def self.search_engines
      @@search_engines ||= YAML.parse({{ read_file "data/search_engines.yml" }})
        .as_h
        .transform_keys(&.as_s)
        .transform_values(&.as_s)
    end

    def self.why?(ua)
      ua = ua.downcase.strip
      browser = Browser.new(ua)
      matchers.find { |matcher| matcher.call(ua, browser) }
    end

    def bot?
      !bot_exception? && detect_bot?
    end

    def why?
      self.class.matchers.find { |matcher| matcher.call(ua, self) }
    end

    def search_engine?
      self.class.search_engines.any? { |key, _| ua.includes?(key) }
    end

    def name : String
      return unless bot?

      self.class.bots.find { |key, _| ua.includes?(key) }.try &.last || GENERIC_NAME
    end

    private def bot_exception?
      self.class.bot_exceptions.any? { |key| ua.includes?(key) }
    end

    private def detect_bot?
      self.class.matchers.any? { |matcher| matcher.call(ua, browser) }
    end
  end
end
