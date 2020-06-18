module Browser
  class Electron < Base
    def id : String
      "electron"
    end

    def name : String
      "Electron"
    end

    def full_version : String
      ua[%r{Electron/([\d.]+)}, 1]? ||
        "0.0"
    end

    def match? : Bool
      !!(ua =~ /Electron/)
    end
  end
end
