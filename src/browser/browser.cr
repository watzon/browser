require "./version"
require "./check_version"
require "./accept_language"
require "./base"
require "./safari"
require "./chrome"
require "./internet_explorer"
require "./firefox"
require "./edge"
require "./opera"
require "./blackberry"
require "./unknown"
require "./phantom_js"
require "./uc_browser"
require "./nokia"
require "./micro_messenger"
require "./weibo"
require "./qq"
require "./alipay"
require "./electron"
require "./facebook"
require "./otter"
require "./instagram"
require "./yandex"
require "./sputnik"
require "./snapchat"
require "./duck_duck_go"
require "./samsung_browser"
require "./huawei_browser"
require "./miui_browser"
require "./maxthon"
require "./sougou_browser"
require "./google_search_app"

require "./bot"
require "./bot/empty_user_agent_matcher"
require "./bot/keyword_matcher"
require "./bot/known_bots_matcher"

# require "./middleware"
require "./platform"
require "./device"
require "./meta"

module Browser
  EMPTY_STRING = ""

  def self.root
    @@root ||= Path[File.expand_path("../..", __DIR__)]
  end

  class_getter user_agent_size_limit : Int32 = 2048
  class_getter accept_language_size_limit : Int32 = 2048

  # Hold the list of browser matchers.
  # Order is important.
  def self.matchers
    @@matchers ||= [
      Nokia,
      UCBrowser,
      PhantomJS,
      BlackBerry,
      Opera,
      Edge,
      InternetExplorer,
      Firefox,
      Otter,
      Facebook,        # must be placed before Chrome and Safari
      Instagram,       # must be placed before Chrome and Safari
      Snapchat,        # must be placed before Chrome and Safari
      Weibo,           # must be placed before Chrome and Safari
      MicroMessenger,  # must be placed before QQ
      QQ,              # must be placed before Chrome and Safari
      Alipay,          # must be placed before Chrome and Safari
      Electron,        # must be placed before Chrome and Safari
      Yandex,          # must be placed before Chrome and Safari
      Sputnik,         # must be placed before Chrome and Safari
      DuckDuckGo,      # must be placed before Chrome and Safari
      SamsungBrowser,  # must be placed before Chrome and Safari
      HuaweiBrowser,   # must be placed before Chrome and Safari
      MiuiBrowser,     # must be placed before Chrome and Safari
      Maxthon,         # must be placed before Chrome and Safari
      SougouBrowser,   # must be placed before Chrome and Safari
      GoogleSearchApp, # must be placed before Chrome and Safari
      Chrome,
      Safari,
      Unknown,
    ]
  end

  def self.new(user_agent, **kwargs)
    matchers
      .map { |klass| klass.new(user_agent || EMPTY_STRING, **kwargs) }
      .find(&.match?)
      .not_nil! # TODO: remove
  end
end
