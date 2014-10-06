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
        person.drink(Item::Water.new)
      end
    end
  end
end
