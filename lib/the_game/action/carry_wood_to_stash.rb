class TheGame
  class Action
    class CarryWoodToStash
      def initialize(parent_tile)
        @parent_tile = parent_tile
      end

      def description
        "carrying wood to stash..."
      end

      def type
        :haul
      end

      def perform(person, map, time_in_minutes)
        if person.has_firewood?
          stash_tile = TheGame::Settlement.instance.stash_tile
          stash = TheGame::Settlement.instance.stash
          if person.distance_to(stash_tile) < 2.0
            firewood = person.inventory.get_firewood
            stash.add(firewood)
            person.do_stuff
          else
            person.go_to(stash_tile)
          end
        else
          if person.distance_to(@parent_tile) < 2.0
            firewood = @parent_tile.get_firewood
            person.inventory.add(firewood)
          else
            person.go_to(@parent_tile)
          end
        end
      end
    end
  end
end
