class TheGame
  class Action
    class LookForFoodToHarvest < Action
      def description
        "looking for food"
      end

      def type
        :gatherer
      end

      def perform(person, map, time_in_minutes)
        closest = map.find_closest_to(person) do |tile|
          tile.has_food?
        end

        if closest
          person.action = Action::FetchFood.create(closest)
        end
      end
    end
  end
end
