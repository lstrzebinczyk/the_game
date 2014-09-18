class TheGame
  class Person
    class LookForFood
      def description
        "looking for food"
      end

      def perform(person, map)
        closest = map.fetch(0, 0)
        map.each_tile do |tile|
          if tile.has_food?
            if person.distance_to(tile) < person.distance_to(closest)
              closest = tile
            end
          end
        end

        person.action = FetchFood.new(closest)
      end
    end
  end
end
