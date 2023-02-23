module Browser
  class Device
    class Samsung < Base
      REGEX = /\(Linux.*?; Android.*?; (SAMSUNG )?(SM-[A-Z0-9]+).*?\)/i

      @@names : Hash(String, String)?

      def self.names
        @@names ||= YAML.parse({{ read_file "data/samsung.yml" }})
          .as_h
          .transform_keys(&.as_s)
          .transform_values(&.as_s)
      end

      def id : String
        "samsung"
      end

      def name : String
        "Samsung #{self.class.names[code]? || code}"
      end

      def code
        matches ? matches.not_nil![2]? : "Unknown"
      end

      @matches : Regex::MatchData?

      def matches
        @matches ||= ua.match(REGEX)
      end

      def match? : Bool
        !!matches
      end
    end
  end
end
