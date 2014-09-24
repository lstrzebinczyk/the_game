class TheGame
  class Action
    class Sleep < Action
      def initialize
        @minutes_left = 8 * 60
      end

      def description
        "sleeping..."
      end

      def perform(person, map, time_in_minutes)
        if @minutes_left == 0
          person.do_stuff
        else
          # this will be ok for a sleep in sort-of-good conditions
          # person.energy += 3 * 0.00104167 * time_in_minutes #beta

          # sleeping on floor is way less refreshing
          person.energy += 2.5 * 0.00104167 * time_in_minutes #beta

          @minutes_left -= time_in_minutes
        end
      end
    end
  end
end
