require "../spec_helper"

class CustomDevice < Browser::Device::Base
  def match? : Bool
    ua.includes?("Custom")
  end

  def id : String
    "custom"
  end

  def name : String
    "Custom"
  end
end

Spectator.describe Browser::Device do
  it "extends matchers" do
    Browser::Device.matchers.unshift(CustomDevice)
    device = Browser::Device.new("Custom")
    expect(device.id).to eq("custom")
  end

  it "detects generic devices" do
    device = Browser::Device.new("")
    expect(device.unknown?).to be_true
    expect(device.id).to eq("unknown_device")
  end

  it "detects ipad" do
    device = Browser::Device.new(Browser["IOS9"])
    expect(device.ipad?).to be_true
    expect(device.id).to eq("ipad")
    expect(device.name).to eq("iPad")
  end

  it "detects old ipad" do
    device = Browser::Device.new(Browser["IOS3"])
    expect(device.ipad?).to be_true
    expect(device.id).to eq("ipad")
    expect(device.name).to eq("iPad")
  end

  it "detects ipod" do
    device = Browser::Device.new(Browser["IPOD"])
    expect(device.ipod_touch?).to be_true
    expect(device.ipod?).to be_true
    expect(device.id).to eq("ipod_touch")
    expect(device.name).to eq("iPod Touch")
  end

  it "detects iphone" do
    device = Browser::Device.new(Browser["IOS8"])
    expect(device.iphone?).to be_true
    expect(device.id).to eq("iphone")
    expect(device.name).to eq("iPhone")
  end

  it "detects ps3" do
    device = Browser::Device.new(Browser["PLAYSTATION3"])
    expect(device.ps3?).to be_true
    expect(device.playstation3?).to be_true
    expect(device.playstation?).to be_true
    expect(device.id).to eq("ps3")
    expect(device.name).to eq("PlayStation 3")
  end

  it "detects ps4" do
    device = Browser::Device.new(Browser["PLAYSTATION4"])
    expect(device.ps4?).to be_true
    expect(device.playstation4?).to be_true
    expect(device.playstation?).to be_true
    expect(device.id).to eq("ps4")
    expect(device.name).to eq("PlayStation 4")
  end

  it "detects xbox 360" do
    device = Browser::Device.new(Browser["XBOX360"])
    expect(device.console?).to be_true
    expect(device.xbox?).to be_true
    expect(device.xbox_360?).to be_true
    expect(device.xbox_one?).to be_false
    expect(device.id).to eq("xbox_360")
    expect(device.name).to eq("Xbox 360")
  end

  it "detects xbox one" do
    device = Browser::Device.new(Browser["XBOXONE"])
    expect(device.console?).to be_true
    expect(device.xbox?).to be_true
    expect(device.xbox_360?).to be_false
    expect(device.xbox_one?).to be_true
    expect(device.id).to eq("xbox_one")
    expect(device.name).to eq("Xbox One")
  end

  it "detects psp" do
    device = Browser::Device.new(Browser["PSP"])
    expect(device.psp?).to be_true
    expect(device.id).to eq("psp")
    expect(device.name).to eq("PlayStation Portable")
  end

  it "detects psvita" do
    device = Browser::Device.new(Browser["PSP_VITA"])
    expect(device.playstation_vita?).to be_true
    expect(device.id).to eq("psvita")
    expect(device.name).to eq("PlayStation Vita")
  end

  it "detects kindle" do
    device = Browser::Device.new(Browser["KINDLE"])
    expect(device.kindle?).to be_true
    expect(device.id).to eq("kindle")
    expect(device.name).to eq("Kindle")
    expect(device.silk?).to be_false
  end

  {% for key in %w[
                  KINDLE_FIRE
                  KINDLE_FIRE_HD
                  KINDLE_FIRE_HD_MOBILE
                ] %}
    it "detects {{key.id}}" do
      device = Browser::Device.new(Browser[{{key}}])
      expect(device.kindle?).to be_true
      expect(device.kindle_fire?).to be_true
      expect(device.id).to eq("kindle_fire")
      expect(device.name).to eq("Kindle Fire")
    end
  {% end %}

  it "detects wii" do
    device = Browser::Device.new(Browser["NINTENDO_WII"])
    expect(device.nintendo_wii?).to be_true
    expect(device.console?).to be_true
    expect(device.nintendo?).to be_true
    expect(device.wii?).to be_true
    expect(device.id).to eq("wii")
    expect(device.name).to eq("Nintendo Wii")
  end

  it "detects wiiu" do
    device = Browser::Device.new(Browser["NINTENDO_WIIU"])
    expect(device.nintendo_wiiu?).to be_true
    expect(device.wiiu?).to be_true
    expect(device.console?).to be_true
    expect(device.nintendo?).to be_true
    expect(device.id).to eq("wiiu")
    expect(device.name).to eq("Nintendo WiiU")
  end

  it "detects switch" do
    device = Browser::Device.new(Browser["NINTENDO_SWITCH"])
    expect(device.nintendo_switch?).to be_true
    expect(device.switch?).to be_true
    expect(device.console?).to be_true
    expect(device.nintendo?).to be_true
    expect(device.id).to eq("switch")
    expect(device.name).to eq("Nintendo Switch")
  end

  it "detects blackberry playbook" do
    device = Browser::Device.new(Browser["PLAYBOOK"])
    expect(device.playbook?).to be_true
    expect(device.blackberry_playbook?).to be_true
    expect(device.id).to eq("playbook")
    expect(device.name).to eq("BlackBerry Playbook")
  end

  it "detects surface" do
    device = Browser::Device.new(Browser["SURFACE"])
    expect(device.surface?).to be_true
    expect(device.id).to eq("surface")
    expect(device.name).to eq("Microsoft Surface")
  end

  it "detects tv" do
    device = Browser::Device.new(Browser["SMART_TV"])
    expect(device.tv?).to be_true
    expect(device.id).to eq("tv")
    expect(device.name).to eq("TV")
  end

  {% for key in %w[
                  ANDROID
                  SYMBIAN
                  MIDP
                  IPHONE
                  IPOD
                  WINDOWS_MOBILE
                  WINDOWS_PHONE
                  WINDOWS_PHONE8
                  WINDOWS_PHONE_81
                  OPERA_MINI
                  LUMIA800
                  MS_EDGE_MOBILE
                  UC_BROWSER
                  NOKIA
                  OPERA_MOBI
                  KINDLE_FIRE_HD_MOBILE
                ] %}
    it "detects {{key.id}}" do
      device = Browser::Device.new(Browser[{{key}}])
      expect(device.mobile?).to be_true
      expect(device.tablet?).to be_false
    end
  {% end %}

  {% for key in %w[
                  PLAYBOOK
                  IPAD
                  NEXUS_TABLET
                  SURFACE
                  XOOM
                  NOOK
                  SAMSUNG
                  FIREFOX_TABLET
                  NEXUS7
                ] %}
    it "detects {{key.id}}" do
      device = Browser::Device.new(Browser[{{key}}])
      expect(device.mobile?).to be_false
      expect(device.tablet?).to be_true
    end
  {% end %}

  {% for key, name in {
                        "ANDROID_CUPCAKE"      => "T-Mobile G1",
                        "ANDROID_DONUT"        => "SonyEricssonX10i",
                        "ANDROID_ECLAIR_21"    => "Nexus One",
                        "ANDROID_FROYO"        => "HTC_DesireHD_A9191",
                        "ANDROID_GINGERBREAD"  => "Sensation_4G",
                        "ANDROID_HONEYCOMB_30" => "Xoom",
                        "ANDROID_ICECREAM"     => "sdk",
                        "ANDROID_JELLYBEAN_41" => "Nexus S",
                        "ANDROID_JELLYBEAN_42" => "Nexus 10",
                        "ANDROID_JELLYBEAN_43" => "Nexus 7",
                        "CUSTOM_APP"           => "HTC Ruby",
                        "NOOK"                 => "NOOK BNTV250A",
                      } %}
    it "detects device name of {{key.id}} as {{name.id}}" do
      device = Browser::Device.new(Browser[{{key}}])
      expect(device.name).to eq({{name}})
    end
  {% end %}

  it "detects samsung devices" do
    device = Browser::Device.new(Browser["SAMSUNG_SM-G975F"])

    expect(device.samsung?).to be_true
    expect(device.id).to eq("samsung")
    expect(device.name).to eq("Samsung Galaxy S10+")
  end

  it "detects generic samsung devices" do
    device = Browser::Device.new(Browser["SAMSUNG_SM-FAKE"])

    expect(device.samsung?).to be_true
    expect(device.id).to eq("samsung")
    expect(device.name).to eq("Samsung SM-0000")
  end

  {% for key, name in {
                        "SAMSUNG_SM-G975F" => "Samsung Galaxy S10+",
                        "SAMSUNG_SM-G960F" => "Samsung Galaxy S9",
                        "SAMSUNG_SM-F700F" => "Samsung Galaxy Z Flip",
                      } %}
    it "detects device name of {{key.id}} as {{name.id}}" do
      device = Browser::Device.new(Browser[{{key}}])
      expect(device.name).to eq({{name}})
    end
  {% end %}
end
