class TheGame
  class Person
    class CarryFoodToStash
      def description
        "carrying food to stash..."
      end

      def perform(person, map)
        stash_tile = person.stash_tile

        if person.close_enough_to(stash_tile)
          food = person.get_food_from_inventory
          stash_tile.content.stash << food
          person.action = WonderForNoReason.new
        else
          person.go_to(stash_tile)
        end
      end
    end
  end
end
