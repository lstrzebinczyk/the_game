class TheGame
  class Action
    class DrinkFromRiver < Action
      def description
        "drinking water from river"
      end

      def perform(person, map, time_in_minutes)
        if person.done_drinking?
          person.do_stuff
        else
          person.thirst += 0.05
        end
      end
    end
  end
end
