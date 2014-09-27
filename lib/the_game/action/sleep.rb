class TheGame
  class Action
    class Sleep < Action
      def initialize(place)
        @place = place
        @seconds_left = 8 * 60 * 60
      end

      def description
        "sleeping in #{@place.description}"
      end

      def perform(person, map, time_in_seconds)
        if @seconds_left == 0
          person.do_stuff
        else
          person.energy += @place.energy_per_second_when_sleeping * time_in_seconds
          @seconds_left -= time_in_seconds
        end
      end
    end
  end
end
