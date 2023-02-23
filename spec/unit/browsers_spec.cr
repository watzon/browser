require "../spec_helper"

Spectator.describe Browser do
  subject(browser) { Browser.new(Browser[name]) }

  # # ADOBE AIR ###############################################################
  provided name = "ADOBE_AIR" do
    expect(browser.webkit?).to be_true
    expect(browser.version).to eq("0")
    expect(browser.full_version).to eq("0.0")
    expect(browser.name).to eq("Unknown Browser")
    expect(browser.platform.version).to eq("13.0")
  end

  # # ALIPAY ##################################################################
  provided name = "ALIPAY_IOS" do
    expect(browser.id).to eq("alipay")
    expect(browser.alipay?).to be_true
    expect(browser.name).to eq("Alipay")
    expect(browser.full_version).to eq("2.3.4")

    expect(browser.chrome?).to be_false
    expect(browser.safari?).to be_false

    expect(browser.alipay?(">=2 <3"))
  end

  provided name = "ALIPAY_ANDROID" do
    expect(browser.id).to eq("alipay")
    expect(browser.alipay?).to be_true
    expect(browser.name).to eq("Alipay")
    expect(browser.full_version).to eq("9.0.1.073001")

    expect(browser.chrome?).to be_false
    expect(browser.safari?).to be_false
  end

  # # ANDROID #################################################################
  provided name = "ANDROID_WEBVIEW" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android_webview?).to be_true
  end

  it "does not detect non-webviews as webviews" do
    %w[
      ANDROID_CUPCAKE
      ANDROID_DONUT
      ANDROID_ECLAIR_21
      ANDROID_FROYO
      ANDROID_GINGERBREAD
      ANDROID_HONEYCOMB_30
      ANDROID_ICECREAM
      ANDROID_JELLYBEAN_41
      ANDROID_JELLYBEAN_42
      ANDROID_JELLYBEAN_43
      ANDROID_KITKAT
      ANDROID_LOLLIPOP_50
      ANDROID_LOLLIPOP_51
      ANDROID_TV
      ANDROID_NEXUS_PLAYER
      FIREFOX_ANDROID
    ].each do |name|
      expect(Browser.new(Browser[name]).platform.android_webview?).to be_false
    end
  end

  provided name = "ANDROID_CUPCAKE" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?(1.5)).to be_true
  end

  provided name = "ANDROID_DONUT" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?(1.6)).to be_true
  end

  provided name = "ANDROID_ECLAIR_21" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?(2.1)).to be_true
  end

  provided name = "ANDROID_FROYO" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?(2.2)).to be_true
  end

  provided name = "ANDROID_GINGERBREAD" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?("~> 2.3.0")).to be_true
  end

  provided name = "ANDROID_HONEYCOMB_30" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?("~> 3.0")).to be_true
  end

  provided name = "ANDROID_ICECREAM" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?("~> 4.0")).to be_true
  end

  provided name = "ANDROID_JELLYBEAN_41" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?("~> 4.1")).to be_true
  end

  provided name = "ANDROID_JELLYBEAN_42" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?(4.2)).to be_true
  end

  provided name = "ANDROID_JELLYBEAN_43" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?(4.3)).to be_true
  end

  provided name = "ANDROID_KITKAT" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?(4.4)).to be_true
  end

  provided name = "ANDROID_LOLLIPOP_50" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?(5.0)).to be_true
  end

  provided name = "ANDROID_LOLLIPOP_51" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?(5.1)).to be_true
  end

  provided name = "ANDROID_OREO" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?(8.0)).to be_true
  end

  provided name = "ANDROID_TV" do
    expect(browser.platform.android?).to be_true
    expect(browser.device.tv?).to be_true
  end

  provided name = "ANDROID_NEXUS_PLAYER" do
    expect(browser.platform.android?).to be_true
  end

  provided name = "FIREFOX_ANDROID" do
    expect(browser.platform.android?).to be_true
    expect(browser.platform.android?(5)).to be_false
  end

  # # BLACKBERRY ##############################################################
  provided name = "BLACKBERRY" do
    expect(browser.name).to eq("BlackBerry")
    expect(browser.device.tablet?).to be_false
    expect(browser.device.mobile?).to be_true
    expect(browser.full_version).to eq("4.1.0")
    expect(browser.version).to eq("4")
  end

  provided name = "BLACKBERRY4" do
    expect(browser.name).to eq("BlackBerry")
    expect(browser.full_version).to eq("4.2.1")
    expect(browser.version).to eq("4")
  end

  provided name = "BLACKBERRY5" do
    expect(browser.name).to eq("BlackBerry")
    expect(browser.full_version).to eq("5.0.0.93")
    expect(browser.version).to eq("5")
  end

  provided name = "BLACKBERRY6" do
    expect(browser.name).to eq("BlackBerry")
    expect(browser.full_version).to eq("6.0.0.141")
    expect(browser.version).to eq("6")
  end

  provided name = "BLACKBERRY7" do
    expect(browser.name).to eq("BlackBerry")
    expect(browser.full_version).to eq("7.0.0.1")
    expect(browser.version).to eq("7")
  end

  provided name = "BLACKBERRY10" do
    expect(browser.name).to eq("BlackBerry")
    expect(browser.full_version).to eq("10.0.9.1675")
    expect(browser.version).to eq("10")

    expect(browser.platform.blackberry?("~> 10.0")).to be_true
    expect(browser.platform.blackberry?("~> 7.0")).to be_false
  end

  provided name = "PLAYBOOK" do
    expect(browser.platform.android?).to be_false
    expect(browser.device.tablet?).to be_true
    expect(browser.device.mobile?).to be_false
    expect(browser.full_version).to eq("7.2.1.0")
    expect(browser.version).to eq("7")
  end

  # # CHROME ###################################################################
  provided name = "CHROME" do
    expect(browser.name).to eq("Chrome")
    expect(browser.chrome?).to be_true
    expect(browser.safari?).to be_false
    expect(browser.webkit?).to be_true
    expect(browser.full_version).to eq("5.0.375.99")
    expect(browser.version).to eq("5")
    expect(browser.chromium_based?).to be_true

    expect(browser.chrome?(">=5 <6")).to be_true
  end

  provided name = "MOBILE_CHROME" do
    expect(browser.name).to eq("Chrome")
    expect(browser.chrome?).to be_true
    expect(browser.safari?).to be_false
    expect(browser.webkit?).to be_true
    expect(browser.full_version).to eq("19.0.1084.60")
    expect(browser.version).to eq("19")
  end

  provided name = "SAMSUNG_CHROME" do
    expect(browser.name).to eq("Chrome")
    expect(browser.chrome?).to be_true
    expect(browser.platform.android?).to be_true
    expect(browser.safari?).to be_false
    expect(browser.webkit?).to be_true
    expect(browser.full_version).to eq("28.0.1500.94")
    expect(browser.version).to eq("28")
  end

  provided name = "CHROME_OS" do
    expect(browser.platform.chrome_os?).to be_true
  end

  provided name = "IE9_CHROME_FRAME" do
    expect(browser.name).to eq("Chrome")
    expect(browser.chrome?).to be_true
    expect(browser.safari?).to be_false
    expect(browser.webkit?).to be_true
    expect(browser.full_version).to eq("26.0.1410.43")
    expect(browser.version).to eq("26")
  end

  provided name = "ANDROID_Q" do
    expect(browser.chrome?).to be_true
    expect(browser.name).to eq("Chrome")
    expect(browser.platform.android?).to be_true
    expect(browser.version).to eq("78")
  end

  # # CONSOLES #################################################################
  provided name = "PSP" do
    expect(browser.name).to eq("Unknown Browser")
  end

  provided name = "PSP_VITA" do
    expect(browser.name).to eq("Unknown Browser")
  end
end
