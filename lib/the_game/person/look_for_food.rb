class TheGame
  class Person
    class LookForFood
      def description
        "looking for food"
      end

      def perform(person, map, time_in_minutes)
        unless @stash_checked
          check_stash(person, map)
        else
          find_for_harvest(person, map)
        end
      end

      private

      def check_stash(person, map)
        stash_tile = TheGame::Settlement.instance.stash_tile
        stash      = TheGame::Settlement.instance.stash

        if person.distance_to(stash_tile) < 2.0
          if stash.has_food?
            food = stash.get_food
            person.action = Eat.new(food)
            return
          end
          @stash_checked = true
        else
          person.go_to(stash_tile)
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
