module Browser
  class Snapchat < Base
    def id : String
      "snapchat"
    end

    def name : String
      "Snapchat"
    end

    def full_version : String
      ua[%r{Snapchat( ?|\/)([\d.]+)}, 2]? || "0.0"
    end

    def match? : Bool
      !!(ua =~ /Snapchat/)
    end
  end
end
