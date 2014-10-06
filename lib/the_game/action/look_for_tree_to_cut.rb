class TheGame
  class Action
    class LookForTreeToCut < Action
      def self.create
        stash = TheGame::Settlement.instance.stash
        Action::Get.create(:axe, from: stash)
          .then(new)
      end

      def description
        "looking for tree to cut"
      end

      def type
        :woodcutting
      end

      def done?(person)
        false
      end

      def perform(person, map, time_in_minutes)
        closest_tree = map.find_closest_to(person) do |tile|
          tile.content.is_a? Nature::Tree
        end

        if closest_tree
          person.action = Action::CutTree.create(closest_tree.content)
        end
      end
    end
  end
end
