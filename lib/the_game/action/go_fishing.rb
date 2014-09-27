class TheGame
  class Action
    class GoFishing
      def self.create
        stash = TheGame::Settlement.instance.stash
        Action::Get.create(:fishing_rod, from: stash, then_action: new)
      end

      def description
        "going fishing"
      end

      def type
        :fisherman
      end

      def perform(person, map, time_in_seconds)
        closest = map.find_closest_to(person) do |tile|
          tile.content.is_a? Map::Tile::River
        end

        person.action = Action::GoTo.create(closest).then(Action::CatchFish.create())
      end
    end
  end
end
