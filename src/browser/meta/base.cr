module Browser
  module Meta
    def self.rules
      @@rules ||= [
        Device,
        GenericBrowser,
        Id,
        IE,
        IOS,
        Mobile,
        Platform,
        Proxy,
        Safari,
        Tablet,
        Webkit,
      ]
    end

    def self.get(browser)
      rules.each_with_object(Set(String).new) do |rule, meta|
        meta.concat(rule.new(browser).to_a)
      end.to_a
    end

    class Base
      # Set the browser instance.
      getter browser : Browser::Base

      def initialize(@browser)
      end

      def meta
        nil
      end

      def to_a
        meta.to_s.squeeze(" ").split(" ")
      end
    end
  end
end
