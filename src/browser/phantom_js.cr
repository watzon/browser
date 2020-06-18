module Browser
  class PhantomJS < Base
    def id : String
      "phantom_js"
    end

    def name : String
      "PhantomJS"
    end

    def full_version : String
      ua[%r{PhantomJS/([\d.]+)}, 1]? || "0.0"
    end

    def match? : Bool
      !!(ua =~ /PhantomJS/)
    end
  end
end
