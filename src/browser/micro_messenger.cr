module Browser
  class MicroMessenger < Base
    def id : String
      "micro_messenger"
    end

    def name : String
      "MicroMessenger"
    end

    def full_version : String
      ua[%r{(?:MicroMessenger)/([\d.]+)}i, 1]? || "0.0"
    end

    def match? : Bool
      !!(ua =~ /MicroMessenger/i)
    end
  end
end
