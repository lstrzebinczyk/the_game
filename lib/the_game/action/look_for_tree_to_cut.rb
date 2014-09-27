class TheGame
  class Action
    class LookForTreeToCut < Action
      def self.create
        stash = TheGame::Settlement.instance.stash
        Action::Get.create(:axe, from: stash, then_action: new)
      end

      def description
        "looking for tree to cut"
      end

      def type
        :woodcutting
      end

      def perform(person, map, time_in_minutes)
        closest = map.find_closest_to(person) do |tile|
          tile.content.is_a? Nature::Tree
        end

        if closest
          person.action = Action::CutTree.create(closest.content)
        end
      end
    end
  end
end
