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
        if person.has?(:firewood)
          stash_tile = TheGame::Settlement.instance.stash_tile
          person.action = Action::Carry.new(:firewood, to: stash_tile)
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
