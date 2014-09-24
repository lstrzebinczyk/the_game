class TheGame
  class Action
    class LookForTreeToCut < Action
      def self.create
        stash_tile = TheGame::Settlement.instance.stash_tile
        Action::Get.create(:axe, from: stash_tile, then_action: new)
      end

      def description
        "looking for food"
      end

      def type
        :woodcutting
      end

      def perform(person, map, time_in_minutes)
        closest = map.find_closest_to(person) do |tile|
          tile.has_tree?
        end

        if closest
          person.action = Action::CutTree.create(closest)
        end
      end
    end
  end
end
