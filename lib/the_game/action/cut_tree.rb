class TheGame
  class Action
    class CutTree < Action
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
        if person.distance_to(@tile) < 2.0
          @minutes_left -= time_in_minutes

          if @minutes_left == 0
            @tile.tree_cut
            stash_tile = TheGame::Settlement.instance.stash_tile

            @tile.content.firewood_left.times do
              new_job = Action::Get.create(:firewood, from: @tile)
              new_job.then(Action::Carry.create(:firewood, to: stash_tile))

              TheGame::Settlement.instance.add_job(new_job)
            end
            stash_tile = TheGame::Settlement.instance.stash_tile
            person.action = Action::Carry.create(:axe, to: stash_tile)
          end
        else
          person.go_to(@tile)
        end
      end
    end
  end
end
