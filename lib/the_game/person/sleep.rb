class TheGame
  class Person
    class Sleep
      def initialize
        @minutes_left = 8 * 60
      end

      def description
        "sleeping..."
      end

      def perform(person, map, time_in_minutes)
        if @minutes_left == 0
          person.action = WonderForNoReason.new
        else
          person.energy += 3 * 0.00104167 * time_in_minutes #beta
          @minutes_left -= time_in_minutes
        end
      end
    end
  end
end
