class TheGame
  class Action
    class LookForFood < Action
      def self.create
        stash_tile = TheGame::Settlement.instance.stash_tile
        GoTo.create(stash_tile).then(new)
      end

      def description
        "looking for food"
      end

      def perform(person, map, time_in_minutes)
        check_stash(person, map)
      end

      private

      def check_stash(person, map)
        stash      = TheGame::Settlement.instance.stash

        if stash.has?(:food)
          food = stash.get(:food)
          person.action = Eat.create(food)
          return
        else
          person.action = Action::LookForFoodToHarvest.create
        end
      end
    end
  end
end
