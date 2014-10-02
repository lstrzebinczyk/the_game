class TheGame
  class Action
    class LookForSomethingToDrink < Action
      def description
        "looking for something to drink"
      end

      def perform(person, map, time_in_minutes)
        if person.waterskin.any?
          person.action = Action::DrinkFromWaterskin.create()
        else
          closest = map.find_closest_to(person) do |tile|
            tile.terrain == :river
          end

          action = Action::GoTo.create(closest).then(Action::DrinkFromRiver.create())
          person.action = action
        end
      end
    end
  end
end
