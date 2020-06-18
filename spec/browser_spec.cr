require "./spec_helper"

describe Browser do
  it "should set the user agent when instantiating" do
    browser = Browser.new("Safari")
    browser.ua.should eq("Safari")
  end

  it "should not fail with a nil user agent" do
    browser = Browser.new(nil)
    browser.known?.should be_false
  end

  %w[
    BlackBerry
    Chrome
    Edge
    Firefox
    MSIE
    Opera
    PhantomJS
    S40OviBrowser
    Safari
    UCBrowser
  ].each do |ua|
    it "should not fail with no version info (#{ua})" do
      browser = Browser.new(ua)
      browser.version.should eq("0")
      browser.full_version.should eq("0.0")
    end
  end

  it "detects android" do
    browser = Browser.new(Browser["ANDROID"])

    browser.name.should eq("Safari")
    browser.platform.android?.should be_true
    browser.safari?.should be_true
    browser.webkit?.should be_true
    browser.full_version.should eq("3.1.2")
    browser.version.should eq("3")
  end

  it "detects android tablet" do
    browser = Browser.new(Browser["TABLOID"])

    browser.name.should eq("Safari")
    browser.platform.android?.should be_true
    browser.safari?.should be_true
    browser.webkit?.should be_true
    browser.full_version.should eq("4.0")
    browser.version.should eq("4")
  end

  it "detects surface tablet" do
    browser = Browser.new(Browser["SURFACE"])

    browser.name.should eq("Internet Explorer")
    browser.device.surface?.should be_true
    browser.ie?.should be_true
    browser.full_version.should eq("10.0")
    browser.version.should eq("10")
  end

  it "detects quicktime" do
    browser = Browser.new(Browser["QUICKTIME"])

    browser.name.should eq("QuickTime")
    browser.quicktime?.should be_true
    browser.full_version.should eq("7.6.8")
    browser.quicktime?(">=7.0.0").should be_true
  end

  it "detects core media" do
    browser = Browser.new(Browser["COREMEDIA"])

    browser.name.should eq("Apple CoreMedia")
    browser.core_media?.should be_true
    browser.full_version.should eq("1.0.0.10")
    browser.version.should eq("1")

    browser.core_media?(">=1.0.0").should be_true
    browser.core_media?("<2.0.0").should be_true
  end

  it "detects phantom js" do
    browser = Browser.new(Browser["PHANTOM_JS"])

    browser.name.should eq("PhantomJS")
    browser.id.should eq("phantom_js")
    browser.phantom_js?.should be_true
    browser.full_version.should eq("1.9.0")
    browser.version.should eq("1")
  end

  it "should return a zero version" do
    browser = Browser.new("Bot")
    browser.full_version.should eq("0.0")
    browser.version.should eq("0")
  end

  pending "should ignore malformed strings when comparing versions" do
    browser = Browser.new("Chrome/65.0.3325.99.FreeBrowser.3.0.5")
    browser.chrome?(">=65.0.0").should be_false
  end

  it "detects unknown browser" do
    browser = Browser.new("Unknown")
    browser.unknown?.should be_true
    browser.known?.should be_false
    browser.id.should eq("unknown_browser")
    browser.name.should eq("Unknown Browser")
  end

  it "returns an empty language set for missing accept language" do
    browser = Browser.new("")
    browser.accept_language.should be_empty
  end

  it "sets accept language when instantiating" do
    browser = Browser.new("", accept_language: "pt-br")
    browser.accept_language.map(&.full).should contain("pt-BR")
  end

  it "returns all known languages" do
    accept_language = "en-us,en;q=0.8,pt-br;q=0.5,pt;q=0.3"
    browser = Browser.new("", accept_language: accept_language)
    languages = browser.accept_language.map(&.full)

    languages.should eq(["en-US", "en", "pt-BR", "pt"])
  end

  it "removes duplicate items" do
    browser = Browser.new(Browser["SAFARI"])
    browser.meta.select { |item| item == "safari" }.should eq(["safari"])
  end

  it "knows a supported browser" do
    browser = Browser.new("Chrome")
    browser.known?.should be_true
  end

  it "does not know an unsupported browser" do
    browser = Browser.new("Fancy new browser")
    browser.known?.should be_false
  end
end
