module Browser
  class Device
    class TV < Base
      def id : String
        "tv"
      end

      def name : String
        "TV"
      end

      def match? : Bool
        ua.matches?(/(\btv|Android.*?ADT-1|Nexus Player)/i)
      end
    end
  end
end
