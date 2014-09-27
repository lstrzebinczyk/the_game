class TheGame
  class Action
    class LookForFood < Action
      def self.create
        stash = TheGame::Settlement.instance.stash
        GoTo.create(stash).then(new)
      end

      def description
        "looking for food"
      end

      def perform(person, map, time_in_minutes)
        check_stash(person, map)
      end

      private

      def check_stash(person, map)
        stash = TheGame::Settlement.instance.stash

        if stash.has?(:cooked_fish)
          cooked_fish = stash.get(:cooked_fish)
          person.action = Eat.create(cooked_fish)
          return
        elsif stash.has?(:berries)
          berries = stash.get(:berries)
          person.action = Eat.create(berries)
          return
        else
          person.action = Action::LookForFoodToHarvest.create
        end
      end
    end
  end
end
