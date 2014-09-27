class TheGame
  class Action
    class Harvest < Action
      def initialize(food_provider)
        @food_provider = food_provider
        @minutes_left = 60
      end

      def description
        x = @food_provider.x
        y = @food_provider.y
        "harvesting berries at #{x}, #{y}"
      end

      def perform(person, map, time_in_minutes)
        if @minutes_left == 0
          harvested_food = Item::Berries.new
          person.inventory.add(harvested_food)
          stash = TheGame::Settlement.instance.stash
          person.action = Action::Carry.create(:berries, to: stash)
        else
          @minutes_left -= time_in_minutes
        end
      end
    end
  end
end
