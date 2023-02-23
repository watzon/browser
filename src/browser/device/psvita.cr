module Browser
  class Device
    class PSVita < Base
      def id : String
        "psvita"
      end

      def name : String
        "PlayStation Vita"
      end

      def match? : Bool
        ua.includes?("Playstation Vita")
      end
    end
  end
end
