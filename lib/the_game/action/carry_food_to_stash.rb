class TheGame
  class Action
    class CarryFoodToStash
      def description
        "carrying food to stash..."
      end

      def perform(person, map, time_in_minutes)
        stash_tile = TheGame::Settlement.instance.stash_tile

        if person.close_enough_to(stash_tile)
          food = person.inventory.get_food
          stash_tile.content.stash << food
          person.action = Action::WonderForNoReason.new
        else
          person.go_to(stash_tile)
        end
      end
    end
  end
end
