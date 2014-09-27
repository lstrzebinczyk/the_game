class TheGame
  class Action
    class DrinkFromRiver < Action
      def description
        "drinking water from river"
      end

      def done?(person)
        person.done_drinking?
      end

      def perform(person, map, time_in_minutes)
        person.thirst += 0.05
      end
    end
  end
end
