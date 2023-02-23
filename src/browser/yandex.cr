module Browser
  class Yandex < Base
    def id : String
      "yandex"
    end

    def name : String
      "Yandex"
    end

    def full_version : String
      ua[%r{YaBrowser/([\d.]+)}, 1]? || "0.0"
    end

    def match? : Bool
      ua.includes?("YaBrowser")
    end
  end
end
