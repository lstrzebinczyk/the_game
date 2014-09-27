class TheGame
  class Action
    class CutTree < Action
      def self.create(tile)
        GoTo.create(tile).then(new(tile))
      end

      def initialize(tile)
        @tile = tile
        @seconds_left = 180 * 60
      end

      def type
        :woodcutting
      end

      def description
        x = @tile.x
        y = @tile.y
        "cutting tree at #{x}, #{y}"
      end

      def perform(person, map, time_in_seconds)
        @seconds_left -= time_in_seconds

        if @seconds_left == 0
          @tile.clear
          settlement = Settlement.instance
          settlement.fallen_trees << TheGame::Construction::FallenTree.new(@tile.x, @tile.y)
          person.action = Action::Carry.create(:axe, to: settlement.stash)
        end
      end
    end
  end
end
