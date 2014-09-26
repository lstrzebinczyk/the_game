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
          stash = TheGame::Settlement.instance.stash

          @tile.content.firewood_left.times do
            new_job = Action::Get.create(:firewood, from: @tile, then_action: Action::Carry.create(:firewood, to: stash))

            TheGame::Settlement.instance.add_job(new_job)
          end
          stash = TheGame::Settlement.instance.stash
          person.action = Action::Carry.create(:axe, to: stash)
        end
      end
    end
  end
end
