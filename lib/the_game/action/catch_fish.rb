class TheGame
  class Action
    class CatchFish < Action
      def initialize
        @minutes_spent_already = 0
      end

      def description
        "trying to catch fish"
      end

      def type
        :fisherman
      end

      def done?(person)
        false
      end

      def perform(person, map, time_in_minutes)
        @minutes_spent_already += time_in_minutes

        #random chance on catching something
        if rand < (0.02 * time_in_minutes)
          catched_fish = Item::Fish.new
          person.inventory.add(catched_fish)
          stash = TheGame::Settlement.instance.stash

          action = Action::Carry.create([:fish, :fishing_rod], to: stash)
          person.action = action
        end

        # fuck that and go take care of your stuff
        if @minutes_spent_already > 90
          stash = TheGame::Settlement.instance.stash
          person.action = Action::Carry.create(:fishing_rod, to: stash)
        end
      end
    end
  end
end
