# Browser

Browser is a library for browser detection in Crystal. Heavily based off of [fnando/browser](https://github.com/fnando/browser).

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     browser:
       github: watzon/browser
   ```

2. Run `shards install`

## Usage

```crystal
require "browser"

browser = Browser.new("Some User Agent", accept_language: "en-us")

# General info
browser.bot?
browser.chrome?
browser.core_media?
browser.duck_duck_go?
browser.edge?                # Newest MS browser
browser.electron?            # Electron Framework
browser.firefox?
browser.full_version
browser.ie?
browser.ie?("~6.0.0")        # detect specific IE version
browser.ie?(">=9.0.0"])      # detect specific IE (IE9).
browser.known?               # has the browser been successfully detected?
browser.unknown?             # the browser wasn't detected.
browser.meta                 # an array with several attributes
browser.name                 # readable browser name
browser.nokia?
browser.opera?
browser.opera_mini?
browser.phantom_js?
browser.quicktime?
browser.safari?
browser.safari_webapp_mode?
browser.samsung_browser?
browser.to_s            # the meta info joined by space
browser.uc_browser?
browser.version         # major version number
browser.webkit?
browser.webkit_full_version
browser.yandex?
browser.wechat?
browser.weibo?
browser.yandex?
browser.sputnik?

# Get bot info
browser.bot.name
browser.bot.search_engine?
browser.bot?
browser.bot.why? # shows which matcher detected this user agent as a bot.
Browser::Bot.why?(ua)

# Get device info
browser.device
browser.device.id
browser.device.name
browser.device.unknown?
browser.device.blackberry_playbook?
browser.device.console?
browser.device.ipad?
browser.device.iphone?
browser.device.ipod_touch?
browser.device.kindle?
browser.device.kindle_fire?
browser.device.mobile?
browser.device.nintendo?
browser.device.playstation?
browser.device.ps3?
browser.device.ps4?
browser.device.psp?
browser.device.silk?
browser.device.surface?
browser.device.tablet?
browser.device.tv?
browser.device.vita?
browser.device.wii?
browser.device.wiiu?
browser.device.switch?
browser.device.xbox?
browser.device.xbox_360?
browser.device.xbox_one?

# Get platform info
browser.platform
browser.platform.id
browser.platform.name
browser.platform.version  # e.g. 9 (for iOS9)
browser.platform.adobe_air?
browser.platform.android?
browser.platform.android?("~4.2.0") # detect Android Jelly Bean 4.2
browser.platform.android_app?       # detect webview in an Android app
browser.platform.android_webview?   # alias for android_app?
browser.platform.blackberry?
browser.platform.blackberry?("10.0.0") # detect specific BlackBerry version
browser.platform.chrome_os?
browser.platform.firefox_os?
browser.platform.ios?     # detect iOS
browser.platform.ios?("9.0.0")  # detect specific iOS version
browser.platform.ios_app?       # detect webview in an iOS app
browser.platform.ios_webview?   # alias for ios_app?
browser.platform.linux?
browser.platform.mac?
browser.platform.unknown?
browser.platform.windows10?
browser.platform.windows7?
browser.platform.windows8?
browser.platform.windows8_1?
browser.platform.windows?
browser.platform.windows_mobile?
browser.platform.windows_phone?
browser.platform.windows_rt?
browser.platform.windows_touchscreen_desktop?
browser.platform.windows_vista?
browser.platform.windows_wow64?
browser.platform.windows_x64?
browser.platform.windows_x64_inclusive?
browser.platform.windows_xp?
```

### What's being detected?
- For a list of platform detections, check [src/browser/platform.rb](./src/browser/platform.rb)
- For a list of device detections, check [src/browser/device.rb](./src/browser/device.rb)
- For a list of bot detections, check [data/bots.yml](./data/bots.yml)

### Detecting modern browsers

To detect whether a browser can be considered as modern or not, create a method that abstracts your versioning constraints. The following example will consider any of the following browsers as a modern:

```crystal
# Expects an Browser instance,
# like in `Browser.new(user_agent, accept_language: language)`.
def modern_browser?(browser)
  browser.chrome?(">= 65.0.0"),
  browser.safari?(">= 10.0.0"),
  browser.firefox?(">= 52.0.0"),
  browser.ie?(">= 11.0.0") && !browser.compatibility_view?,
  browser.edge?(">= 15.0.0"),
  browser.opera?(">= 50.0.0"),
  browser.facebook? &&
    browser.safari_webapp_mode? &&
    browser.webkit_full_version.split('.').first.to_i >= 602
end
```

### Lucky Framework integration

**Coming soon!**

### Accept Language

Parses the accept-language header from an HTTP request and produces an array of language objects sorted by quality.

```crystal
browser = Browser.new("Some User Agent", accept_language: "en-us")

browser.accept_language.class
#=> Array(Browser::AcceptLanguage)

language = browser.accept_language.first

language.code
#=> "en"

language.region
#=> "US"

language.full
#=> "en-US"

language.quality
#=> 1.0

language.name
#=> "English/United States"
```

Result is always sorted in quality order from highest to lowest. As per the HTTP spec:

- omitting the quality value implies 1.0.
- quality value equal to zero means that is not accepted by the client.

### Internet Explorer

Internet Explorer has a compatibility view mode that allows newer versions (IE8+) to run as an older version. Browser will always return the navigator version, ignoring the compatibility view version, when defined. If you need to get the engine's version, you have to use Browser#msie_version and Browser#msie_full_version.

So, let's say an user activates compatibility view in a IE11 browser. This is what you'll get:

```crystal
browser.version
#=> 11

browser.full_version
#=> 11.0

browser.msie_version
#=> 7

browser.msie_full_version
#=> 7.0

browser.compatibility_view?
#=> true
```

This behavior changed in v1.0.0; previously there wasn't a way of getting the real browser version.

### Safari

iOS webviews and web apps aren't detected as Safari, so be aware of that if that's your case. You can use a combination of platform and webkit detection to do whatever you want.

```crystal
# iPad's Safari running as web app mode.
browser = Browser.new("Mozilla/5.0 (iPad; U; CPU OS 3_2_1 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Mobile/7B405")

browser.safari?
#=> false

browser.webkit?
#=> true

browser.platform.ios?
#=> true
```

### Bots

The bot detection is quite aggressive. Anything that matches at least one of the following requirements will be considered a bot.

- Empty user agent string
- User agent that matches `/crawl|fetch|search|monitoring|spider|bot/`
- Any known bot listed under [data/bots.yml](./data/bots.yml)

To add custom matchers, you can extend the `Browser::Bot::Matcher` class and add it to `Browser::Bot.matchers`. The following example matches everything that has an `externalhit` substring on it. The bot name will always be General Bot.

```crystal
class ExternalHitMatcher < Browser::Bot::Matcher
  def self.call(ua, _browser)
    !!(ua =~ /externalhit/i)
  end
end

Browser::Bot.matchers << ExternalHitMatcher
```

To clear all matchers, including the ones that are bundled, use `Browser::Bot.matchers.clear`. You can re-add built-in matchers by doing the following:

```crystal
Browser::Bot.matchers += Browser::Bot.default_matchers
```

### Kemal Middleware

**Coming soon!**

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/watzon/browser/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Chris Watson](https://github.com/watzon) - creator and maintainer

## License

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.