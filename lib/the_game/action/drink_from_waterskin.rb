class TheGame
  class Action
    class DrinkFromWaterskin < Action
      def description
        "drinking from waterskin"
      end

      def perform(person, map, time_in_minutes)
        if person.done_drinking?
          person.do_stuff
        else
          if person.waterskin.any?
            drink = person.waterskin.get_drink
            person.drink(drink)
          else
            # oh boy...
            closest = map.find_closest_to(person) do |tile|
              tile.terrain == :river
            end
            action = Action::GoTo.create(closest)
              .then(Action::DrinkFromRiver.create())
              .then(Action::FillWaterskin.create())
            action.description = "refilling waterskin"
            person.action = action
          end
        end
      end

      def done?(person)
        false
      end
    end
  end
end
