require "./platform/base"
require "./platform/ios"
require "./platform/linux"
require "./platform/windows"
require "./platform/mac"
require "./platform/windows_phone"
require "./platform/windows_mobile"
require "./platform/firefox_os"
require "./platform/blackberry"
require "./platform/android"
require "./platform/unknown"
require "./platform/chrome_os"
require "./platform/adobe_air"

module Browser
  class Platform
    include DetectVersion

    getter ua : String

    @subject : Platform::Base?

    def initialize(@ua)
    end

    # Hold the list of platform matchers.
    # Order is important.
    def self.matchers
      @@matchers ||= [
        AdobeAir,
        ChromeOS,
        WindowsMobile,
        WindowsPhone,
        Android,
        BlackBerry,
        IOS,
        Mac,
        FirefoxOS,
        Windows,
        Linux,
        Unknown
      ]
    end

    def subject
      @subject ||= self.class.matchers
                       .map {|matcher| matcher.new(ua, self) }
                       .find(&.match?)
                       .not_nil!
    end

    def adobe_air?(expected_version = nil)
      id == "adobe_air" && detect_version?(version, expected_version)
    end

    def chrome_os?(expected_version = nil)
      id == "chrome_os" && detect_version?(version, expected_version)
    end

    def android?(expected_version = nil)
      id == "android" && detect_version?(version, expected_version)
    end

    def unknown?
      id == "unknown_platform"
    end

    def linux?
      id == "linux"
    end

    def mac?(expected_version = nil)
      id == "mac" && detect_version?(version, expected_version)
    end

    def windows?(expected_version = nil)
      id == "windows" && detect_version?(version, expected_version)
    end

    def firefox_os?
      id == "firefox_os"
    end

    def ios?(expected_version = nil)
      id == "ios" && detect_version?(version, expected_version)
    end

    def blackberry?(expected_version = nil)
      id == "blackberry" && detect_version?(version, expected_version)
    end

    def windows_phone?(expected_version = nil)
      id == "windows_phone" && detect_version?(version, expected_version)
    end

    def windows_mobile?(expected_version = nil)
      id == "windows_mobile" && detect_version?(version, expected_version)
    end

    def id : String
      subject.id
    end

    def version
      subject.version
    end

    def name : String
      subject.name
    end

    def to_s
      id.to_s
    end

    def ==(other)
      id == other
    end

    # Detect if running on iOS app webview.
    def ios_app?
      ios? && !ua.includes?("Safari")
    end

    # Detect if is iOS webview.
    def ios_webview?
      ios_app?
    end

    # Detect if in an Android app webview (Lollipop and newer)
    # https://developer.chrome.com/multidevice/user-agent#webview_user_agent
    def android_app?
      android? && ua =~ /\bwv\b/
    end

    def android_webview?
      android_app?
    end

    # http://msdn.microsoft.com/fr-FR/library/ms537503.aspx#PltToken
    def windows_xp?
      windows? && ua =~ /Windows NT 5\.[12]/
    end

    def windows_vista?
      windows? && ua =~ /Windows NT 6\.0/
    end

    def windows7?
      windows? && ua =~ /Windows NT 6\.1/
    end

    def windows8?
      windows? && ua =~ /Windows NT 6\.[2-3]/
    end

    def windows8_1?
      windows? && ua =~ /Windows NT 6\.3/
    end

    def windows10?
      windows? && ua =~ /Windows NT 10/
    end

    def windows_rt?
      windows8? && ua =~ /ARM/
    end

    # Detect if current platform is Windows in 64-bit architecture.
    def windows_x64?
      windows? && ua =~ /(Win64|x64|Windows NT 5\.2)/
    end

    def windows_wow64?
      windows? && ua =~ /WOW64/i
    end

    def windows_x64_inclusive?
      windows_x64? || windows_wow64?
    end

    def windows_touchscreen_desktop?
      windows? && ua =~ /Touch/
    end
  end
end
