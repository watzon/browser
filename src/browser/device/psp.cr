module Browser
  class Device
    class PSP < Base
      def id : String
        "psp"
      end

      def name : String
        "PlayStation Portable"
      end

      def match? : Bool
        ua.includes?("PlayStation Portable")
      end
    end
  end
end
