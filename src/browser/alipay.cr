module Browser
  class Alipay < Base
    def id : String
      "alipay"
    end

    def name : String
      "Alipay"
    end

    def full_version : String
      ua[%r{(?:AlipayClient)/([\d.]+)}i, 1]? || "0.0"
    end

    def match? : Bool
      !!(ua =~ /AlipayClient/i)
    end
  end
end
