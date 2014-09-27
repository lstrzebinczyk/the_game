class TheGame
  class Action
    class DrinkFromRiver < Action
      def description
        "drinking water from river"
      end

      def perform(person, map, time_in_seconds)
        if person.done_drinking?
          person.do_stuff
        else
          # how much can you satisfy your thirs when drinking water from the river per second?
          person.thirst += (0.001 * time_in_seconds)
        end
      end
    end
  end
end
