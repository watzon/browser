require "../browser"

module Browser
  module Aliases
    PLATFORM_ALIASES = {
      :adobe_air?, :android?, :blackberry?, :chrome_os?, :firefox_os?, :ios?, :ios_app?,
      :ios_webview?, :linux?, :mac?, :windows10?, :windows7?, :windows8?, :windows8_1?,
      :windows?, :windows_mobile?, :windows_phone?, :windows_rt?,
      :windows_touchscreen_desktop?, :windows_vista?, :windows_wow64?, :windows_x64?,
      :windows_x64_inclusive?, :windows_xp?
    }

    DEVICE_ALIASES = {
      :blackberry_playbook?, :console?, :ipad?, :iphone?, :ipod_touch?, :kindle?,
      :kindle_fire?, :mobile?, :nintendo?, :nintendo_switch?, :nintendo_wii?,
      :nintendo_wiiu?, :playbook?, :playstation3?, :playstation4?, :playstation?,
      :playstation_vita?, :ps3?, :ps4?, :psp?, :psp_vita?, :silk?, :surface?, :tablet?, :tv?,
      :vita?, :wii?, :wiiu?, :xbox?, :xbox_360?, :xbox_one?
    }

    macro included
      {% for al in PLATFORM_ALIASES %}
        def {{ al.id }}
          platform.{{ al.id }}
        end
      {% end %}

      {% for al in DEVICE_ALIASES %}
        def {{ al.id }}
          device.{{ al.id }}
        end
      {% end %}
    end
  end
end
