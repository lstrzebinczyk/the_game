class TheGame
  class Action
    class CatchFish < Action
      def initialize
        @seconds_spent_already = 0
      end

      def description
        "trying to catch fish"
      end

      def type
        :fisherman
      end

      def perform(person, map, time_in_seconds)
        @seconds_spent_already += time_in_seconds

        #random chance on catching something

        chance_per_second = 1.0 / 5000

        if rand < (chance_per_second * time_in_seconds)
          catched_fish = Item::Fish.new
          person.inventory.add(catched_fish)
          stash = TheGame::Settlement.instance.stash

          action = Action::Carry.create([:fish, :fishing_rod], to: stash)
          person.action = action
        end

        # fuck that and go take care of your stuff
        if @seconds_spent_already > 90 * 60
          stash = TheGame::Settlement.instance.stash
          person.action = Action::Carry.create(:fishing_rod, to: stash)
        end
      end
    end
  end
end
