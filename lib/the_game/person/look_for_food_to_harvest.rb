class TheGame
  class Person
    class LookForFoodToHarvest
      def description
        "looking for food"
      end

      def perform(person, map, time_in_minutes)
        closest = map.find_closest_to(person) do |tile|
          tile.has_food?
        end

        if closest
          person.action = FetchFood.new(closest)
        end
      end
    end
  end
end
