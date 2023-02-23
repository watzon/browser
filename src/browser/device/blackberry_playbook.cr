module Browser
  class Device
    class BlackBerryPlaybook < Base
      def id : String
        "playbook"
      end

      def name : String
        "BlackBerry Playbook"
      end

      def match? : Bool
        ua.matches?(/PlayBook.*?RIM Tablet/)
      end
    end
  end
end
