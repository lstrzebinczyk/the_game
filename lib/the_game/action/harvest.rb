class TheGame
  class Action
    class Harvest
      def initialize(tile)
        @tile = tile
        @minutes_left = 60
      end

      def description
        x = @tile.x
        y = @tile.y
        "harvesting food at #{x}, #{y}"
      end

      def perform(person, map, time_in_minutes)
        if @minutes_left == 0
          harvested_food = Item::Food.new
          person.inventory.add(harvested_food)
          person.action = Action::CarryFoodToStash.new
        else
          @minutes_left -= time_in_minutes
        end
      end
    end
  end
end
