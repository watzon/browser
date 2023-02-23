require "./aliases"

module Browser
  abstract class Base
    include Aliases
    include DetectVersion

    getter ua : String

    # Return an array with all preferred languages that this browser accepts.
    getter accept_language : Array(AcceptLanguage)

    # Return an array with all preferred languages that this browser accepts.
    def initialize(ua : String, accept_language : String = "")
      validate_size(:user_agent, ua.to_s)
      @ua = ua

      validate_size(:accept_language, accept_language)
      @accept_language = AcceptLanguage.parse(accept_language)
    end

    abstract def id : String

    abstract def name : String

    abstract def full_version : String

    abstract def match? : Bool

    # Return a meta info about this browser.
    def meta
      Meta.get(self)
    end

    def to_a
      meta
    end

    # Return meta representation as string.
    def to_s
      meta.to_a.join(" ")
    end

    def version
      full_version.split(".").first
    end

    @platform : Platform?

    def platform
      @platform ||= Platform.new(ua)
    end

    @bot : Bot?

    def bot
      @bot ||= Bot.new(ua)
    end

    # Detect if current user agent is from a bot.
    def bot?
      bot.bot?
    end

    @device : Device?

    def device
      @device ||= Device.new(ua)
    end

    # Detect if browser is Microsoft Internet Explorer.
    def ie?(expected_version = nil)
      instance_of?(InternetExplorer) &&
        check_version?(full_version, expected_version)
    end

    # Detect if browser is Microsoft Edge.
    def edge?(expected_version = nil)
      instance_of?(Edge) && check_version?(full_version, expected_version)
    end

    def compatibility_view?
      false
    end

    def msie_full_version
      "0.0"
    end

    def msie_version
      "0"
    end

    # Detect if browser is Instagram.
    def instagram?(expected_version = nil)
      instance_of?(Instagram) &&
        check_version?(full_version, expected_version)
    end

    # Detect if browser is Snapchat.
    def snapchat?(expected_version = nil)
      instance_of?(Snapchat) &&
        check_version?(full_version, expected_version)
    end

    # Detect if browser if Facebook.
    def facebook?(expected_version = nil)
      instance_of?(Facebook) &&
        check_version?(full_version, expected_version)
    end

    # Detect if browser is Otter.
    def otter?(expected_version = nil)
      instance_of?(Otter) &&
        check_version?(full_version, expected_version)
    end

    # Detect if browser is WebKit-based.
    def webkit?(expected_version = nil)
      ua.matches?(/AppleWebKit/i) &&
        (!edge? || chromium_based?) &&
        check_version?(webkit_full_version, expected_version)
    end

    # Detect if browser is QuickTime
    def quicktime?(expected_version = nil)
      ua.matches?(/QuickTime/i) && check_version?(full_version, expected_version)
    end

    # Detect if browser is Apple CoreMedia.
    def core_media?(expected_version = nil)
      ua.includes?("CoreMedia") && check_version?(full_version, expected_version)
    end

    # Detect if browser is PhantomJS
    def phantom_js?(expected_version = nil)
      instance_of?(PhantomJS) &&
        check_version?(full_version, expected_version)
    end

    # Detect if browser is Safari.
    def safari?(expected_version = nil)
      instance_of?(Safari) && check_version?(full_version, expected_version)
    end

    def safari_webapp_mode?
      (device.ipad? || device.iphone?) && ua.includes?("AppleWebKit")
    end

    # Detect if browser is Firefox.
    def firefox?(expected_version = nil)
      instance_of?(Firefox) && check_version?(full_version, expected_version)
    end

    # Detect if browser is Chrome.
    def chrome?(expected_version = nil)
      instance_of?(Chrome) && check_version?(full_version, expected_version)
    end

    # Detect if browser is Opera.
    def opera?(expected_version = nil)
      instance_of?(Opera) && check_version?(full_version, expected_version)
    end

    # Detect if browser is Sputnik.
    def sputnik?(expected_version = nil)
      instance_of?(Sputnik) && check_version?(full_version, expected_version)
    end

    # Detect if browser is Yandex.
    def yandex?(expected_version = nil)
      instance_of?(Yandex) && check_version?(full_version, expected_version)
    end

    def yandex_browser?
      yandex?
    end

    # Detect if browser is UCBrowser.
    def uc_browser?(expected_version = nil)
      instance_of?(UCBrowser) &&
        check_version?(full_version, expected_version)
    end

    # Detect if browser is Nokia S40 Ovi Browser.
    def nokia?(expected_version = nil)
      instance_of?(Nokia) && check_version?(full_version, expected_version)
    end

    # Detect if browser is MicroMessenger.
    def micro_messenger?(expected_version = nil)
      instance_of?(MicroMessenger) &&
        check_version?(full_version, expected_version)
    end

    # :ditto:
    def wechat?
      micro_messenger?
    end

    def weibo?(expected_version = nil)
      instance_of?(Weibo) && check_version?(full_version, expected_version)
    end

    def alipay?(expected_version = nil)
      instance_of?(Alipay) && check_version?(full_version, expected_version)
    end

    # Detect if browser is Opera Mini.
    def opera_mini?(expected_version = nil)
      ua.includes?("Opera Mini") && check_version?(full_version, expected_version)
    end

    # Detect if browser is DuckDuckGo.
    def duck_duck_go?(expected_version = nil)
      ua.includes?("DuckDuckGo") && check_version?(full_version, expected_version)
    end

    # Detect if browser is Samsung.
    def samsung_browser?(expected_version = nil)
      ua.includes?("SamsungBrowser") && check_version?(full_version, expected_version)
    end

    # Detect if browser is Huawei.
    def huawei_browser?(expected_version = nil)
      instance_of?(HuaweiBrowser) &&
        check_version?(full_version, expected_version)
    end

    # Detect if browser is Xiaomi Miui.
    def miui_browser?(expected_version = nil)
      instance_of?(MiuiBrowser) &&
        check_version?(full_version, expected_version)
    end

    # Detect if browser is Maxthon.
    def maxthon?(expected_version = nil)
      instance_of?(Maxthon) && check_version?(full_version, expected_version)
    end

    # Detect if browser is QQ.
    def qq?(expected_version = nil)
      instance_of?(QQ) && check_version?(full_version, expected_version)
    end

    # Detect if browser is Sougou.
    def sougou_browser?(expected_version = nil)
      instance_of?(SougouBrowser) &&
        check_version?(full_version, expected_version)
    end

    # Detect if browser is Google Search App
    def google_search_app?(expected_version = nil)
      ua.includes?("GSA") && check_version?(full_version, expected_version)
    end

    # Detect if browser is Chromium-based.
    def chromium_based?
      false
    end

    def webkit_full_version
      ua[%r{AppleWebKit/([\d.]+)}, 1]? || "0.0"
    end

    def known?
      !unknown?
    end

    def unknown?
      id == "unknown_browser"
    end

    # Detect if browser is a proxy browser.
    def proxy?
      nokia? || uc_browser? || opera_mini?
    end

    # Detect if the browser is Electron.
    def electron?(expected_version = nil)
      instance_of?(Electron) && check_version?(full_version, expected_version)
    end

    private def instance_of?(klass)
      klass.new(ua).match?
    end

    private def validate_size(subject, input)
      actual_bytesize = input.bytesize
      size_limit = subject == :user_agent ? Browser.user_agent_size_limit : Browser.accept_language_size_limit

      return if actual_bytesize < size_limit

      raise Exception.new(
        "#{subject} cannot be larger than #{size_limit} bytes; " +
        "actual size is #{actual_bytesize} bytes")
    end
  end
end
