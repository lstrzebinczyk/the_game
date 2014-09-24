class TheGame
  class Action
    class LookForTreeToCut < Action
      def self.create
        stash_tile = TheGame::Settlement.instance.stash_tile
        Action::Get.create(:axe, from: stash_tile).then(new)
      end

      def description
        "looking for food"
      end

      def type
        :woodcutting
      end

      def perform(person, map, time_in_minutes)
        # if person.has?(:axe)
          closest = map.find_closest_to(person) do |tile|
            tile.has_tree?
          end

          if closest
            person.action = Action::CutTree.create(closest)
          end
        # else
        #   stash_tile = TheGame::Settlement.instance.stash_tile
        #   if person.distance_to(stash_tile) < 2.0
        #     axe = TheGame::Settlement.instance.stash.get(:axe)
        #     person.inventory.add(axe)
        #   else
        #     person.go_to(stash_tile)
        #   end
        # end
      end
    end
  end
end
