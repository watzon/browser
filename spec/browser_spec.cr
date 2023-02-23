require "./spec_helper"

Spectator.describe Browser do
  it "should set the user agent when instantiating" do
    browser = Browser.new("Safari")
    expect(browser.ua).to eq("Safari")
  end

  it "should not fail with a nil user agent" do
    browser = Browser.new(nil)
    expect(browser.known?).to be_false
  end

  {% for ua in %w[
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
               ] %}
    it "should not fail with no version info ({{ ua.id }})" do
      browser = Browser.new({{ ua }})
      expect(browser.version).to eq("0")
      expect(browser.full_version).to eq("0.0")
    end
  {% end %}

  it "detects android" do
    browser = Browser.new(Browser["ANDROID"])

    expect(browser.name).to eq("Safari")
    expect(browser.platform.android?).to be_true
    expect(browser.safari?).to be_true
    expect(browser.webkit?).to be_true
    expect(browser.full_version).to eq("3.1.2")
    expect(browser.version).to eq("3")
  end

  it "detects android tablet" do
    browser = Browser.new(Browser["TABLOID"])

    expect(browser.name).to eq("Safari")
    expect(browser.platform.android?).to be_true
    expect(browser.safari?).to be_true
    expect(browser.webkit?).to be_true
    expect(browser.full_version).to eq("4.0")
    expect(browser.version).to eq("4")
  end

  it "detects surface tablet" do
    browser = Browser.new(Browser["SURFACE"])

    expect(browser.name).to eq("Internet Explorer")
    expect(browser.device.surface?).to be_true
    expect(browser.ie?).to be_true
    expect(browser.full_version).to eq("10.0")
    expect(browser.version).to eq("10")
  end

  it "detects quicktime" do
    browser = Browser.new(Browser["QUICKTIME"])

    expect(browser.name).to eq("QuickTime")
    expect(browser.quicktime?).to be_true
    expect(browser.full_version).to eq("7.6.8")
    expect(browser.quicktime?(">=7.0.0")).to be_true
  end

  it "detects core media" do
    browser = Browser.new(Browser["COREMEDIA"])

    expect(browser.name).to eq("Apple CoreMedia")
    expect(browser.core_media?).to be_true
    expect(browser.full_version).to eq("1.0.0.10")
    expect(browser.version).to eq("1")

    expect(browser.core_media?(">=1.0.0")).to be_true
    expect(browser.core_media?("<2.0.0")).to be_true
  end

  it "detects phantom js" do
    browser = Browser.new(Browser["PHANTOM_JS"])

    expect(browser.name).to eq("PhantomJS")
    expect(browser.id).to eq("phantom_js")
    expect(browser.phantom_js?).to be_true
    expect(browser.full_version).to eq("1.9.0")
    expect(browser.version).to eq("1")
  end

  it "should return a zero version" do
    browser = Browser.new("Bot")
    expect(browser.full_version).to eq("0.0")
    expect(browser.version).to eq("0")
  end

  it "should successfully compare version strings" do
    browser = Browser.new("Chrome/65.0.3325.99")
    expect(browser.chrome?("65.0.3325.99")).to be_true
    expect(browser.chrome?(">=65")).to be_true
    expect(browser.chrome?(">66")).to be_false
    expect(browser.chrome?("<65")).to be_false
  end

  it "should ignore malformed strings when comparing versions" do
    browser = Browser.new("Chrome/65.0.3325.99.FreeBrowser.3.0.5")
    expect(browser.chrome?(">=65")).to be_false
  end

  it "detects unknown browser" do
    browser = Browser.new("Unknown")
    expect(browser.unknown?).to be_true
    expect(browser.known?).to be_false
    expect(browser.id).to eq("unknown_browser")
    expect(browser.name).to eq("Unknown Browser")
  end

  it "returns an empty language set for missing accept language" do
    browser = Browser.new("")
    expect(browser.accept_language).to be_empty
  end

  it "sets accept language when instantiating" do
    browser = Browser.new("", accept_language: "pt-br")
    expect(browser.accept_language.map(&.full)).to contain("pt-BR")
  end

  it "returns all known languages" do
    accept_language = "en-us,en;q=0.8,pt-br;q=0.5,pt;q=0.3"
    browser = Browser.new("", accept_language: accept_language)
    languages = browser.accept_language.map(&.full)

    expect(languages).to eq(["en-US", "en", "pt-BR", "pt"])
  end

  it "removes duplicate items" do
    browser = Browser.new(Browser["SAFARI"])
    expect(browser.meta.select { |item| item == "safari" }).to eq(["safari"])
  end

  it "detects meta aliased as to_a" do
    browser = Browser.new(Browser["SAFARI"])
    expect(browser.meta).to eq(browser.to_a)
  end

  it "knows a supported browser" do
    browser = Browser.new("Chrome")
    expect(browser.known?).to be_true
  end

  it "does not know an unsupported browser" do
    browser = Browser.new("Fancy new browser")
    expect(browser.known?).to be_false
  end

  it "rejects a user agent larger than 2048 bytes" do
    expect_raises Exception, "user_agent cannot be larger than 2048 bytes; actual size is 2049 bytes" do
      Browser.new("a" * 2049)
    end
  end

  it "rejects accept language larger than 2048 bytes" do
    expect_raises Exception, "accept_language cannot be larger than 2048 bytes; actual size is 2049 bytes" do
      Browser.new("", accept_language: "a" * 2049)
    end
  end
end
