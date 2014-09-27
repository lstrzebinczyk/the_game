class TheGame
  class Action
    class FetchFood < Action
      def self.create(food_provider)
        GoTo.create(food_provider).then(new(food_provider))
      end

      def initialize(food_provider)
        @food_provider = food_provider
      end

      def description
        x = @food_provider.x
        y = @food_provider.y
        "fetching food at #{x}, #{y}"
      end

      def perform(person, map, time_in_minutes)
        if @food_provider.has?(:berries)
          @food_provider.get(:berries)
          person.action = Action::Harvest.create(@food_provider)
        else
          person.action = Action::LookForFoodToHarvest.create
        end
      end
    end
  end
end
