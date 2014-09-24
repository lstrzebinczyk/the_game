class TheGame
  class Action
    class LookForFood
      def description
        "looking for food"
      end

      def perform(person, map, time_in_minutes)
        check_stash(person, map)
      end

      private

      def check_stash(person, map)
        stash_tile = TheGame::Settlement.instance.stash_tile
        stash      = TheGame::Settlement.instance.stash

        if person.distance_to(stash_tile) < 2.0
          if stash.has?(:food)
            food = stash.get(:food)
            person.action = Eat.new(food)
            return
          else
            person.action = Action::LookForFoodToHarvest.new
          end
        else
          person.go_to(stash_tile)
        end
      end
    end
  end
end
