module Browser
  class Edge < InternetExplorer
    def id : String
      "edge"
    end

    def name : String
      "Microsoft Edge"
    end

    def full_version : String
      ua[%r{(?:Edge|Edg|EdgiOS|EdgA)/([\d.]+)}, 1]? || super
    end

    def match? : Bool
      !!(ua =~ %r{((?:Edge|Edg|EdgiOS|EdgA)/[\d.]+|Trident/8)})
    end

    def chrome_based?
      match? && !!(ua =~ /\bEdg\b/)
    end
  end
end
