class TheGame
  class Action
    class CutTree < Action
      def self.create(tile)
        GoTo.create(tile).then(new(tile))
      end

      def initialize(tile)
        @tile = tile
        @minutes_left = 180
      end

      def type
        :woodcutting
      end

      def description
        x = @tile.x
        y = @tile.y
        "cutting tree at #{x}, #{y}"
      end

      def perform(person, map, time_in_minutes)
        @minutes_left -= time_in_minutes

        if @minutes_left == 0
          @tile.tree_cut
          stash_tile = TheGame::Settlement.instance.stash_tile

          @tile.content.firewood_left.times do
            new_job = Action::Get.create(:firewood, from: @tile, then_action: Action::Carry.create(:firewood, to: stash_tile))

            TheGame::Settlement.instance.add_job(new_job)
          end
          stash_tile = TheGame::Settlement.instance.stash_tile
          person.action = Action::Carry.create(:axe, to: stash_tile)
        end
      end
    end
  end
end
