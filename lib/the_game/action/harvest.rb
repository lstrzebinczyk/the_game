class TheGame
  class Action
    class Harvest < Action
      def initialize(tile)
        @tile = tile
        @seconds_left = 60 * 60
      end

      def description
        x = @tile.x
        y = @tile.y
        "harvesting food at #{x}, #{y}"
      end

      def perform(person, map, time_in_seconds)
        if @seconds_left == 0
          harvested_food = Item::Food.new
          person.inventory.add(harvested_food)
          stash = TheGame::Settlement.instance.stash
          person.action = Action::Carry.create(:food, to: stash)
        else
          @seconds_left -= time_in_seconds
        end
      end
    end
  end
end
