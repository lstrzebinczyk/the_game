class TheGame
  class Action
    class FetchFood < Action
      def self.create(tile)
        GoTo.create(tile).then(new(tile))
      end

      def initialize(food_tile)
        @food_tile = food_tile
      end

      def description
        x = @food_tile.x
        y = @food_tile.y
        "fetching food at #{x}, #{y}"
      end

      def perform(person, map, time_in_minutes)
        if @food_tile.content.has?(:berries)
          @food_tile.content.get(:berries)
          person.action = Action::Harvest.create(@food_tile)
        else
          person.action = Action::LookForFoodToHarvest.create
        end
      end
    end
  end
end
