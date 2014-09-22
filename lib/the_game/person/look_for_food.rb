class TheGame
  class Person
    class LookForFood
      def description
        "looking for food"
      end

      def perform(person, map)
        check_stash(person, map)
        find_for_harvest(person, map)
      end

      private

      def check_stash(person, map)
        stash = person.stash_tile.content.stash

        if person.is_standing_near_stash?
          if stash.has_food?
            food = stash.get_food
            person.action = Eat.new(food)
            return
          end
        else
          person.go_to(person.stash_tile)
        end
      end

      def find_for_harvest(person, map)
        closest = map.find {|tile| tile.has_food? }

        if closest
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
end
