module Browser
  class AcceptLanguage
    getter part : String

    @full : String?
    @code : String?
    @region : String?
    @quality : Float64?

    @@languages : Hash(String, String)?

    def initialize(part)
      @part = part
    end

    def self.languages
      @@languages ||= YAML.parse(File.read("data/languages.yml")).as_h
        .transform_keys(&.as_s)
        .transform_values(&.as_s)
    end

    def self.parse(accept_language)
      return [] of AcceptLanguage unless accept_language

      accept_language
        .split(",")
        .map {|string| string.squeeze(" ").strip }
        .map {|part| new(part) }
        .reject {|al| al.quality.zero? }
        .map_with_index { |al, i| {al, i} }
        .sort_by { |al, i| [-al.quality, i] }
        .map(&.[0])
    end

    def full
      @full ||= [code, region].compact.join("-")
    end

    def name
      self.class.languages[full]? || self.class.languages[code]?
    end

    def code
      @code ||= begin
        code = part[/\A([^-;]+)/, 1]
        code.try &.downcase
      end
    end

    def region
      @region ||= begin
        region = part[/\A(?:.*?)-([^;-]+)/, 1]?
        region.try &.upcase
      end
    end

    def quality
      @quality ||= begin
        Float64.new(quality_value || 1.0)
      rescue ArgumentError
        0.1
      end
    end

    private def quality_value
      qvalue = part[/;q=([\d.]+)/, 1]?
      return unless qvalue
      qvalue = qvalue =~ /\A0\.0?\z/ ? "0.0" : qvalue
      qvalue = qvalue.gsub(/\.+/, ".") if qvalue
      qvalue
    end
  end
end
